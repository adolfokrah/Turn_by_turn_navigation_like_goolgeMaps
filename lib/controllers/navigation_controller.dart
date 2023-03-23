import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_navigation_tuts_o/controllers/home_controller.dart';
import 'package:google_maps_navigation_tuts_o/utils/constants.dart';
import 'package:google_maps_utils/google_maps_utils.dart';

class NavigationController extends GetxController {
  HomeController homeController = Get.find();
  late StreamSubscription<Position> positionStream;
  var oldLatitude = 0.0.obs;
  var oldLongitude = 0.0.obs;
  var directions = [].obs;

  navigateToDestination() async {
    homeController.mapStatus.value = Constants.onDestination;
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position)async{
              LatLng newPosition = LatLng(position!.latitude, position.longitude);
              homeController.addDriverMarker(LatLng(oldLatitude.value, oldLongitude.value), newPosition);
              oldLatitude.value = position.latitude;
              oldLongitude.value = position.longitude;
             homeController.moveMapCamera(newPosition, zoom: 15.47, bearing: position.heading);
             homeController.getTotalDistanceAndTime(homeController.destinationCoordinates);
             bool isOnRoute = getRouteDeviation(newPosition);
             if(!isOnRoute || directions.isEmpty){
              await homeController.drawRoute(homeController.destinationCoordinates);
              await getDirections(LatLng(position.latitude, position.longitude), homeController.destinationCoordinates);
             }
            getNextDirection(LatLng(position.latitude, position.longitude));
    });
  }

  stopNavigation()async{
    positionStream.cancel();
    homeController.mapStatus.value = Constants.route;
    homeController.positionCameraToRoute(homeController.polyline);
    homeController.markers.remove(const MarkerId("driverMarker"));
  }

  getRouteDeviation(LatLng location) {
    List<Point<num>> points = [];
    List<LatLng> list = homeController.polylineCoordinates.toList();
    for (var i = 0; i < list.length; i++) {
      points.add(Point(list[i].latitude, list[i].longitude));
    }
    bool r = PolyUtils.isLocationOnEdgeTolerance(
        Point(location.latitude, location.longitude), points, false, 100);

    return r;
  }

    getDirections(LatLng from, LatLng to) async {
    String origin = "${from.latitude},${from.longitude}";
    String destinations = "${to.latitude},${to.longitude}";
    Dio dio = Dio();
    var response = await dio.get(
        "https://maps.googleapis.com/maps/api/directions/json?units=imperial&origin=$origin&destination=$destinations&key=${dotenv.env['GOOGLE_MAPS_API_KEY']}");
    var data = response.data;

    final dir = data['routes'][0]['legs'][0]['steps']
        .map((h) => {
              "instructions": h['html_instructions'],
              "distance": h['start_location']
            })
        .toList();
    directions.value = [...dir];
    update();
  }

    getNextDirection(LatLng from) {
    if (directions.length > 1) {
      var closestDirectionIndex = directions.where((direction) =>
          SphericalUtils.computeDistanceBetween(
              Point(from.latitude, from.longitude),
              Point(
                  direction['distance']['lat'], direction['distance']['lng'])) <
          7);
      if (closestDirectionIndex.isNotEmpty) {
        directions.removeAt(0);
        update();
      }
    }
  }
}
