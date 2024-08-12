import 'dart:convert';
import 'dart:io';

import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_button.dart';
import 'package:app17000ft/components/custom_imagepreview.dart';
import 'package:app17000ft/components/custom_snackbar.dart';
import 'package:app17000ft/components/custom_textField.dart';
import 'package:app17000ft/components/error_text.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_model.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:app17000ft/helper/responsive_helper.dart';
import 'package:app17000ft/tourDetails/tour_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:app17000ft/base_client/base_client.dart';
import 'package:app17000ft/components/custom_dropdown.dart';
import 'package:app17000ft/components/custom_labeltext.dart';
import 'package:app17000ft/components/custom_sizedBox.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_controller.dart';
import 'package:app17000ft/home/home_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'in_person_quantitative.dart';
import 'in_person_quantitative_controller.dart';
import 'in_person_quantitative_modal.dart';

class InPersonQuantitative extends StatefulWidget {
  String? userid;
  String? office;
  final InPersonQuantitativeRecords? existingRecord;
  InPersonQuantitative({
    super.key,
    this.userid,
    String? office,
    this.existingRecord,
  });

  @override
  State<InPersonQuantitative> createState() => _InPersonQuantitativeState();
}

class _InPersonQuantitativeState extends State<InPersonQuantitative> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showBasicDetails = true; // For show Basic Details
  bool showDigiLabSchedule = false; // For show and hide DigiLab Schedule
  bool showTeacherCapacity = false; // For show and hide Teacher Capacity
  bool showSchoolRefresherTraining =
      false; // For show and hide School Refresher training
  bool showDigiLabClasses = false; // For show and hide DigiLab Classes
  bool showLibrary = false; // For show and hide Library

  List<String> splitSchoolLists = [];
  String? _selectedValue = ''; // For the UDISE code
  String? _selectedValue2 = ''; // For the DigiLab timetable available
  String? _selectedValue3 = ''; // For the class scheduled for 2 hours per week
  String? _selectedValue4 = ''; // For the DigiLab admin appointed
  String? _selectedValue5 = ''; // For the Digilab admin trained
  String? _selectedValue6 = ''; // For the subject teacher trained
  String? _selectedValue7 = ''; // For the subject teacher Ids been created
  String? _selectedValue8 = ''; // For the teachers comfortable using the tabs
  String? _selectedValue9 = ''; // For the practical demo given
  String? _selectedValue10 = ''; // For the children comfortable using the tabs
  String? _selectedValue11 =
      ''; // For the children able to understand the content
  String? _selectedValue12 =
      ''; // For the post-tests being completed by children
  String? _selectedValue13 =
      ''; // For the teachers able to help children resolve doubts
  String? _selectedValue14 = ''; // For the digiLab logs being filled
  String? _selectedValue15 = ''; // For the the logs being filled correctly
  String? _selectedValue16 =
      ''; // For the the "Send Report" being done on each used tab
  String? _selectedValue17 =
      ''; // For the the Facilitator App installed and functioning
  String? _selectedValue18 = ''; // For the the Library timetable available
  String? _selectedValue19 = ''; // For the the timetable being followed
  String? _selectedValue20 = ''; // For the the Library register updated

  @override
  void initState() {
    super.initState();

    if (!Get.isRegistered<InPersonQuantitativeController>()) {
      Get.put(InPersonQuantitativeController());
    }

    final inPersonQuantitativeController =
        Get.find<InPersonQuantitativeController>();

    if (widget.existingRecord != null) {
      final existingRecord = widget.existingRecord!;

      inPersonQuantitativeController.noOfEnrolledStudentAsOnDateController
          .text = existingRecord.noOfEnrolled ?? '';
      inPersonQuantitativeController.remarksOnDigiLabSchedulingController.text =
          existingRecord.remarksOnDigiLab ?? '';
      inPersonQuantitativeController.digiLabAdminNameController.text =
          existingRecord.admin_name ?? '';
      inPersonQuantitativeController.digiLabAdminPhoneNumberController.text =
          existingRecord.admin_number ?? '';
      inPersonQuantitativeController.correctUdiseCodeController.text =
          existingRecord.correctUdise ?? '';
      inPersonQuantitativeController
          .instructionProvidedRegardingClassSchedulingController
          .text = existingRecord.instrucRegardingClass ?? '';
      inPersonQuantitativeController.staafAttendedTrainingController.text =
          existingRecord.staffAttendedTraining ?? '';
      inPersonQuantitativeController.otherTopicsController.text =
          existingRecord.otherTopics ?? '';
      inPersonQuantitativeController.reasonForNotGivenpracticalDemoController
          .text = existingRecord.reasonPracticalDemo ?? '';
      inPersonQuantitativeController
          .additionalCommentOnteacherCapacityController
          .text = existingRecord.commentOnTeacher ?? '';
      inPersonQuantitativeController.howOftenDataBeingSyncedController.text =
          existingRecord.dataSynced ?? '';
      inPersonQuantitativeController.additionalObservationOnLibraryController
          .text = existingRecord.additiObservLibrary ?? '';
      inPersonQuantitativeController.setTour(existingRecord.tourId);
      inPersonQuantitativeController.setSchool(existingRecord.school);

// make this code that user can also edit the participant string
      _selectedValue = existingRecord.udiseCode;
      _selectedValue2 = existingRecord.isDigilabSchedule;
      _selectedValue3 = existingRecord.Schedule2Hours;
      _selectedValue4 = existingRecord.admin_appointed;
      _selectedValue5 = existingRecord.admin_trained;
      _selectedValue6 = existingRecord.subjectTeachersTrained;
      _selectedValue7 = existingRecord.idsOnTheTabs;
      _selectedValue8 = existingRecord.teacherComfortUsingTab;
      _selectedValue9 = existingRecord.practicalDemo;
      _selectedValue10 = existingRecord.childComforUsingTab;
      _selectedValue11 = existingRecord.childAbleToUndersContent;
      _selectedValue12 = existingRecord.postTestByChild;
      _selectedValue13 = existingRecord.teachHelpChild;
      _selectedValue14 = existingRecord.digiLogBeFill;
      _selectedValue15 = existingRecord.correcDigiLogFill;
      _selectedValue16 = existingRecord.isReportDoneEachTab;
      _selectedValue17 = existingRecord.facilitAppInstallPhone;
      _selectedValue18 = existingRecord.libraryTimeTable;
      _selectedValue19 = existingRecord.timeTableFollow;
      _selectedValue20 = existingRecord.registerUpdated;

      //For checkboxes
      List<String>? refresherTrainingTopics =
          existingRecord.refreshTrainTopic?.split(', ');

      checkboxValue1 =
          refresherTrainingTopics?.contains('Operating DigiLab') ?? false;
      checkboxValue2 =
          refresherTrainingTopics?.contains('Operating tablets') ?? false;
      checkboxValue3 =
          refresherTrainingTopics?.contains('Creating students IDs') ?? false;
      checkboxValue4 = refresherTrainingTopics
              ?.contains('Grade Wise DigiLab subjects & Chapters') ??
          false;
      checkboxValue5 = refresherTrainingTopics
              ?.contains('Importance of completing post test') ??
          false;
      checkboxValue6 = refresherTrainingTopics
              ?.contains('Saving and submitting data(Send Report)') ??
          false;
      checkboxValue7 =
          refresherTrainingTopics?.contains('Syncing data with Pi') ?? false;
      checkboxValue8 = refresherTrainingTopics?.contains('Any other') ?? false;
    }
  }

  //For Showing Error of radio field
//
  bool _radioFieldError = false; // For the UDISE code
  bool _radioFieldError2 =
      false; // For the DigiLab Schedule/timetable available
  bool _radioFieldError3 = false; // For the DigiLab admin appointed
  bool _radioFieldError4 =
      false; // For the class scheduled for 2 hours per week
  bool _radioFieldError5 = false; // For the Digilab admin trained
  bool _radioFieldError6 = false; // For the all the subject teacher trained
  bool _radioFieldError7 = false; // For the teacher Ids been created
  bool _radioFieldError8 = false; // For the teachers comfortable using the tabs
  bool _radioFieldError10 = false; // For the  practical demo given
  bool _radioFieldError11 =
      false; // For the  children comfortable using the tabs
  bool _radioFieldError12 =
      false; // For the  children able to understand the content
  bool _radioFieldError13 =
      false; // For the  post-tests being completed by children
  bool _radioFieldError14 =
      false; // For the  teachers able to help children resolve
  bool _radioFieldError15 = false; // For the  digiLab logs being filled
  bool _radioFieldError16 =
      false; // For the  are the logs being filled correctly
  bool _radioFieldError17 =
      false; // For the  "Send Report" being done on each used tab
  bool _radioFieldError18 =
      false; // For the  Facilitator App installed and functioning
  bool _radioFieldError19 = false; // For the  Library timetable available
  bool _radioFieldError20 = false; // For the   timetable being followed
  bool _radioFieldError21 = false; // For the   Library register updated

  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;
  bool checkboxValue5 = false;
  bool checkboxValue6 = false;
  bool checkboxValue7 = false;
  bool checkboxValue8 = false;

  bool checkBoxError = false; //for checkbox error

  // For managing issues and resolutions
  List<Issue> issues = [];

  void _addIssue() async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddIssueBottomSheet(),
    );

    if (result != null && result is Issue) {
      setState(() {
        issues.add(result);
      });
    }
  }

  void _deleteIssue(int index) {
    setState(() {
      issues.removeAt(index);
    });
  }

  final InPersonQuantitativeController inPersonQuantitativeController =
      Get.put(InPersonQuantitativeController());
  List<Participants> participants = [];
  bool showError = false;
  void _addParticipants() async {
    int staffAttended = int.tryParse(inPersonQuantitativeController
            .staafAttendedTrainingController.text) ??
        0;

    if (staffAttended <= 0) {
      setState(() {
        showError = true;
      });
      return;
    }

    if (participants.length >= staffAttended) {
      setState(() {
        showError = true;
      });
      return;
    }

    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddParticipantsBottomSheet(
          existingRoles: participants.map((p) => p.designation).toList()),
    );

    if (result != null && result is Participants) {
      setState(() {
        int existingIndex =
            participants.indexWhere((p) => p.designation == result.designation);
        if (existingIndex >= 0) {
          participants[existingIndex] = result; // Update existing participant
        } else {
          participants.add(result); // Add new participant
        }
        showError =
            false; // Reset error if participants are added or updated successfully
      });
    }
  }

  void _deleteParticipants(int index) {
    setState(() {
      participants.removeAt(index);
    });
  }

  void _handleStaffAttendedChange(String value) {
    int staffAttended = int.tryParse(value) ?? 0;
    setState(() {
      showError = true; // Reset error
    });
  }

// make this code that if user fill 0 in the staff attendend in the training then show error
  bool _isImageUploaded = false;
  bool validateRegister = false;
  final ImagePicker _picker = ImagePicker();
  List<File> _imageFiles = [];

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFiles.add(File(pickedFile.path));
        _isImageUploaded = true;
        validateRegister = false; // Reset error state
      });
    }
  }

  var jsonData = <String, Map<String, String>>{};

  bool _isImageUploaded2 = false;
  bool validateRegister2 = false;
  final ImagePicker _picker2 = ImagePicker();
  List<File> _imageFiles2 = [];

  Future<void> _pickImageFromCamera2() async {
    final pickedFile = await _picker2.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFiles2.add(File(pickedFile.path));
        _isImageUploaded2 = true;
        validateRegister2 = false; // Reset error state
      });
    }
  }

  final TextEditingController _dateController = TextEditingController();
  bool _dateFieldError = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
        _dateFieldError = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return WillPopScope(
        onWillPop: () async {
          bool shouldPop =
              await BaseClient().showLeaveConfirmationDialog(context);
          return shouldPop;
        },
        child: Scaffold(
          appBar: const CustomAppbar(
            title: 'In-Person Quantitative',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GetBuilder<InPersonQuantitativeController>(
                      init: InPersonQuantitativeController(),
                      builder: (inPersonQuantitativeController) {
                        return Form(
                            key: _formKey,
                            child: GetBuilder<TourController>(
                                init: TourController(),
                                builder: (tourController) {
                                  tourController.fetchTourDetails();
                                  return Column(children: [
                                    if (showBasicDetails) ...[
                                      LabelText(
                                        label: 'Basic Details',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label: 'Tour ID',
                                        astrick: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      CustomDropdownFormField(
                                        focusNode:
                                            inPersonQuantitativeController
                                                .tourIdFocusNode,
                                        options: tourController.getLocalTourList
                                            .map((e) => e.tourId)
                                            .toList(),
                                        selectedOption:
                                            inPersonQuantitativeController
                                                .tourValue,
                                        onChanged: (value) {
                                          splitSchoolLists = tourController
                                              .getLocalTourList
                                              .where((e) => e.tourId == value)
                                              .map((e) => e.allSchool
                                                  .split('|')
                                                  .toList())
                                              .expand((x) => x)
                                              .toList();
                                          setState(() {
                                            inPersonQuantitativeController
                                                .setSchool(null);
                                            inPersonQuantitativeController
                                                .setTour(value);
                                          });
                                        },
                                        labelText: "Select Tour ID",
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label: 'School',
                                        astrick: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      DropdownSearch<String>(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Please Select School";
                                          }
                                          return null;
                                        },
                                        popupProps: PopupProps.menu(
                                          showSelectedItems: true,
                                          showSearchBox: true,
                                          disabledItemFn: (String s) =>
                                              s.startsWith('I'),
                                        ),
                                        items: splitSchoolLists,
                                        dropdownDecoratorProps:
                                            const DropDownDecoratorProps(
                                          dropdownSearchDecoration:
                                              InputDecoration(
                                            labelText: "Select School",
                                            hintText: "Select School ",
                                          ),
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            inPersonQuantitativeController
                                                .setSchool(value);
                                          });
                                        },
                                        selectedItem:
                                            inPersonQuantitativeController
                                                .schoolValue,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label: 'Is this UDISE code is correct?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue =
                                                      value as String?;
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      // make it that user can also edit the tourId and school
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue =
                                                      value as String?;
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError)
                                        const Padding(
                                          padding: EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_selectedValue == 'No') ...[
                                        LabelText(
                                          label:
                                              'Write Correct UDISE school code',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              inPersonQuantitativeController
                                                  .correctUdiseCodeController,
                                          textInputType: TextInputType.number,
                                          labelText: 'Enter correct UDISE code',
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill this field';
                                            }
                                            if (!RegExp(r'^[0-9]+$')
                                                .hasMatch(value)) {
                                              return 'Please enter a valid number';
                                            }
                                            return null;
                                          },
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                      ],
                                      LabelText(
                                        label: 'Click Image of School Board',
                                        astrick: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            width: 2,
                                            color: _isImageUploaded
                                                ? AppColors.primary
                                                : AppColors.error,
                                          ),
                                        ),
                                        child: ListTile(
                                          title: _isImageUploaded
                                              ? const Text(
                                                  'Click or Upload Image')
                                              : const Text(
                                                  'Click Supporting Images'),
                                          trailing: const Icon(Icons.camera_alt,
                                              color: AppColors.onBackground),
                                          onTap: _pickImageFromCamera,
                                        ),
                                      ),
                                      ErrorText(
                                        isVisible: validateRegister,
                                        message: 'Register Image Required',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_imageFiles.isNotEmpty)
                                        Container(
                                          width: responsive.responsiveValue(
                                            small: 600.0,
                                            medium: 900.0,
                                            large: 1400.0,
                                          ),
                                          height: responsive.responsiveValue(
                                            small: 170.0,
                                            medium: 170.0,
                                            large: 170.0,
                                          ),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _imageFiles.length,
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                height: 200,
                                                width: 200,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          CustomImagePreview
                                                              .showImagePreview(
                                                            _imageFiles[index]
                                                                .path,
                                                            context,
                                                          );
                                                        },
                                                        child: Image.file(
                                                          _imageFiles[index],
                                                          width: 190,
                                                          height: 120,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _imageFiles
                                                              .removeAt(index);
                                                          _isImageUploaded =
                                                              _imageFiles
                                                                  .isNotEmpty;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            'No of Enrolled Students as of date',
                                        astrick: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),

                                      CustomTextFormField(
                                        textController:
                                            inPersonQuantitativeController
                                                .noOfEnrolledStudentAsOnDateController,
                                        labelText: 'Enter Enrolled number',
                                        textInputType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(3),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please fill this field';
                                          }
                                          if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
                                            return 'Please enter a valid number';
                                          }
                                          return null;
                                        },
                                        showCharacterCount: true,
                                      ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      CustomButton(
                                        title: 'Next',
                                        onPressedButton: () {
                                          setState(() {
                                            _radioFieldError =
                                                _selectedValue == null ||
                                                    _selectedValue!.isEmpty;
                                            validateRegister =
                                                _imageFiles.isEmpty;
                                          });

                                          if (_formKey.currentState!
                                                  .validate() &&
                                              !_radioFieldError &&
                                              _isImageUploaded) {
                                            setState(() {
                                              showBasicDetails = false;
                                              showDigiLabSchedule = true;
                                            });
                                          }
                                        },
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ],
                                    // Ends of Add Basic Details
                                    if (showDigiLabSchedule) ...[
                                      LabelText(
                                        // Start of DigiLab Schedule
                                        label: 'DigiLab Schedule',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '1. Is DigiLab Schedule/timetable available?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue2,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue2 =
                                                      value as String?;
                                                  _radioFieldError2 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue2,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue2 =
                                                      value as String?;
                                                  _radioFieldError2 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError2)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_selectedValue2 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '1.1. Each class scheduled for 2 hours per week?',
                                          astrick: true,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Yes',
                                                groupValue: _selectedValue3,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue3 =
                                                        value as String?;
                                                    _radioFieldError4 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('Yes'),
                                            ],
                                          ),
                                        ),
                                        CustomSizedBox(
                                          value: 150,
                                          side: 'width',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'No',
                                                groupValue: _selectedValue3,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue3 =
                                                        value as String?;
                                                    _radioFieldError4 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('No'),
                                            ],
                                          ),
                                        ),
                                        if (_radioFieldError4)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Please select an option',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                      ],

                                      LabelText(
                                        label:
                                            '1.1.1 Describe in brief instructions provided regarding class scheduling',
                                        astrick: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      CustomTextFormField(
                                        textController:
                                            inPersonQuantitativeController
                                                .instructionProvidedRegardingClassSchedulingController,
                                        labelText: 'Write Description',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please fill this field';
                                          }

                                          if (value.length < 25) {
                                            return 'Description must be at least 25 characters long';
                                          }
                                          return null;
                                        },
                                        showCharacterCount: true,
                                      ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '2. Remarks on Digilab scheduling',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      CustomTextFormField(
                                        textController:
                                            inPersonQuantitativeController
                                                .remarksOnDigiLabSchedulingController,
                                        labelText: 'Write Remarks',
                                        showCharacterCount: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      Row(
                                        children: [
                                          CustomButton(
                                              title: 'Back',
                                              onPressedButton: () {
                                                setState(() {
                                                  showBasicDetails = true;
                                                  showDigiLabSchedule = false;
                                                });
                                              }),
                                          const Spacer(),
                                          CustomButton(
                                            title: 'Next',
                                            onPressedButton: () {
                                              setState(() {
                                                _radioFieldError4 =
                                                    _selectedValue2 == 'Yes' &&
                                                        (_selectedValue3 ==
                                                                null ||
                                                            _selectedValue3!
                                                                .isEmpty);
                                                _radioFieldError2 =
                                                    _selectedValue2 == null ||
                                                        _selectedValue2!
                                                            .isEmpty;
                                              });

                                              if (_formKey.currentState!
                                                      .validate() &&
                                                  !_radioFieldError2 &&
                                                  !_radioFieldError4) {
                                                setState(() {
                                                  showDigiLabSchedule = false;
                                                  showTeacherCapacity = true;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),

                                      // Ends of DigiLab Schedule
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ],
                                    // Start of Teacher Capacity
                                    if (showTeacherCapacity) ...[
                                      LabelText(
                                        label: 'Teacher Capacity',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label: '1. Is DigiLab admin appointed?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue4,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue4 =
                                                      value as String?;
                                                  _radioFieldError3 = false;
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue4,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue4 =
                                                      value as String?;
                                                  _radioFieldError3 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError3)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_selectedValue4 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '1.1. Is Digilab admin trained?',
                                          astrick: true,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Yes',
                                                groupValue: _selectedValue5,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue5 =
                                                        value as String?;
                                                    _radioFieldError5 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('Yes'),
                                            ],
                                          ),
                                        ),
                                        CustomSizedBox(
                                          value: 150,
                                          side: 'width',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'No',
                                                groupValue: _selectedValue5,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue5 =
                                                        value as String?;
                                                    _radioFieldError5 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('No'),
                                            ],
                                          ),
                                        ),
                                        if (_radioFieldError5)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Please select an option',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: '1.1.1 Name of DigiLab admin?',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              inPersonQuantitativeController
                                                  .digiLabAdminNameController,
                                          labelText: 'Name of admin',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Write Admin Name';
                                            }
                                            return null;
                                          },
                                          showCharacterCount: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label: '1.1.2 Phone number of admin?',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                            textController:
                                                inPersonQuantitativeController
                                                    .digiLabAdminPhoneNumberController,
                                            labelText: 'Phone number of admin',
                                            textInputType: TextInputType.number,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Write Admin Name';
                                              }

                                              // Regex for validating Indian phone number
                                              String pattern = r'^[6-9]\d{9}$';
                                              RegExp regex = RegExp(pattern);

                                              if (!regex.hasMatch(value)) {
                                                return 'Enter a valid phone number';
                                              }

                                              return null;

                                            },
                                          showCharacterCount: true,
                                            ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '2. Are all the subject teacher trained?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue6,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue6 =
                                                      value as String?;
                                                  _radioFieldError6 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue6,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue6 =
                                                      value as String?;
                                                  _radioFieldError6 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError6)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '3. Have teacher Ids been created and used on the tabs?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue7,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue7 =
                                                      value as String?;
                                                  _radioFieldError7 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue7,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue7 =
                                                      value as String?;
                                                  _radioFieldError7 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError7)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_selectedValue7 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '3.1. Are the teachers comfortable using the tabs and navigating the content?',
                                          astrick: true,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Yes',
                                                groupValue: _selectedValue8,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue8 =
                                                        value as String?;
                                                    _radioFieldError8 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('Yes'),
                                            ],
                                          ),
                                        ),
                                        CustomSizedBox(
                                          value: 150,
                                          side: 'width',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'No',
                                                groupValue: _selectedValue8,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue8 =
                                                        value as String?;
                                                    _radioFieldError8 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('No'),
                                            ],
                                          ),
                                        ),
                                        if (_radioFieldError8)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Please select an option',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      Row(
                                        children: [
                                          CustomButton(
                                            title: 'Back',
                                            onPressedButton: () {
                                              setState(() {
                                                showDigiLabSchedule = true;
                                                showTeacherCapacity = false;
                                              });
                                            },
                                          ),
                                          const Spacer(),
                                          CustomButton(
                                            title: 'Next',
                                            onPressedButton: () {
                                              setState(() {
                                                _radioFieldError3 =
                                                    _selectedValue4 == null ||
                                                        _selectedValue4!
                                                            .isEmpty;
                                                _radioFieldError5 =
                                                    _selectedValue4 == 'Yes' &&
                                                        (_selectedValue5 ==
                                                                null ||
                                                            _selectedValue5!
                                                                .isEmpty);
                                                _radioFieldError6 =
                                                    _selectedValue6 == null ||
                                                        _selectedValue6!
                                                            .isEmpty;
                                                _radioFieldError7 =
                                                    _selectedValue7 == null ||
                                                        _selectedValue7!
                                                            .isEmpty;
                                                _radioFieldError8 =
                                                    _selectedValue7 == 'Yes' &&
                                                        (_selectedValue8 ==
                                                                null ||
                                                            _selectedValue8!
                                                                .isEmpty);
                                              });

                                              if (_formKey.currentState!
                                                      .validate() &&
                                                  !_radioFieldError3 &&
                                                  !_radioFieldError5 &&
                                                  !_radioFieldError6 &&
                                                  !_radioFieldError7 &&
                                                  !_radioFieldError8) {
                                                setState(() {
                                                  showTeacherCapacity = false;
                                                  showSchoolRefresherTraining =
                                                      true;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ],

                                    // Start of In School Refresher Training
                                    if (showSchoolRefresherTraining) ...[
                                      LabelText(
                                          label:
                                              'In School Refresher Training'),
                                      CustomSizedBox(value: 20, side: 'height'),
                                      LabelText(
                                          label:
                                              '1. How many staff attended the training?',
                                          astrick: true),
                                      CustomSizedBox(value: 20, side: 'height'),
                                      CustomTextFormField(
                                        textController:
                                            inPersonQuantitativeController
                                                .staafAttendedTrainingController,
                                        labelText: 'Number of Staffs',
                                        textInputType: TextInputType.number,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(3),
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please fill this field';
                                          }
                                          if (!RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
                                            return 'Please enter a valid number';
                                          }

                                          return null;
                                        },
                                        onChanged: _handleStaffAttendedChange,
                                        showCharacterCount: true,
                                      ),
                                      CustomSizedBox(value: 20, side: 'height'),
                                      if (inPersonQuantitativeController
                                          .staafAttendedTrainingController
                                          .text
                                          .isNotEmpty) ...[
                                        Row(
                                          children: [
                                            LabelText(
                                                label:
                                                    '1.1 Add Participants Details'),
                                            CustomSizedBox(
                                                value: 10, side: 'width'),
                                            IconButton(
                                              icon: const Icon(Icons.add),
                                              iconSize: 40,
                                              color: Color.fromARGB(
                                                  255, 141, 13, 21),
                                              onPressed: _addParticipants,
                                            ),
                                          ],
                                        ),
                                        CustomSizedBox(
                                            value: 20, side: 'height'),
                                        participants.isEmpty
                                            ? const Center(
                                                child: Text('No records'))
                                            : ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: participants.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    title: Text(
                                                        '${index + 1}. Name: ${participants[index].nameOfParticipants}\n    Designation: ${participants[index].designation}'),
                                                    trailing: IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      onPressed: () =>
                                                          _deleteParticipants(
                                                              index),
                                                    ),
                                                  );
                                                },
                                              ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        if (showError)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Please add details for the Participants',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            'Click Image of Refresher Training?',
                                        astrick: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            width: 2,
                                            color: _isImageUploaded2
                                                ? AppColors.primary
                                                : AppColors.error,
                                          ),
                                        ),
                                        child: ListTile(
                                          title: _isImageUploaded2
                                              ? const Text('Click Image')
                                              : const Text(
                                                  'Click Supporting Images'),
                                          trailing: const Icon(Icons.camera_alt,
                                              color: AppColors.onBackground),
                                          onTap: _pickImageFromCamera2,
                                        ),
                                      ),
                                      ErrorText(
                                        isVisible: validateRegister2,
                                        message: 'Register Image Required',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_imageFiles2.isNotEmpty)
                                        Container(
                                          width: responsive.responsiveValue(
                                            small: 600.0,
                                            medium: 900.0,
                                            large: 1400.0,
                                          ),
                                          height: responsive.responsiveValue(
                                            small: 170.0,
                                            medium: 170.0,
                                            large: 170.0,
                                          ),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _imageFiles2.length,
                                            itemBuilder: (context, index) {
                                              return SizedBox(
                                                height: 200,
                                                width: 200,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          CustomImagePreview
                                                              .showImagePreview(
                                                            _imageFiles2[index]
                                                                .path,
                                                            context,
                                                          );
                                                        },
                                                        child: Image.file(
                                                          _imageFiles2[index],
                                                          width: 190,
                                                          height: 120,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          _imageFiles2
                                                              .removeAt(index);
                                                          _isImageUploaded2 =
                                                              _imageFiles2
                                                                  .isNotEmpty;
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '2. What were the topics covered in the refresher training?',
                                        astrick: true,
                                      ),
                                      CheckboxListTile(
                                        value: checkboxValue1,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue1 = value!;
                                          });
                                        },
                                        title: const Text('Operating DigiLab'),
                                        activeColor: Colors.green,
                                      ),
                                      CheckboxListTile(
                                        value: checkboxValue2,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue2 = value!;
                                          });
                                        },
                                        title: const Text('Operating tablets'),
                                        activeColor: Colors.green,
                                      ),
                                      CheckboxListTile(
                                        value: checkboxValue3,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue3 = value!;
                                          });
                                        },
                                        title:
                                            const Text('Creating students IDs'),
                                        activeColor: Colors.green,
                                      ),
                                      CheckboxListTile(
                                        value: checkboxValue4,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue4 = value!;
                                          });
                                        },
                                        title: const Text(
                                            'Grade Wise DigiLab subjects & Chapters'),
                                        activeColor: Colors.green,
                                      ),
                                      CheckboxListTile(
                                        value: checkboxValue5,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue5 = value!;
                                          });
                                        },
                                        title: const Text(
                                            'Importance of completing post test'),
                                        activeColor: Colors.green,
                                      ),
                                      CheckboxListTile(
                                        value: checkboxValue6,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue6 = value!;
                                          });
                                        },
                                        title: const Text(
                                            'Saving and submitting data(Send Report)'),
                                        activeColor: Colors.green,
                                      ),
                                      CheckboxListTile(
                                        value: checkboxValue7,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue7 = value!;
                                          });
                                        },
                                        title:
                                            const Text('Syncing data with Pi'),
                                        activeColor: Colors.green,
                                      ),
                                      CheckboxListTile(
                                        value: checkboxValue8,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            checkboxValue8 = value!;
                                            // Update the visibility of the text field
                                          });
                                        },
                                        title: const Text('Any other'),
                                        activeColor: Colors.green,
                                      ),
                                      if (checkBoxError)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select at least one topic',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (checkboxValue8) ...[
                                        // Conditionally show the text field
                                        LabelText(
                                          label:
                                              '2.1 Please specify what the other topics',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              inPersonQuantitativeController
                                                  .otherTopicsController,
                                          labelText:
                                              'Please Specify what the other topics',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please fill this field';
                                            }
                                            // Regex pattern for validating Indian vehicle number plate

                                            if (value.length < 25) {
                                              return 'Please enter at least 25 characters';
                                            }
                                            return null;
                                          },
                                          showCharacterCount: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                      ],
                                      // Give me complete code only for the selectbox error field and the onpressed on next for the selectbox
                                      LabelText(
                                        label: '3. Was a practical demo given?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue9,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue9 =
                                                      value as String?;
                                                  _radioFieldError10 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue9,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue9 =
                                                      value as String?;
                                                  _radioFieldError10 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError10)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_selectedValue9 == 'No') ...[
                                        // Conditionally show the text field
                                        LabelText(
                                          label:
                                              '3.1 Give the reason for not providing demo',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              inPersonQuantitativeController
                                                  .reasonForNotGivenpracticalDemoController,
                                          labelText: 'Give Reason',
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please fill this field';
                                            }
                                            // Regex pattern for validating Indian vehicle number plate

                                            if (value.length < 25) {
                                              return 'Please enter at least 25 characters';
                                            }
                                            return null;
                                          },
                                          showCharacterCount: true,
                                        ),
                                      ],

// Section for adding issues and resolutions
                                      Row(
                                        children: [
                                          LabelText(
                                            label:
                                                '4. Add Major Issues and Resolution',
                                          ),
                                          CustomSizedBox(
                                            value: 10,
                                            side: 'width',
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            iconSize: 40,
                                            color: Color.fromARGB(
                                                255, 141, 13, 21),
                                            onPressed: _addIssue,
                                          ),
                                        ],
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),

                                      issues.isEmpty
                                          ? const Center(
                                              child: Text('No records'))
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: issues.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(
                                                      '${index + 1}. Issue: ${issues[index].issue}\n    Resolution: ${issues[index].resolution}'),
                                                  trailing: IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    onPressed: () =>
                                                        _deleteIssue(index),
                                                  ),
                                                );
                                              },
                                            ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                          label:
                                              '5. Additional comments on teacher capacity'),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),

                                      CustomTextFormField(
                                        textController:
                                            inPersonQuantitativeController
                                                .additionalCommentOnteacherCapacityController,
                                        labelText: 'Write your comments if any',
                                        showCharacterCount: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      Row(
                                        children: [
                                          CustomButton(
                                              title: 'Back',
                                              onPressedButton: () {
                                                setState(() {
                                                  showTeacherCapacity = true;
                                                  showSchoolRefresherTraining =
                                                      false;
                                                });
                                              }),
                                          const Spacer(),
                                          CustomButton(
                                            title: 'Next',
                                            onPressedButton: () {
                                              bool isCheckboxSelected =
                                                  checkboxValue1 ||
                                                      checkboxValue2 ||
                                                      checkboxValue3 ||
                                                      checkboxValue4 ||
                                                      checkboxValue5 ||
                                                      checkboxValue6 ||
                                                      checkboxValue7 ||
                                                      checkboxValue8;

                                              if (!isCheckboxSelected) {
                                                setState(() {
                                                  checkBoxError = true;
                                                });
                                              } else {
                                                setState(() {
                                                  checkBoxError = false;
                                                });
                                              }

                                              if (_selectedValue9 == null ||
                                                  _selectedValue9!.isEmpty) {
                                                setState(() {
                                                  _radioFieldError10 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  _radioFieldError10 = false;
                                                });
                                              }

                                              int staffAttended = int.tryParse(
                                                      inPersonQuantitativeController
                                                          .staafAttendedTrainingController
                                                          .text) ??
                                                  0;

                                              if (participants.length <
                                                      staffAttended ||
                                                  staffAttended <= 0) {
                                                setState(() {
                                                  showError = true;
                                                });
                                              } else {
                                                setState(() {
                                                  showError = false;
                                                });
                                              }

                                              if (_formKey.currentState!
                                                      .validate() &&
                                                  !checkBoxError &&
                                                  !_radioFieldError10 &&
                                                  _isImageUploaded2 &&
                                                  !showError) {
                                                setState(() {
                                                  showSchoolRefresherTraining =
                                                      false;
                                                  showDigiLabClasses = true;
                                                });
                                              } else {
                                                setState(() {
                                                  validateRegister2 = true;
                                                });
                                              }
                                            },
                                          )
                                        ],
                                      ),

                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ],

                                    // Starting of digilab classes
                                    if (showDigiLabClasses) ...[
                                      LabelText(
                                        label: 'DigiLab Classes',
                                        astrick: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '1. Are the children comfortable using the tabs and navigating the content?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue10,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue10 =
                                                      value as String?;
                                                  _radioFieldError11 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue10,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue10 =
                                                      value as String?;
                                                  _radioFieldError11 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError11)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '2. Are the children able to understand the content?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue11,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue11 =
                                                      value as String?;
                                                  _radioFieldError12 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue11,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue11 =
                                                      value as String?;
                                                  _radioFieldError12 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError12)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '3. Are post-tests being completed by children at the end of each chapter?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue12,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue12 =
                                                      value as String?;
                                                  _radioFieldError13 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue12,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue12 =
                                                      value as String?;
                                                  _radioFieldError13 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError13)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '4. Are the teachers able to help children resolve doubts or issues during the DigiLab classes?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue13,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue13 =
                                                      value as String?;
                                                  _radioFieldError14 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue13,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue13 =
                                                      value as String?;
                                                  _radioFieldError14 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError14)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '5.  Are the digiLab logs being filled?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue14,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue14 =
                                                      value as String?;
                                                  _radioFieldError15 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue14,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue14 =
                                                      value as String?;
                                                  _radioFieldError15 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError15)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_selectedValue14 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '5.1  If yes,are the logs being filled correctly?',
                                          astrick: true,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Yes',
                                                groupValue: _selectedValue15,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue15 =
                                                        value as String?;
                                                    _radioFieldError16 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('Yes'),
                                            ],
                                          ),
                                        ),
                                        CustomSizedBox(
                                          value: 150,
                                          side: 'width',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'No',
                                                groupValue: _selectedValue15,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue15 =
                                                        value as String?;
                                                    _radioFieldError16 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('No'),
                                            ],
                                          ),
                                        ),
                                        if (_radioFieldError16)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Please select an option',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '6. Is "Send Report" being done on each used tab at the end of the day?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue16,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue16 =
                                                      value as String?;
                                                  _radioFieldError17 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue16,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue16 =
                                                      value as String?;
                                                  _radioFieldError17 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError17)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '7. Is Facilitator App installed and functioning on HMs/Admins phone?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue17,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue17 =
                                                      value as String?;
                                                  _radioFieldError18 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue17,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue17 =
                                                      value as String?;
                                                  _radioFieldError18 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError18)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_selectedValue17 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '7.1 How often is the data being synced?',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        CustomTextFormField(
                                          textController:
                                              inPersonQuantitativeController
                                                  .howOftenDataBeingSyncedController,
                                          labelText: 'Number of Days',
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          textInputType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please fill this field';
                                            }
                                            if (!RegExp(r'^[0-9]+$')
                                                .hasMatch(value)) {
                                              return 'Please enter a valid number';
                                            }
                                            return null;
                                          },
                                          showCharacterCount: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        LabelText(
                                          label:
                                              '7.2 When was the data last synced on the Facilitator App?',
                                          astrick: true,
                                        ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                        TextField(
                                          controller: _dateController,
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            labelText: 'Select Date',
                                            errorText: _dateFieldError
                                                ? 'Date is required'
                                                : null,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_today),
                                              onPressed: () {
                                                _selectDate(context);
                                              },
                                            ),
                                          ),
                                          onTap: () {
                                            _selectDate(context);
                                          },
                                        ),
                                      ],
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      Row(
                                        children: [
                                          CustomButton(
                                              title: 'Back',
                                              onPressedButton: () {
                                                setState(() {
                                                  showSchoolRefresherTraining =
                                                      true;
                                                  showDigiLabClasses = false;
                                                });
                                              }),
                                          const Spacer(),
                                          CustomButton(
                                            title: 'Next',
                                            onPressedButton: () {
                                              setState(() {
                                                _dateFieldError =
                                                    _selectedValue17 == 'Yes' &&
                                                        _dateController
                                                            .text.isEmpty;
                                                _radioFieldError11 =
                                                    _selectedValue10 == null ||
                                                        _selectedValue10!
                                                            .isEmpty;
                                                _radioFieldError12 =
                                                    _selectedValue11 == null ||
                                                        _selectedValue11!
                                                            .isEmpty;
                                                _radioFieldError13 =
                                                    _selectedValue12 == null ||
                                                        _selectedValue12!
                                                            .isEmpty;
                                                _radioFieldError14 =
                                                    _selectedValue13 == null ||
                                                        _selectedValue13!
                                                            .isEmpty;
                                                _radioFieldError15 =
                                                    _selectedValue14 == null ||
                                                        _selectedValue14!
                                                            .isEmpty;
                                                _radioFieldError16 =
                                                    _selectedValue14 == 'Yes' &&
                                                        (_selectedValue15 ==
                                                                null ||
                                                            _selectedValue15!
                                                                .isEmpty);
                                                _radioFieldError17 =
                                                    _selectedValue16 == null ||
                                                        _selectedValue16!
                                                            .isEmpty;
                                                _radioFieldError18 =
                                                    _selectedValue17 == null ||
                                                        _selectedValue17!
                                                            .isEmpty;
                                              });

                                              if (_formKey.currentState!
                                                      .validate() &&
                                                  !_radioFieldError11 &&
                                                  !_radioFieldError12 &&
                                                  !_radioFieldError13 &&
                                                  !_radioFieldError14 &&
                                                  !_radioFieldError16 &&
                                                  !_radioFieldError17 &&
                                                  !_radioFieldError18 &&
                                                  !_dateFieldError) {
                                                setState(() {
                                                  showDigiLabClasses = false;
                                                  showLibrary = true;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                    ],
                                    //   Ending of DigiLab Classes
                                    // Starting of library
                                    if (showLibrary) ...[
                                      LabelText(
                                        label: 'Library',
                                        astrick: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '1. Is a Library timetable available?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue18,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue18 =
                                                      value as String?;
                                                  _radioFieldError19 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue18,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue18 =
                                                      value as String?;
                                                  _radioFieldError19 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError19)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      if (_selectedValue18 == 'Yes') ...[
                                        LabelText(
                                          label:
                                              '1.1 is the timetable being followed?',
                                          astrick: true,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'Yes',
                                                groupValue: _selectedValue19,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue19 =
                                                        value as String?;
                                                    _radioFieldError20 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('Yes'),
                                            ],
                                          ),
                                        ),
                                        CustomSizedBox(
                                          value: 150,
                                          side: 'width',
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 300),
                                          child: Row(
                                            children: [
                                              Radio(
                                                value: 'No',
                                                groupValue: _selectedValue19,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectedValue19 =
                                                        value as String?;
                                                    _radioFieldError20 =
                                                        false; // Reset error state
                                                  });
                                                },
                                              ),
                                              const Text('No'),
                                            ],
                                          ),
                                        ),
                                        if (_radioFieldError20)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Please select an option',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        CustomSizedBox(
                                          value: 20,
                                          side: 'height',
                                        ),
                                      ],
                                      LabelText(
                                        label:
                                            '2. Is the Library register updated?',
                                        astrick: true,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'Yes',
                                              groupValue: _selectedValue20,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue20 =
                                                      value as String?;
                                                  _radioFieldError21 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('Yes'),
                                          ],
                                        ),
                                      ),
                                      CustomSizedBox(
                                        value: 150,
                                        side: 'width',
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 300),
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: 'No',
                                              groupValue: _selectedValue20,
                                              onChanged: (value) {
                                                setState(() {
                                                  _selectedValue20 =
                                                      value as String?;
                                                  _radioFieldError21 =
                                                      false; // Reset error state
                                                });
                                              },
                                            ),
                                            const Text('No'),
                                          ],
                                        ),
                                      ),
                                      if (_radioFieldError21)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: const Text(
                                              'Please select an option',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      LabelText(
                                        label:
                                            '3. Additional observations on Library',
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      CustomTextFormField(
                                        textController:
                                            inPersonQuantitativeController
                                                .additionalObservationOnLibraryController,
                                        labelText: 'Write Comments if any',
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please fill this field';
                                          }
                                          return null;
                                        },
                                        showCharacterCount: true,
                                      ),
                                      CustomSizedBox(
                                        value: 20,
                                        side: 'height',
                                      ),
                                      Row(
                                        children: [
                                          CustomButton(
                                              title: 'Back',
                                              onPressedButton: () {
                                                setState(() {
                                                  showDigiLabClasses = true;
                                                  showLibrary = false;
                                                });
                                              }),
                                          const Spacer(),
                                          CustomButton(
                                            title: 'Submit',
                                            onPressedButton: () async {
                                              setState(() {
                                                checkBoxError =
                                                    !(checkboxValue1 ||
                                                        checkboxValue2 ||
                                                        checkboxValue3 ||
                                                        checkboxValue4 ||
                                                        checkboxValue5 ||
                                                        checkboxValue6 ||
                                                        checkboxValue7 ||
                                                        checkboxValue8);
                                                _radioFieldError19 =
                                                    _selectedValue18 == null ||
                                                        _selectedValue18!
                                                            .isEmpty;
                                                _radioFieldError20 =
                                                    _selectedValue18 == 'Yes' &&
                                                        (_selectedValue19 ==
                                                                null ||
                                                            _selectedValue19!
                                                                .isEmpty);
                                                _radioFieldError21 =
                                                    _selectedValue20 == null ||
                                                        _selectedValue20!
                                                            .isEmpty;
                                                validateRegister =
                                                    !_isImageUploaded;
                                              });

                                              bool isRadioFieldsValid =
                                                  !_radioFieldError19 &&
                                                      !_radioFieldError20 &&
                                                      !_radioFieldError21;

                                              if (!checkBoxError) {
                                                // Combine all checkbox values into a single string
                                                String refresherTrainingTopic =
                                                    [
                                                  checkboxValue1
                                                      ? 'Operating DigiLab'
                                                      : null,
                                                  checkboxValue2
                                                      ? 'Operating tablets'
                                                      : null,
                                                  checkboxValue3
                                                      ? 'Creating students IDs'
                                                      : null,
                                                  checkboxValue4
                                                      ? 'Grade Wise DigiLab subjects & Chapters'
                                                      : null,
                                                  checkboxValue5
                                                      ? 'Importance of completing post test'
                                                      : null,
                                                  checkboxValue6
                                                      ? 'Saving and submitting data(Send Report)'
                                                      : null,
                                                  checkboxValue7
                                                      ? 'Syncing data with Pi'
                                                      : null,
                                                  checkboxValue8
                                                      ? 'Any other'
                                                      : null,
                                                ]
                                                        .where((value) =>
                                                            value != null)
                                                        .join(', ');

                                                if (_formKey.currentState!
                                                        .validate() &&
                                                    isRadioFieldsValid) {
                                                  // Combine participants data into a single string
                                                  String participantsData =
                                                      participants
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                    int index = entry.key + 1;
                                                    Participants participant =
                                                        entry.value;
                                                    return '${index}Name: ${participant.nameOfParticipants}\n, ${index}Designation: ${participant.designation}';
                                                  }).join('; ');
                                                  // Format issues into a single string
                                                  String issueAndResolution =
                                                      issues
                                                          .asMap()
                                                          .entries
                                                          .map((entry) {
                                                    int index = entry.key + 1;
                                                    Issue issue = entry.value;
                                                    return 'Issue${index}: ${issue.issue}, Resolution${index}: ${issue.resolution}, IsResolved${index}: ${issue.isResolved ? "Yes" : "No"}';
                                                  }).join('; ');

                                                  // Create enrolment collection object
                                                  InPersonQuantitativeRecords
                                                      enrolmentCollectionObj =
                                                      InPersonQuantitativeRecords(
                                                    tourId:
                                                        inPersonQuantitativeController
                                                                .tourValue ??
                                                            '',
                                                    school:
                                                        inPersonQuantitativeController
                                                                .schoolValue ??
                                                            '',
                                                    udiseCode: _selectedValue!,
                                                    correctUdise:
                                                        inPersonQuantitativeController
                                                            .correctUdiseCodeController
                                                            .text,
                                                    image: _imageFiles
                                                        .map(
                                                            (file) => file.path)
                                                        .toString(),
                                                    noOfEnrolled:
                                                        inPersonQuantitativeController
                                                            .noOfEnrolledStudentAsOnDateController
                                                            .text,
                                                    isDigilabSchedule:
                                                        _selectedValue2!,
                                                    Schedule2Hours:
                                                        _selectedValue3!,
                                                    instrucRegardingClass:
                                                        inPersonQuantitativeController
                                                            .instructionProvidedRegardingClassSchedulingController
                                                            .text,
                                                    remarksOnDigiLab:
                                                        inPersonQuantitativeController
                                                            .remarksOnDigiLabSchedulingController
                                                            .text,
                                                    admin_appointed:
                                                        _selectedValue4!,
                                                    admin_trained:
                                                        _selectedValue5!,
                                                    admin_name:
                                                        inPersonQuantitativeController
                                                            .digiLabAdminNameController
                                                            .text,
                                                    admin_number:
                                                        inPersonQuantitativeController
                                                            .digiLabAdminPhoneNumberController
                                                            .text,
                                                    subjectTeachersTrained:
                                                        _selectedValue6!,
                                                    idsOnTheTabs:
                                                        _selectedValue7!,
                                                    teacherComfortUsingTab:
                                                        _selectedValue8!,
                                                    staffAttendedTraining:
                                                        inPersonQuantitativeController
                                                            .staafAttendedTrainingController
                                                            .text,
                                                    image2: _imageFiles2
                                                        .map(
                                                            (file) => file.path)
                                                        .toString(),
                                                    otherTopics:
                                                        inPersonQuantitativeController
                                                            .otherTopicsController
                                                            .text,
                                                    practicalDemo:
                                                        _selectedValue9!,
                                                    reasonPracticalDemo:
                                                        inPersonQuantitativeController
                                                            .reasonForNotGivenpracticalDemoController
                                                            .text,
                                                    commentOnTeacher:
                                                        inPersonQuantitativeController
                                                            .additionalCommentOnteacherCapacityController
                                                            .text,
                                                    childComforUsingTab:
                                                        _selectedValue10!,
                                                    childAbleToUndersContent:
                                                        _selectedValue11!,
                                                    postTestByChild:
                                                        _selectedValue12!,
                                                    teachHelpChild:
                                                        _selectedValue13!,
                                                    digiLogBeFill:
                                                        _selectedValue14!,
                                                    correcDigiLogFill:
                                                        _selectedValue15!,
                                                    isReportDoneEachTab:
                                                        _selectedValue16!,
                                                    facilitAppInstallPhone:
                                                        _selectedValue17!,
                                                    dataSynced:
                                                        inPersonQuantitativeController
                                                            .howOftenDataBeingSyncedController
                                                            .text,
                                                    dateOfDataSyn:
                                                        _dateController.text,
                                                    libraryTimeTable:
                                                        _selectedValue18!,
                                                    timeTableFollow:
                                                        _selectedValue19!,
                                                    registerUpdated:
                                                        _selectedValue20!,
                                                    additiObservLibrary:
                                                        inPersonQuantitativeController
                                                            .additionalObservationOnLibraryController
                                                            .text,
                                                    refreshTrainTopic:
                                                        refresherTrainingTopic,
                                                    office: widget.office ?? '',
                                                    participantsData:
                                                        participantsData,
                                                    issueAndResolution:
                                                        issueAndResolution,
                                                  );

                                                  // Save data to local database
                                                  int result = await LocalDbController()
                                                      .addData(
                                                          inPersonQuantitativeRecords:
                                                              enrolmentCollectionObj);
                                                  print(result);
                                                  if (result > 0) {
                                                    inPersonQuantitativeController
                                                        .clearFields();
                                                    setState(() {
                                                      jsonData = {};
                                                      _imageFiles =
                                                          []; // Clear the image list
                                                      _isImageUploaded = false;
                                                      _imageFiles2 =
                                                          []; // Clear the image list
                                                      _isImageUploaded2 = false;
                                                      _selectedValue = '';
                                                      _selectedValue2 = '';
                                                      _selectedValue3 = '';
                                                      _selectedValue4 = '';
                                                      _selectedValue5 = '';
                                                      _selectedValue6 = '';
                                                      _selectedValue7 = '';
                                                      _selectedValue8 = '';
                                                      _selectedValue9 = '';
                                                      _selectedValue10 = '';
                                                      _selectedValue11 = '';
                                                      _selectedValue12 = '';
                                                      _selectedValue13 = '';
                                                      _selectedValue14 = '';
                                                      _selectedValue15 = '';
                                                      _selectedValue16 = '';
                                                      _selectedValue17 = '';
                                                      _selectedValue18 = '';
                                                      _selectedValue19 = '';
                                                      _selectedValue20 = '';
                                                    });

                                                    customSnackbar(
                                                      'Submitted Successfully',
                                                      'submitted',
                                                      AppColors.primary,
                                                      AppColors.onPrimary,
                                                      Icons.verified,
                                                    );
                                                    // Navigate to HomeScreen
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()),
                                                    );
                                                  } else {
                                                    customSnackbar(
                                                      'Error',
                                                      'Something went wrong',
                                                      AppColors.primary,
                                                      AppColors.onPrimary,
                                                      Icons.error,
                                                    );
                                                  }
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ]
                                  ] // End of main Column
                                      );
                                }));
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}

class Issue {
  String issue;
  String resolution;
  bool isResolved;

  Issue({
    required this.issue,
    required this.resolution,
    required this.isResolved,
  });
}

class AddIssueBottomSheet extends StatefulWidget {
  @override
  _AddIssueBottomSheetState createState() => _AddIssueBottomSheetState();
}

class _AddIssueBottomSheetState extends State<AddIssueBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<InPersonQuantitativeController>(
              init: InPersonQuantitativeController(),
              builder: (inPersonQuantitativeController) {
                return Column(
                  children: [
                    LabelText(
                      label: 'Write issue',
                      astrick: true,
                    ),
                    CustomSizedBox(
                      value: 20,
                      side: 'height',
                    ),
                    CustomTextFormField(
                      textController:
                          inPersonQuantitativeController.writeIssueController,
                      labelText: 'Write your issue',
                    ),
                    CustomSizedBox(
                      value: 20,
                      side: 'height',
                    ),
                    LabelText(
                      label: 'Write your resolution',
                      astrick: true,
                    ),
                    CustomSizedBox(
                      value: 20,
                      side: 'height',
                    ),
                    CustomTextFormField(
                      textController: inPersonQuantitativeController
                          .writeResolutionController,
                      labelText: 'Write your resolution',
                    ),
                    CustomSizedBox(
                      value: 20,
                      side: 'height',
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 80),
                      child: Column(
                        children: [
                          LabelText(
                            label: 'Is the issue resolved or not?',
                            astrick: true,
                          ),
                          ListTile(
                            title: const Text('Yes'),
                            leading: Radio<String>(
                              value: 'Yes',
                              groupValue:
                                  inPersonQuantitativeController.isResolved,
                              onChanged: (String? value) {
                                inPersonQuantitativeController
                                    .updateIsResolved(value);
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('No'),
                            leading: Radio<String>(
                              value: 'No',
                              groupValue:
                                  inPersonQuantitativeController.isResolved,
                              onChanged: (String? value) {
                                inPersonQuantitativeController
                                    .updateIsResolved(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                    title: 'Cancel',
                    onPressedButton: () {
                      Navigator.of(context).pop();
                    }),
                const Spacer(),
                GetBuilder<InPersonQuantitativeController>(
                  init: InPersonQuantitativeController(),
                  builder: (inPersonQuantitativeController) {
                    return CustomButton(
                        title: 'Add',
                        onPressedButton: () {
                          if (inPersonQuantitativeController
                                  .writeIssueController.text.isNotEmpty &&
                              inPersonQuantitativeController
                                  .writeResolutionController.text.isNotEmpty &&
                              inPersonQuantitativeController.isResolved !=
                                  null) {
                            final issue = Issue(
                              issue: inPersonQuantitativeController
                                  .writeIssueController.text,
                              resolution: inPersonQuantitativeController
                                  .writeResolutionController.text,
                              isResolved:
                                  inPersonQuantitativeController.isResolved ==
                                      'Yes',
                            );
                            Navigator.of(context).pop(issue);
                          }
                        });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Participants {
  String nameOfParticipants;
  String designation;

  Participants({required this.nameOfParticipants, required this.designation});
}

class AddParticipantsBottomSheet extends StatefulWidget {
  final List<String> existingRoles;

  AddParticipantsBottomSheet({required this.existingRoles});

  @override
  _AddParticipantsBottomSheetState createState() =>
      _AddParticipantsBottomSheetState();
}

class _AddParticipantsBottomSheetState
    extends State<AddParticipantsBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final InPersonQuantitativeController inPersonQuantitativeController =
      Get.put(InPersonQuantitativeController());
  String? _selectedDesignation;

  @override
  void initState() {
    super.initState();
    if (widget.existingRoles.isNotEmpty) {
      _selectedDesignation =
          widget.existingRoles.first; // Default to the first role for editing
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid'),
          iconColor: Color(0xffffffff),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LabelText(label: 'Participants Name', astrick: true),
              CustomSizedBox(value: 20, side: 'height'),
              CustomTextFormField(
                textController:
                    inPersonQuantitativeController.participantsNameController,
                labelText: 'Participants Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter participant name';
                  }
                  return null;
                },
              ),
              CustomSizedBox(value: 20, side: 'height'),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Participants Designation',
                  border: OutlineInputBorder(),
                ),
                value: _selectedDesignation,
                items: [
                  DropdownMenuItem(
                      value: 'DigiLab Admin', child: Text('DigiLab Admin')),
                  DropdownMenuItem(
                      value: 'HeadMaster', child: Text('HeadMaster')),
                  DropdownMenuItem(
                      value: 'In Charge', child: Text('In Charge')),
                  DropdownMenuItem(value: 'Teacher', child: Text('Teacher')),
                  DropdownMenuItem(
                      value: 'Temporary Teacher',
                      child: Text('Temporary Teacher')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedDesignation = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a designation';
                  }
                  return null;
                },
              ),
              CustomSizedBox(value: 20, side: 'height'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    title: 'Cancel',
                    onPressedButton: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    title: 'Add',
                    onPressedButton: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.existingRoles
                            .contains(_selectedDesignation)) {
                          _showErrorDialog(
                              'The selected role is already assigned to another participant.');
                        } else {
                          final participants = Participants(
                            nameOfParticipants: inPersonQuantitativeController
                                .participantsNameController.text,
                            designation: _selectedDesignation!,
                          );
                          Navigator.of(context).pop(participants);
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
