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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // controller.reArrange();

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
      body: Obx(
        () => SafeArea(
          child: controller.services.isEmpty || controller.subServices.isEmpty
              ? const Center(
                  child: const CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            const SizedBox(height: 7.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22.0),
                              child: CustomInputFormField(
                                textEdigintController: controller.search,
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
                                itemCount: controller.services
                                    .where((service) {
                                      return service.name!
                                          .toLowerCase()
                                          .contains(
                                              controller.searchedValue.value);
                                    })
                                    .toList()
                                    .length,
                                itemBuilder: (context, index) {
                                  var filteredServices =
                                      controller.services.where((service) {
                                    return service.name!.toLowerCase().contains(
                                        controller.searchedValue.value);
                                  }).toList()[index];
                                  var serviceIndex =
                                      controller.services.indexWhere(
                                    (element) {
                                      return element.name! ==
                                          filteredServices.name;
                                    },
                                  );
                                  return Column(
                                    children: [
                                      const SizedBox(height: 10.0),
                                      CustomDropDownListWidget(
                                        selectedItems:
                                            controller.selectedServices.value,
                                        serviceIndex: index,
                                        title: filteredServices.name!,
                                        imageUrl: AppAssets.USER_IMAGE,
                                        items: controller.getServiceTitle(
                                            controller.subServices,
                                            controller.searchedValue.isEmpty
                                                ? index
                                                : serviceIndex),
                                        isExpanded: controller
                                            .services[index].isExtended.value,
                                        price: controller.getServicePrice(
                                            controller.subServices,
                                            controller.searchedValue.isEmpty
                                                ? index
                                                : serviceIndex),
                                        time: controller.getServiceTime(
                                            controller.subServices,
                                            controller.searchedValue.isEmpty
                                                ? index
                                                : serviceIndex),
                                        serviceDetailController:
                                            controller.serviceDetailController,
                                        selectedServices: controller
                                            .selectedServiceController,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22.0, vertical: 20.0),
                      child: ButtonWidget(
                          width: Get.width,
                          buttonText: 'Next',
                          color: isDark
                              ? AppColors.SECONDARY_LIGHT
                              : AppColors.PRIMARY_COLOR,
                          buttonTextColor: !isDark
                              ? AppColors.WHITE_COLOR
                              : AppColors.BLACK_COLOR,
                          onTap: controller.moveToAppointmentBookingScreen),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
