import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/app_bar_widget.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/appointment.dart';
import '../../widgets/drop_down_item_widget.dart';
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
          title: 'Update Appointment Status'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            DropDownItemsWidget(
              // ignore: invalid_use_of_protected_member
              options: controller.statusLabels.value,
              onTap: (selected) {
                int id = controller.appointmentStatusList.indexWhere((status) =>
                    status.label!.toLowerCase() == selected!.toLowerCase());
                appointment.statusId = controller.appointmentStatusList[id].id;
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            PrimaryButton(
              width: Get.width,
              buttonText: 'Update',
              onTap: () => controller.updateStatus(appointment),
              color:
                  isDark ? AppColors.SECONDARY_LIGHT : AppColors.PRIMARY_COLOR,
            )
          ],
        ),
      ),
    );
  }
}
