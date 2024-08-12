import 'dart:convert';

import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_dialog.dart';
import 'package:app17000ft/components/custom_snackbar.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_controller.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:app17000ft/services/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EnrolmentSync extends StatefulWidget {
  const EnrolmentSync({super.key});

  @override
  State<EnrolmentSync> createState() => _EnrolmentSyncState();
}

class _EnrolmentSyncState extends State<EnrolmentSync> {
  final SchoolEnrolmentController _schoolEnrolmentController = Get.put(SchoolEnrolmentController());
  final NetworkManager _networkManager = Get.put(NetworkManager());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _schoolEnrolmentController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await BaseClient().showLeaveConfirmationDialog(context);
        return shouldPop;
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'School Enrolment Sync'),
        body: GetBuilder<SchoolEnrolmentController>(
          builder: (schoolEnrolmentController) {
            return Obx(() => isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : schoolEnrolmentController.enrolmentList.isEmpty
                    ? const Center(
                        child: Text(
                          'No Records Found',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary),
                        ),
                      )
                    : Column(
                        children: [
                          schoolEnrolmentController.enrolmentList.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                    itemCount: schoolEnrolmentController.enrolmentList.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text("${schoolEnrolmentController.enrolmentList[index].tourId!}\n${schoolEnrolmentController.enrolmentList[index].school!}",style: const TextStyle(fontWeight: FontWeight.bold),),
                                        trailing: IconButton(
                                          color: AppColors.primary,
                                          icon: const Icon(Icons.sync),
                                          onPressed: () async {
                                             IconData icon = Icons.check_circle;
                                             showDialog(
                                          context: context,
                                          builder: (_) => Confirmation(  
                                              iconname: icon,
                                              title: 'Confirm',
                                              yes: 'Confirm',
                                              no: 'Cancel',
                                              desc:
                                                  'Are you sure you want to Sync?',
                                              onPressed: () async {
                                                setState(() {
                                                // isLoadings= true;
                                               });
                                            if (_networkManager.connectionType.value == 0) {
                                              customSnackbar(
                                                  'Warning',
                                                  'You are offline please connect to the internet',
                                                  AppColors.secondary,
                                                  AppColors.onSecondary,
                                                  Icons.warning);
                                            } else {
                                              if (_networkManager.connectionType.value == 1 ||
                                                  _networkManager.connectionType.value == 2) {
                                                print('ready to insert');
                                                var rsp = await insertEnrolment(
                                                  schoolEnrolmentController.enrolmentList[index].tourId,
                                                  schoolEnrolmentController.enrolmentList[index].school,
                                                  schoolEnrolmentController.enrolmentList[index].registerImage,
                                                  schoolEnrolmentController.enrolmentList[index].enrolmentData,
                                                  schoolEnrolmentController.enrolmentList[index].remarks,
                                                  schoolEnrolmentController.enrolmentList[index].createdAt,
                                                  schoolEnrolmentController.enrolmentList[index].submittedBy,
                                                  schoolEnrolmentController.enrolmentList[index].id
                                                  );
                                                if (rsp['status'] == 1) {
                                                  customSnackbar(
                                                      'Successfully',
                                                      "${rsp['message']}",
                                                      AppColors.secondary,
                                                      AppColors.onSecondary,
                                                      Icons.check);
                                                } else if (rsp['status'] == 0) {
                                                  customSnackbar(
                                                      "Error",
                                                      "${rsp['message']}",
                                                      AppColors.error,
                                                      AppColors.onError,
                                                      Icons.warning);
                                                } else {
                                                  customSnackbar(
                                                      "Error",
                                                      "Something went wrong, Please contact Admin",
                                                      AppColors.error,
                                                      AppColors.onError,
                                                      Icons.warning);
                                                }
                                              }
                                            }
                                              }));
                                              
                                          },
                                        ),
                                        onTap: () {
                                          schoolEnrolmentController.enrolmentList[index].tourId;
                                        },
                                      );
                                    },
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 340.0),
                                  child: Center(
                                    child: Text(
                                      'No Data Found',
                                      style: TextStyle(
                                          color: AppColors.primary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                        ],
                      ));
          },
        ),
      ),
    );
  }
}



  var baseurl = "https://mis.17000ft.org/apis/fast_apis/";

  Future insertEnrolment(
    String? tour,
    String? school,
    String? registerImage,
    String? enrolmentData,
    String? remarks,
    String? createdAt,
    String? createdBy,
    int? id,

  ) async {
    print('this is enrolment DAta');
    print( tour);
    print( school);
    print( registerImage);
    print( enrolmentData);
    print( remarks);
    print( createdAt);
    print( createdBy);
    print(id);
    
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseurl}insert_cdpo_survey2024.php'));
    request.headers["Accept"] = "Application/json";

    // Add text fields
    request.fields.addAll({
    
     


    });

    try {
      var response = await request.send();
      var parsedResponse;

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        parsedResponse = json.decode(responseBody);
        if (parsedResponse['status'] == 1) {
          await SqfliteDatabaseHelper().queryDelete(
            arg: id.toString(),
            table: 'new_enrolmentCollection',
            field: 'id',
          );

          await Get.find<SchoolEnrolmentController>().fetchData();
        }
      } else {
        var responseBody = await response.stream.bytesToString();
        parsedResponse = json.decode(responseBody);
        print('this is by cdpo firm');
        print(responseBody);
      }
      return parsedResponse;
    } catch (error) {}
  }

