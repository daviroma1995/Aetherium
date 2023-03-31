// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/services_screen/services_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';

import '../../widgets/custom_dropdown_list_widget.dart';
import '../../widgets/form_field_widget.dart';

class ServicesScreen extends StatelessWidget {
  final controller = Get.put(ServicesController());
  ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.args = Get.arguments;
    controller.reArrange();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            isDark ? AppColors.BACKGROUND_DARK : AppColors.BACKGROUND_COLOR,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(25.0),
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(AppLanguages.SERVICES_TREATMENTS,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 7.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: CustomInputFormField(
                        textEdigintController: TextEditingController(),
                        hintText: 'Search',
                        isValid: true,
                        onSubmit: () {},
                        autoFocus: false,
                        iconUrl: AppAssets.SEARCH_ICON,
                        onchange: (value) {
                          controller.searchService(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 0.0),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: services.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: 10.0),
                              CustomDropDownListWidget(
                                serviceIndex: index,
                                title: services[index].title,
                                imageUrl: AppAssets.USER_IMAGE,
                                items: services[index]
                                    .items
                                    .map((e) => e.title)
                                    .toList(),
                                isExpanded: services[index].isExtended.value,
                                price: services[index]
                                    .items
                                    .map((e) => e.price)
                                    .toList(),
                                time: services[index]
                                    .items
                                    .map((e) => e.time)
                                    .toList(),
                                serviceDetailController:
                                    controller.serviceDetailController,
                                selectedServices:
                                    controller.selectedServiceController,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20.0),
              child: ButtonWidget(
                  width: Get.width,
                  buttonText: 'Next',
                  color: isDark
                      ? AppColors.SECONDARY_LIGHT
                      : AppColors.PRIMARY_COLOR,
                  buttonTextColor:
                      !isDark ? AppColors.WHITE_COLOR : AppColors.BLACK_COLOR,
                  onTap: controller.moveToAppointmentBookingScreen),
            ),
          ],
        ),
      ),
    );
  }
}
