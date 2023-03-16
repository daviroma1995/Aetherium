// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/profile_screen/profile_screen_controller.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 13.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: const Text(
                  AppLanguages.PROFILE,
                  style: TextStyle(
                    fontSize: 22.0,
                    color: AppColors.BLACK_COLOR,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .75,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 26.0),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Custom_List_TIle(
                          index: index,
                          title: profileItems[index].title,
                          onTap: controller.Navigator,
                          imageUrl: profileItems[index].iconUrl),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
