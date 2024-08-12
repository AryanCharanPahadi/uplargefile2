// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:app17000ft/constants/color_const.dart';
import 'package:app17000ft/forms/school_enrolment/school_enrolment_sync.dart';
import 'package:app17000ft/helper/responsive_helper.dart';
import 'package:app17000ft/helper/shared_prefernce.dart';
import 'package:app17000ft/home/home_screen.dart';
import 'package:app17000ft/home/tour_data.dart';
import 'package:app17000ft/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';

import '../forms/cab_meter_tracking_form/cab_meter_tracing_sync.dart';
import '../forms/in_person_quantitative/in_person_quantitative_sync.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          Container(
            color: AppColors.background,
            height: responsive.responsiveValue(
                small: 200.0, medium: 210.0, large: 220.0),
            width: responsive.responsiveValue(
                small: 320.0, medium: 330.0, large: 340.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(),
                    shape: BoxShape.circle,
                    color: AppColors.background,
                    image:
                        DecorationImage(image: AssetImage('assets/check.png'))),
              ),
            ),
          ),
          DrawerMenu(
              title: 'Home',
              icons: const FaIcon(FontAwesomeIcons.home),
              onPressed: () {
                Navigator.pop(context);
               Get.to(() =>  const HomeScreen());
          }),
          DrawerMenu(
              title: 'Tour Data',
              icons: const FaIcon(FontAwesomeIcons.home),
              onPressed: () {
              
                Get.to(() =>  const SelectTourData());
          }),
          DrawerMenu(
              title: 'Enrolment Sync',
              icons: const FaIcon(FontAwesomeIcons.database),
              onPressed: () async {
                await SharedPreferencesHelper.logout();
                await Get.to(() => const EnrolmentSync());
              }),
          DrawerMenu(
              title: 'Cab Meter Tracing Sync',
              icons: const FaIcon(FontAwesomeIcons.database),
              onPressed: () async {
                await SharedPreferencesHelper.logout();
                await Get.to(() => const CabTracingSync());
              }),
          DrawerMenu(
              title: 'In Person Quantitative Sync',
              icons: const FaIcon(FontAwesomeIcons.database),
              onPressed: () async {
                await SharedPreferencesHelper.logout();
                await Get.to(() => const InPersonQuantitativeSync());
              }),
          DrawerMenu(
              title: 'Logout',
              icons: const FaIcon(FontAwesomeIcons.signOut),
              onPressed: () async {
                await SharedPreferencesHelper.logout();
                await Get.to(() => const LoginScreen());
              }),
        ],
      ),
    );
  }
}

class DrawerMenu extends StatelessWidget {
  String? title;
  FaIcon? icons;
  Function? onPressed;
  DrawerMenu({
    super.key,
    this.title,
    this.icons,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icons,
      title: Text(title ?? '',
          style: AppStyles.inputLabel(context, AppColors.onBackground, 14)),
      onTap: () {
        if (onPressed != null) {
          onPressed!(); // Call the function using parentheses
        }
      },
    );
  }
}
