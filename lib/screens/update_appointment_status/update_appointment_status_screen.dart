import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/app_bar_widget.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../widgets/drop_down_item_widget.dart';
import '../../widgets/form_field_widget.dart';
import 'update_appointment_status_controller.dart';

class UpdateAppointmentStatusScreen extends StatelessWidget {
  UpdateAppointmentStatusScreen({Key? key, required this.appointment})
      : super(key: key);
  final Appointment appointment;
  final controller = Get.put(UpdateAppointmentStatusController());
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBarCustom(
          onTap: () {
            Get.back();
          },
          title: tr('update_status')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'note',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.WHITE_COLOR
                          : AppColors.SECONDARY_COLOR,
                    ),
                    textAlign: TextAlign.left,
                  ).tr(),
                ],
              ),
              const SizedBox(height: 14.0),
              CustomInputFormField(
                hintText: appointment.notes!.isEmpty
                    ? 'Some Notes'
                    : appointment.notes!,
                isValid: true,
                onSubmit: () {},
                textEdigintController: controller.notes,
                paddingSymetric: 16.0,
                paddingVertical: 16.0,
                autoFocus: false,
                maxLines: 15,
                minLInes: 8,
                onchange: (value) {
                  appointment.notes = value;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Obx(
                () => !controller.isLoading.value &&
                        controller.appointmentStatusList.isNotEmpty &&
                        controller.statusLabels.isNotEmpty
                    ? Visibility(
                        maintainState: true,
                        replacement: const SizedBox(
                          height: 100,
                          width: 100,
                          child: CircularProgressIndicator(),
                        ),
                        visible: !controller.isLoading.value &&
                            controller.statusLabels.isNotEmpty,
                        child: DropDownItemsWidget(
                          // ignore: invalid_use_of_protected_member
                          options: controller.statusLabels.value,
                          selected: controller.getStatus(appointment),
                          onTap: (selected) {
                            print(selected);

                            controller.status = selected ?? '';
                            int id = controller.appointmentStatusList
                                .indexWhere((status) =>
                                    status.label!.toLowerCase() ==
                                    selected!.toLowerCase());
                            int previousStatusId = controller
                                .appointmentStatusList
                                .indexWhere((element) =>
                                    element.id == appointment.statusId);
                            controller.previousStatus = controller
                                    .appointmentStatusList[previousStatusId]
                                    .label ??
                                '';
                            appointment.statusId =
                                controller.appointmentStatusList[id].id;
                          },
                        ),
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 20.0,
              ),
              PrimaryButton(
                width: Get.width,
                buttonText: 'Update',
                onTap: () => controller.updateStatus(appointment),
                color: isDark
                    ? AppColors.SECONDARY_LIGHT
                    : AppColors.PRIMARY_COLOR,
              )
            ],
          ),
        ),
      ),
    );
  }
}
