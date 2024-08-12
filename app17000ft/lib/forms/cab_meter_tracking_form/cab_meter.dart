import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app17000ft/components/custom_appBar.dart';
import 'package:app17000ft/components/custom_button.dart';
import 'package:app17000ft/components/custom_imagepreview.dart';
import 'package:app17000ft/components/custom_textField.dart';
import 'package:app17000ft/components/error_text.dart';
import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/cab_meter_tracking_form/cab_meter_tracing_controller.dart';
import 'package:app17000ft/helper/responsive_helper.dart';
import 'package:app17000ft/tourDetails/tour_controller.dart';
import 'package:app17000ft/components/custom_dropdown.dart';
import 'package:app17000ft/components/custom_labeltext.dart';
import 'package:app17000ft/components/custom_sizedBox.dart';

import '../../components/custom_snackbar.dart';
import '../../helper/database_helper.dart';
import 'cab_meter_tracing_modal.dart';

class CabMeterTracingForm extends StatefulWidget {
  String? userid;
  String? office;
  CabMeterTracingForm({super.key, this.userid, this.office});

  @override
  State<CabMeterTracingForm> createState() => _CabMeterTracingFormState();
}

class _CabMeterTracingFormState extends State<CabMeterTracingForm> {
  String? _selectedValue = '';
  bool _isImageUploaded = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  bool validateRegister = false;
  List<String> splitSchoolLists = [];
  bool _radioFieldError = false;
  final ImagePicker _picker = ImagePicker();
  List<File> _imageFiles = [];
  var jsonData = <String, Map<String, String>>{};

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

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Scaffold(
      appBar: const CustomAppbar(
        title: 'Cab Meter Tracing Form',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              GetBuilder<CabMeterTracingController>(
                init: CabMeterTracingController(),
                builder: (cabMeterController) {
                  return Form(
                    key: _formKey,
                    child: GetBuilder<TourController>(
                      init: TourController(),
                      builder: (tourController) {
                        tourController.fetchTourDetails();

                        return Column(children: [
                          LabelText(
                            label: 'Tour ID',
                            astrick: true,
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          CustomDropdownFormField(
                            focusNode: cabMeterController.tourIdFocusNode,
                            options: tourController.getLocalTourList
                                .map((e) => e.tourId)
                                .toList(),
                            selectedOption: cabMeterController.tourValue,
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
                                cabMeterController.setSchool(null);
                                cabMeterController.setTour(value);
                              });
                            },
                            labelText: "Select Tour ID",
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          LabelText(
                            label: 'Place Visited',
                            astrick: true,
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          CustomTextFormField(
                            textController:  cabMeterController.placeVisitedController,
                            labelText: 'Place Visited',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Place Visited';
                              }
                              return null;
                            },

                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          LabelText(
                            label: 'Vehicle Number',
                            astrick: true,
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          CustomTextFormField(
                            textController: cabMeterController.VehicleNumberController,
                            labelText: 'Vehicle Number',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Vehicle Number';
                              }
                              // Regex pattern for validating Indian vehicle number plate
                              final regExp =
                              RegExp(r"^[a-zA-Z]{2}[a-zA-Z0-9]*[0-9]{4}$");
                              if (!regExp.hasMatch(value)) {
                                return 'Please Enter a valid Vehicle Number';
                              }
                              return null;
                            },

                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          LabelText(
                            label: 'Driver Name',
                            astrick: true,
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          CustomTextFormField(
                            textController: cabMeterController.driverNameController,
                            labelText: 'Driver Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Driver Name';
                              }
                              return null;
                            },

                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          LabelText(
                            label: 'Meter reading',
                            astrick: true,
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          CustomTextFormField(
                            textController: cabMeterController.meterReadingController,
                            labelText: 'Meter reading',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Meter Reading';
                              }
                              return null;
                            },

                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          LabelText(
                            label: 'Click Images:',
                            astrick: true,
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 2,
                                color: _isImageUploaded
                                    ? AppColors.primary
                                    : AppColors.error,
                              ),
                            ),
                            child: ListTile(
                              title: _isImageUploaded
                                  ? const Text('Click or Upload Image')
                                  : const Text('Click Supporting Images'),
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
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              CustomImagePreview
                                                  .showImagePreview(
                                                _imageFiles[index].path,
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
                                              _imageFiles.removeAt(index);
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
                            label: 'Choose Options:',
                            astrick: true,
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Radio(
                                  value: 'start',
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value as String?;
                                      _radioFieldError = false; // Reset error state
                                    });
                                  },
                                ),
                              ),
                              const Text('Start'),
                              Spacer(), // Adds flexible space between the elements
                              Flexible(
                                child: Radio(
                                  value: 'end',
                                  groupValue: _selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedValue = value as String?;
                                      _radioFieldError = false; // Reset error state
                                    });
                                  },
                                ),
                              ),
                              const Text('End'),
                            ],
                          ),
                          if (_radioFieldError)
                            const Text(
                              'Please select an option',
                              style: TextStyle(color: Colors.red),
                            ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          LabelText(
                            label: 'Remarks',
                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          CustomTextFormField(
                            textController: cabMeterController.remarksController,

                            labelText: 'Remarks Here',
                            validator: (value) {
                              if (value != null && value.length > 30) {
                                return 'Text must not be more than 30 characters';
                              }
                              return null;
                            },

                          ),
                          CustomSizedBox(
                            value: 20,
                            side: 'height',
                          ),
                          CustomButton(
                              title: 'Submit',
                              onPressedButton: () async {
                                setState(() {
                                  validateRegister = !_isImageUploaded;
                                });

                                if (_formKey.currentState!.validate() &&
                                    _isImageUploaded &&
                                    _selectedValue != null && _selectedValue!.isNotEmpty) {
                                  // All validations passed, proceed with form submission
                                  _radioFieldError = false;

                                  // Create enrolment collection object
                                  CabMeterTracingRecords enrolmentCollectionObj =
                                  CabMeterTracingRecords(
                                    status: _selectedValue!,
                                    placeVisit: cabMeterController.placeVisitedController.text,
                                    remarks: cabMeterController.remarksController.text,
                                    vehicleNo: cabMeterController.VehicleNumberController.text,
                                    driverName: cabMeterController.driverNameController.text,
                                    meterReading: cabMeterController.meterReadingController.text,
                                    image: _imageFiles.map((file) => file.path).toString(),
                                    office: widget.office ?? '',
                                    tourId: cabMeterController.tourValue ?? '',
                                  );

                                  // Save data to local database
                                  int result = await LocalDbController()
                                      .addData(
                                      cabMeterTracingRecords: enrolmentCollectionObj);

                                  if (result > 0) {
                                    cabMeterController.clearFields();
                                    setState(() {
                                      jsonData = {};
                                      _imageFiles = []; // Clear the image list
                                      _isImageUploaded = false;
                                      _selectedValue = ''; // Clear radio button selection
                                    });

                                    customSnackbar(
                                        'Submitted Successfully',
                                        'submitted',
                                        AppColors.primary,
                                        AppColors.onPrimary,
                                        Icons.verified);
                                  } else {
                                    customSnackbar(
                                        'Error',
                                        'Something went wrong',
                                        AppColors.primary,
                                        AppColors.onPrimary,
                                        Icons.error);
                                  }
                                }
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }

                          ),
                        ]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
