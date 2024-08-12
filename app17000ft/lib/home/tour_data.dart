import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/helper/api_services.dart';
import 'package:app17000ft/home/home_controller.dart';
import 'package:app17000ft/tourDetails/tour_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SelectTourData extends StatefulWidget {
  const SelectTourData({super.key});

  @override
  State<SelectTourData> createState() => _SelectTourDataState();
}



class _SelectTourDataState extends State<SelectTourData> {


  @override
void initState(){
  super.initState();
  HomeController().getData();
 
 
  // Load data here
}
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await BaseClient().showLeaveConfirmationDialog(context);
        return shouldPop;
      },
      child: Scaffold(
        appBar:  const CustomAppbar(title: 'Select Tour ID '),
        body:  GetBuilder<HomeController>(
      init: HomeController(),
      builder: (homeController) {
       
     
        return SizedBox(
        //  height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             SizedBox(
              height: 700,
               child: ListView.builder(
                itemCount: homeController.onlineTourList.length,
                itemBuilder: (BuildContext context, int index, 
               ) {
                return ListTile(
                  leading: Text(homeController.onlineTourList[index].tourId.toString()),
                );
                 
               }),
             )
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   child:  Text('lenght of tour list ${tourController.localTourList.length}'),
              // ),
            ],
          ),
        );
      }
    )));
  }
}