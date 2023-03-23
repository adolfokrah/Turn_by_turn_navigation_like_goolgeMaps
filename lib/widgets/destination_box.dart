import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_navigation_tuts_o/controllers/home_controller.dart';

class DestinationBox extends StatelessWidget {
  const DestinationBox({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 40,bottom: 20),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                 homeController.clearDestination();
              },
              icon: const Icon(CupertinoIcons.back)
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(6)
              ),
              padding: const EdgeInsets.all(10),
              child: Obx(()=>Text(homeController.destination.value, overflow: TextOverflow.ellipsis, maxLines: 1,)),
            ),
          ),
          const SizedBox(width: 10,),
        ],
      ),
    );
  }
}
