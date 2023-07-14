// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/services_screen/services_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';

import '../../models/appointment.dart';
import '../../widgets/custom_dropdown_list_widget.dart';
import '../../widgets/form_field_widget.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({
    Key? key,
    this.uid,
    this.clientEmail,
    this.number,
    this.index,
    this.isEditing = false,
    this.date,
    this.time,
    this.appointment,
  }) : super(key: key);
  final String? uid;
  final String? clientEmail;
  final String? number;
  final int? index;
  final bool isEditing;
  final String? date;
  final String? time;
  final Appointment? appointment;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
        ServicesController(uid: uid, clientEmail: clientEmail, number: number));
    controller.isEditing = isEditing;
    controller.date = date ?? '';
    controller.time = time ?? '';
    controller.newAppointment = appointment ?? Appointment();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    controller.uid = uid;
    controller.clientEmail = clientEmail;
    controller.number = number;
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return true;
      },
      child: Scaffold(
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
                  Get.back(result: true);
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
              Text('services_treatments',
                      style: Theme.of(context).textTheme.headlineLarge)
                  .tr(),
            ],
          ),
        ),
        body: Obx(
          () => SafeArea(
            child: controller.services.isEmpty && controller.subServices.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                      color: isDark
                          ? AppColors.SECONDARY_COLOR
                          : AppColors.GREY_COLOR,
                    ),
                  )
                : Obx(
                    () => Visibility(
                      visible: controller.services.isNotEmpty,
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  const SizedBox(height: 7.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 22.0),
                                    child: CustomInputFormField(
                                      textEdigintController: controller.search,
                                      hintText: 'Search',
                                      iconColor: AppColors.TEXT_FIELD_HINT_TEXT,
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: controller.services
                                          .where((service) {
                                            return service.name!
                                                .toLowerCase()
                                                .contains(controller
                                                    .searchedValue.value);
                                          })
                                          .toList()
                                          .length,
                                      itemBuilder: (context, index) {
                                        var filteredServices = controller
                                            .services
                                            .where((service) {
                                          return service.name!
                                              .toLowerCase()
                                              .contains(controller
                                                  .searchedValue.value);
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
                                                  controller.selectedServices,
                                              serviceIndex: serviceIndex,
                                              title: filteredServices.name!,
                                              imageUrl: controller
                                                  .services[index].iconUrl!,
                                              items: controller.getServiceTitle(
                                                  controller.subServices,
                                                  controller
                                                          .searchedValue.isEmpty
                                                      ? index
                                                      : serviceIndex),
                                              isExpanded: controller
                                                  .services[index]
                                                  .isExtended
                                                  .value,
                                              price: controller.getServicePrice(
                                                  controller.subServices,
                                                  controller
                                                          .searchedValue.isEmpty
                                                      ? index
                                                      : serviceIndex),
                                              time: controller.getServiceTime(
                                                  controller.subServices,
                                                  controller
                                                          .searchedValue.isEmpty
                                                      ? index
                                                      : serviceIndex),
                                              serviceDetailController:
                                                  controller
                                                      .serviceDetailController,
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
                            child: PrimaryButton(
                                width: Get.width,
                                buttonText: 'next',
                                color: isDark
                                    ? AppColors.SECONDARY_LIGHT
                                    : AppColors.PRIMARY_COLOR,
                                buttonTextColor: !isDark
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.BLACK_COLOR,
                                onTap:
                                    controller.moveToAppointmentBookingScreen),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
