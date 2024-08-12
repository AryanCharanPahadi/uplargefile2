import 'dart:io';

import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_model.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_sync.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_client/baseClient_controller.dart';
import 'in_person_quantitative_modal.dart';
class InPersonQuantitativeController extends GetxController with BaseController {
  var counterText = ''.obs;
  String? _tourValue;
  String? get tourValue => _tourValue;

  String? _schoolValue;
  String? get schoolValue => _schoolValue;

  bool isLoading = false;
  final TextEditingController tourIdController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController noOfEnrolledStudentAsOnDateController = TextEditingController();
  final TextEditingController remarksOnDigiLabSchedulingController = TextEditingController();
  final TextEditingController digiLabAdminNameController = TextEditingController();
  final TextEditingController digiLabAdminPhoneNumberController = TextEditingController();
  final TextEditingController correctUdiseCodeController = TextEditingController();
  final TextEditingController instructionProvidedRegardingClassSchedulingController = TextEditingController();
  final TextEditingController staafAttendedTrainingController = TextEditingController();
  final TextEditingController otherTopicsController = TextEditingController();
  final TextEditingController reasonForNotGivenpracticalDemoController = TextEditingController();
  final TextEditingController additionalCommentOnteacherCapacityController = TextEditingController();
  final TextEditingController howOftenDataBeingSyncedController = TextEditingController();
  final TextEditingController additionalObservationOnLibraryController = TextEditingController();
  final TextEditingController writeIssueController = TextEditingController();
  final TextEditingController writeResolutionController = TextEditingController();
  final TextEditingController participantsNameController = TextEditingController();





  String? isResolved;
  String? _selectedDesignation;

  void updateIsResolved(String? value) {
    isResolved = value;
    update(); // This will call the builder again to reflect changes
  }
  final FocusNode _tourIdFocusNode = FocusNode();
  FocusNode get tourIdFocusNode => _tourIdFocusNode;

  final FocusNode _schoolFocusNode = FocusNode();
  FocusNode get schoolFocusNode => _schoolFocusNode;

  List<InPersonQuantitativeRecords> _inPersonQuantitativeList = [];
  List<InPersonQuantitativeRecords> get inPersonQuantitative => _inPersonQuantitativeList;

  final List<XFile> _multipleImage = [];
  List<XFile> get multipleImage => _multipleImage;

  List<String> _imagePaths = [];
  List<String> get imagePaths => _imagePaths;

  Future<String> takePhoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    List<XFile> selectedImages = [];

    _imagePaths = [];
    if (source == ImageSource.gallery) {
      selectedImages = await picker.pickMultiImage();
      _multipleImage.addAll(selectedImages);
      for (var image in _multipleImage) {
        _imagePaths.add(image.path);
      }
    } else if (source == ImageSource.camera) {
      XFile? pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        _multipleImage.add(pickedImage);
        _imagePaths.add(pickedImage.path);
      }
    }
    update();
    return _imagePaths.toString();
  }

  void setSchool(String? value) {
    _schoolValue = value;

  }

  void setTour(String? value) {
    _tourValue = value;

  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Select Image",
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto(ImageSource.camera);
                  Get.back();
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(fontSize: 20.0, color: AppColors.primary),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  await takePhoto(ImageSource.gallery);
                  Get.back();
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 20.0, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showImagePreview(String imagePath, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.file(
                File(imagePath),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  void clearFields() {
    _tourValue = null;
    _schoolValue = null;
    remarksController.clear();
    noOfEnrolledStudentAsOnDateController.clear();
    remarksOnDigiLabSchedulingController.clear();
    digiLabAdminNameController.clear();
    digiLabAdminPhoneNumberController.clear();
    correctUdiseCodeController.clear();
    instructionProvidedRegardingClassSchedulingController.clear();
    staafAttendedTrainingController.clear();
    otherTopicsController.clear();
    reasonForNotGivenpracticalDemoController.clear();
    additionalCommentOnteacherCapacityController.clear();
    howOftenDataBeingSyncedController.clear();
    additionalObservationOnLibraryController.clear();
    writeIssueController.clear();
    writeResolutionController.clear();
    participantsNameController.clear();
    update();
  }

  Future<void> fetchData() async {
    isLoading = true;
    update();
    _inPersonQuantitativeList = await LocalDbController().fetchLocalInPersonQuantitativeRecords();
    isLoading = false;
    update();
  }
}
