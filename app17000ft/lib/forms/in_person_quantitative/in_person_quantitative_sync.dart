import 'dart:convert';

import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_dialog.dart';
import 'package:app17000ft/components/custom_snackbar.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/in_person_quantitative/in_person_quantitative.dart';

import 'package:app17000ft/helper/database_helper.dart';
import 'package:app17000ft/services/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'in_person_quantitative_controller.dart';

class InPersonQuantitativeSync extends StatefulWidget {
  const InPersonQuantitativeSync({super.key});
  @override
  State<InPersonQuantitativeSync> createState() =>
      _InPersonQuantitativeSyncState();
}

class _InPersonQuantitativeSyncState extends State<InPersonQuantitativeSync> {
  final InPersonQuantitativeController _inPersonQuantitativeController =
      Get.put(InPersonQuantitativeController());
  final NetworkManager _networkManager = Get.put(NetworkManager());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    _inPersonQuantitativeController.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop =
            await BaseClient().showLeaveConfirmationDialog(context);
        return shouldPop;
      },
      child: Scaffold(
        appBar: const CustomAppbar(title: 'In Person Quantitative Sync'),
        body: GetBuilder<InPersonQuantitativeController>(
          builder: (inPersonQuantitativeController) {
            return Obx(() => isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : inPersonQuantitativeController.inPersonQuantitative.isEmpty
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
                          inPersonQuantitativeController
                                  .inPersonQuantitative.isNotEmpty
                              ? Expanded(
                                  child: ListView.separated(
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                    itemCount: inPersonQuantitativeController
                                        .inPersonQuantitative.length,
                                    itemBuilder: (context, index) {
                                      final item =
                                          inPersonQuantitativeController
                                              .inPersonQuantitative[index];
                                      return ListTile(
                                        title: Text(
                                          "${index + 1}. Tour ID: ${inPersonQuantitativeController.inPersonQuantitative[index].tourId!}\n    School:  ${inPersonQuantitativeController.inPersonQuantitative[index].school}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              color: AppColors.primary,
                                              icon: const Icon(Icons.edit),
                                              onPressed: () async {
                                                final existingRecord =
                                                    inPersonQuantitativeController
                                                            .inPersonQuantitative[
                                                        index];

                                                // Debug prints
                                                print(
                                                    'Navigating to IN Person Qualitative');
                                                print(
                                                    'Existing Record: $existingRecord');

                                                IconData icon = Icons.edit;

                                                // Show the confirmation dialog
                                                bool? shouldNavigate =
                                                    await showDialog<bool>(
                                                  context: context,
                                                  builder: (_) => Confirmation(
                                                    iconname: icon,
                                                    title: 'Confirm Update',
                                                    yes: 'Confirm',
                                                    no: 'Cancel',
                                                    desc:
                                                        'Are you sure you want to Update this record?',
                                                    onPressed: () {
                                                      // Close the dialog and return true to indicate confirmation
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    },
                                                  ),
                                                );

                                                // Check if the user confirmed the action
                                                if (shouldNavigate == true) {
                                                  // Debug print before navigation
                                                  print('Navigating now');

                                                  // Navigate to CabMeterTracingForm using Navigator.push
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          InPersonQuantitative(
                                                        userid: 'userid',
                                                        office: 'office',
                                                        existingRecord:
                                                            existingRecord,
                                                      ),
                                                    ),
                                                  );

                                                  // Debug print after navigation
                                                  print('Navigation completed');
                                                } else {
                                                  // User canceled the action
                                                  print('Navigation canceled');
                                                }
                                              },
                                            ),
                                            IconButton(
                                              color: AppColors.primary,
                                              icon: const Icon(Icons.sync),
                                              onPressed: () async {
                                                IconData icon =
                                                    Icons.check_circle;
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => Confirmation(
                                                        iconname: icon,
                                                        title: 'Confirm',
                                                        yes: 'Confirm',
                                                        no: 'Cancel',
                                                        desc: 'Are you sure you want to Sync?',
                                                        onPressed: () async {
                                                          setState(() {
                                                            // isLoadings= true;
                                                          });
                                                          if (_networkManager
                                                                  .connectionType
                                                                  .value ==
                                                              0) {
                                                            customSnackbar(
                                                                'Warning',
                                                                'You are offline please connect to the internet',
                                                                AppColors
                                                                    .secondary,
                                                                AppColors
                                                                    .onSecondary,
                                                                Icons.warning);
                                                          } else {
                                                            if (_networkManager
                                                                        .connectionType
                                                                        .value ==
                                                                    1 ||
                                                                _networkManager
                                                                        .connectionType
                                                                        .value ==
                                                                    2) {
                                                              print(
                                                                  'ready to insert');
                                                              var rsp = await insertInPersonQuantitativeRecords(
                                                                  item.tourId,
                                                                  item.school,
                                                                  item.udiseCode,
                                                                  item.correctUdise,
                                                                  item.noOfEnrolled,
                                                                  item.image,
                                                                  item.isDigilabSchedule,
                                                                  item.Schedule2Hours,
                                                                  item.instrucRegardingClass,
                                                                  item.remarksOnDigiLab,
                                                                  item.admin_appointed,
                                                                  item.admin_trained,
                                                                  item.admin_name,
                                                                  item.admin_number,
                                                                  item.subjectTeachersTrained,
                                                                  item.idsOnTheTabs,
                                                                  item.teacherComfortUsingTab,
                                                                  item.staffAttendedTraining,
                                                                  item.image2,
                                                                  item.otherTopics,
                                                                  item.practicalDemo,
                                                                  item.reasonPracticalDemo,
                                                                  item.commentOnTeacher,
                                                                  item.childComforUsingTab,
                                                                  item.childAbleToUndersContent,
                                                                  item.postTestByChild,
                                                                  item.teachHelpChild,
                                                                  item.digiLogBeFill,
                                                                  item.correcDigiLogFill,
                                                                  item.isReportDoneEachTab,
                                                                  item.facilitAppInstallPhone,
                                                                  item.dataSynced,
                                                                  item.dateOfDataSyn,
                                                                  item.libraryTimeTable,
                                                                  item.timeTableFollow,
                                                                  item.registerUpdated,
                                                                  item.additiObservLibrary,
                                                                  item.uid,
                                                                  item.createdAt,
                                                                  item.office,
                                                                  item.version,
                                                                  item.uniqueId,
                                                                  item.participantsData,
                                                                  item.issueAndResolution,
                                                                  item.refreshTrainTopic,
                                                                  item.id);
                                                              if (rsp['status'] ==
                                                                  1) {
                                                                customSnackbar(
                                                                    'Successfully',
                                                                    "${rsp['message']}",
                                                                    AppColors
                                                                        .secondary,
                                                                    AppColors
                                                                        .onSecondary,
                                                                    Icons
                                                                        .check);
                                                              } else if (rsp[
                                                                      'status'] ==
                                                                  0) {
                                                                customSnackbar(
                                                                    "Error",
                                                                    "${rsp['message']}",
                                                                    AppColors
                                                                        .error,
                                                                    AppColors
                                                                        .onError,
                                                                    Icons
                                                                        .warning);
                                                              } else {
                                                                customSnackbar(
                                                                    "Error",
                                                                    "Something went wrong, Please contact Admin",
                                                                    AppColors
                                                                        .error,
                                                                    AppColors
                                                                        .onError,
                                                                    Icons
                                                                        .warning);
                                                              }
                                                            }
                                                          }
                                                        }));
                                              },
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          inPersonQuantitativeController
                                              .inPersonQuantitative[index]
                                              .tourId;
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

Future insertInPersonQuantitativeRecords(
  String? tour,
  String? school,
  String? udiseCode,
  String? correctUdise,
  String? image,
  String? noOfEnrolled,
  String? isDigilabSchedule,
  String? Schedule2Hours,
  String? instrucRegardingClass,
  String? remarksOnDigiLab,
  String? admin_appointed,
  String? admin_trained,
  String? admin_name,
  String? admin_number,
  String? subjectTeachersTrained,
  String? idsOnTheTabs,
  String? teacherComfortUsingTab,
  String? staffAttendedTraining,
  String? image2,
  String? otherTopics,
  String? practicalDemo,
  String? reasonPracticalDemo,
  String? commentOnTeacher,
  String? childComforUsingTab,
  String? childAbleToUndersContent,
  String? postTestByChild,
  String? teachHelpChild,
  String? digiLogBeFill,
  String? correcDigiLogFill,
  String? isReportDoneEachTab,
  String? facilitAppInstallPhone,
  String? dataSynced,
  String? dateOfDataSyn,
  String? libraryTimeTable,
  String? timeTableFollow,
  String? registerUpdated,
  String? additiObservLibrary,
  String? participantsData,
  String? issueAndResolution,
  String? refreshTrainTopic,
  String? uid,
  String? createdAt,
  String? office,
  String? version,
  String? uniqueId,
  int? id,
) async {
  print('this is In person quantitative DAta');
  print(tour);
  print(school);

  var request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseurl}insert_cdpo_survey2024.php')
  );
  request.headers["Accept"] = "Application/json";

  // Add text fields
  request.fields.addAll({});


  try {
    var response = await request.send();
    var parsedResponse;

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      parsedResponse = json.decode(responseBody);
      if (parsedResponse['status'] == 1) {
        await SqfliteDatabaseHelper().queryDelete(
          arg: id.toString(),
          table: 'cabMeter_tracing',
          field: 'id',
        );

        await Get.find<InPersonQuantitativeController>().fetchData();
      }
    } else {
      var responseBody = await response.stream.bytesToString();
      parsedResponse = json.decode(responseBody);
      print('this is by cdpo firm');
      print(responseBody);
    }
    return parsedResponse;
  } catch (error) {
    print("Error: $error");
    return {"status": 0, "message": "Something went wrong, Please contact Admin"};
  }
}
