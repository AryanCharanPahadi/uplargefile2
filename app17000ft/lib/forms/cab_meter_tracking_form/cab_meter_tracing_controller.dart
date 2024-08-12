
import 'dart:io';

import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_model.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_sync.dart';
import 'package:app17000ft/helper/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../base_client/baseClient_controller.dart';
import 'cab_meter_tracing_modal.dart';
class CabMeterTracingController extends GetxController with BaseController{

  String? _tourValue;
  String? get tourValue => _tourValue;

  //school Value
  String? _schoolValue;
  String? get schoolValue => _schoolValue;

  bool isLoading = false;

  final TextEditingController remarksController = TextEditingController();
  final TextEditingController driverNameController = TextEditingController();
  final TextEditingController meterReadingController = TextEditingController();
  final TextEditingController placeVisitedController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController VehicleNumberController = TextEditingController();




  //Focus nodes
  final FocusNode _tourIdFocusNode = FocusNode();
  FocusNode get  tourIdFocusNode => _tourIdFocusNode;
  final FocusNode _schoolFocusNode = FocusNode();
  FocusNode get  schoolFocusNode => _schoolFocusNode;

  List<CabMeterTracingRecords> _cabMeterTracingList =[];
  List<CabMeterTracingRecords> get cabMeterTracingList => _cabMeterTracingList;

  List<XFile> _multipleImage = [];
  List<XFile> get multipleImage => _multipleImage;
  List<String> _imagePaths = [];
  List<String> get imagePaths => _imagePaths;

  Future<String> takePhoto(ImageSource source,) async {
    final ImagePicker picker = ImagePicker();
    List<XFile> selectedImages = [];

    _imagePaths = [];
    XFile? pickedImage;
    if (source == ImageSource.gallery) {
      selectedImages = await picker.pickMultiImage();
      // if (type == 'lib') {
      _multipleImage.addAll(selectedImages);
      for (var path in _multipleImage) {
        _imagePaths.add(path.path);
      }
      update();
      //  return _imagePaths.toString();
    } else if (source == ImageSource.camera) {
      pickedImage = await picker.pickImage(source: source);
      _multipleImage.add(pickedImage!);
      for (var path in _multipleImage) {
        _imagePaths.add(path.path);
      }
      update();
    }
    update();
    return _imagePaths.toString();
  }

  setSchool(value)
  {
    _schoolValue = value;
    update();
  }

  setTour(value){
    _tourValue = value;
    update();

  }
  Widget bottomSheet(BuildContext context) {
    String? imagePicked;
    PickedFile? imageFile;
    final ImagePicker picker = ImagePicker();
    XFile? image;
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
              // ignore: deprecated_member_use
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  imagePicked = await takePhoto(ImageSource.camera);

                  // uploadFile(userdata.read('customerID'));
                  Get.back();
                  //  update();
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(
                      fontSize: 20.0, color: AppColors.primary),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () async {
                  imagePicked = await takePhoto(
                    ImageSource.gallery,
                  );

                  Get.back();
                  //  update();
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(
                      fontSize: 20.0, color: AppColors.primary),
                ),
              ),
            ],
          )
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

  //Clear fields
  void clearFields() {
    placeVisitedController.clear();
    VehicleNumberController.clear();
    driverNameController.clear();
    meterReadingController.clear();
    remarksController.clear();
    _tourValue = null;



    update();
  }

  fetchData() async {
    isLoading = true;

    _cabMeterTracingList = [];
    _cabMeterTracingList = await LocalDbController().fetchLocalCabMeterTracingRecord();

    update();
  }

//

//Update the UI


}