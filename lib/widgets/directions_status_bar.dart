import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_maps_navigation_tuts_o/controllers/home_controller.dart';
import 'package:google_maps_navigation_tuts_o/controllers/navigation_controller.dart';
import 'package:google_maps_navigation_tuts_o/utils/constants.dart';
// ignore: implementation_imports

import '../models/directions_model.dart';

class DirectionsStatusBar extends StatelessWidget {
  const DirectionsStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.find();
    HomeController homeController = Get.find();
    return Obx((){
    if(navigationController.directions.isEmpty) return Container();
    DirectionModel directionModel = DirectionModel.fromJson(navigationController.directions[0]);
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ]),
            child: homeController.arrived.value ? const Align(
              alignment: Alignment.center,
              child: Text("You've Arrived!", style: TextStyle(fontSize: 20, color: Colors.white),),
            )  : Row(
              children: [
                 Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10),
                  child:  Icon(getIcon(directionModel.instructions!), color: Colors.white, size: 25,),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Html(data:"""<span>${directionModel.instructions}</span>""",
                      style: {
                        'span':Style(color: Colors.white)
                      }
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  IconData getIcon(String instruction){
    if(instruction.contains(Constants.northWest)){
      return Icons.north_west;
    }else if(instruction.contains(Constants.northEast)){
      return Icons.north_east;
    }else if(instruction.contains(Constants.southEast)){
      return Icons.south_east;
    }else if(instruction.contains(Constants.southWest)){
      return Icons.south_west;
    }else if(instruction.contains(Constants.north) || instruction.contains(Constants.straight) ){
      return Icons.north;
    }else if(instruction.contains(Constants.west) || instruction.contains(Constants.left)){
      return Icons.west;
    }else if(instruction.contains(Constants.east) || instruction.contains(Constants.right)){
      return Icons.east;
    }else if(instruction.contains(Constants.south)){
      return Icons.south;
    }
    return Icons.north;
  }
}
