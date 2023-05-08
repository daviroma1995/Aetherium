// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/select_client_screen/select_client_controller.dart';

import '../../utils/constants.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/form_field_widget.dart';

class SelectClientScreen extends StatelessWidget {
  SelectClientScreen({super.key});

  final SelectClientController controller = Get.put(SelectClientController());

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
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
              Text(AppLanguages.SELECT_CLIENT,
                  style: Theme.of(context).textTheme.headlineLarge),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: CustomInputFormField(
                textEdigintController: controller.search,
                hintText: 'Search',
                isValid: true,
                onSubmit: () {},
                autoFocus: false,
                iconUrl: AppAssets.SEARCH_ICON,
                onchange: (value) {
                  print(value);
                },
              ),
            ),
            const SizedBox(height: 22.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(),
                ),
                child: Obx(
                  () => controller.clients.isEmpty
                      ? const CircularProgressIndicator()
                      : controller.isLoaded.value
                          ? ListView.builder(
                              itemCount: controller.clients.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.onTap(index);
                                  },
                                  child: !controller.selectedClients.contains(
                                          controller.clients[index].firstName)
                                      ? ClientTile(
                                          index: index,
                                          name:
                                              '${controller.clients[index].firstName!} ${controller.clients[index].lastName}',
                                          membership: 'Primo',
                                          checkColor: AppColors.BORDER_COLOR,
                                          textColor: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.BLACK_COLOR,
                                          iconColor: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.BLACK_COLOR,
                                          onTap: controller.getClientDetails,
                                        )
                                      : ClientTile(
                                          index: index,
                                          onTap: controller.getClientDetails,
                                          name:
                                              '${controller.clients[index].firstName!} ${controller.clients[index].lastName}',
                                          membership: 'Primo',
                                          iconColor: AppColors.SECONDARY_COLOR,
                                          textColor: AppColors.SECONDARY_COLOR,
                                          checkColor:
                                              AppColors.SECONDARY_COLOR),
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: controller.clients.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.onTap(index);
                                  },
                                  child: !controller.selectedClients.contains(
                                          controller.clients[index].firstName)
                                      ? ClientTile(
                                          index: index,
                                          onTap: controller.getClientDetails,
                                          name:
                                              '${controller.clients[index].firstName!} ${controller.clients[index].lastName}',
                                          membership: 'Primo',
                                          checkColor: AppColors.BORDER_COLOR,
                                          textColor: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.BLACK_COLOR,
                                          iconColor: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.BLACK_COLOR,
                                        )
                                      : ClientTile(
                                          index: index,
                                          onTap: controller.getClientDetails,
                                          name:
                                              '${controller.clients[index].firstName!} ${controller.clients[index].lastName}',
                                          membership: 'Primo',
                                          textColor: AppColors.SECONDARY_COLOR,
                                          iconColor: AppColors.SECONDARY_COLOR,
                                          checkColor:
                                              AppColors.SECONDARY_COLOR),
                                );
                              },
                            ),
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: ButtonWidget(
            color: isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
            buttonText: AppLanguages.AVANTI,
            width: Get.width,
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class ClientTile extends StatelessWidget {
  const ClientTile({
    Key? key,
    required this.index,
    required this.name,
    required this.membership,
    required this.iconColor,
    required this.checkColor,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);
  final int index;
  final String name;
  final String membership;
  final Color iconColor;
  final Color checkColor;
  final Color textColor;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0.0),
      leading: GestureDetector(
        onTap: () => onTap(index),
        child: SvgPicture.asset(
          AppAssets.INFO_ICON,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
      minLeadingWidth: 10,
      title: Text(
        '$name - $membership',
        style: TextStyle(color: textColor),
      ),
      trailing: SvgPicture.asset(
        AppAssets.CHECKED_ICON,
        colorFilter: ColorFilter.mode(checkColor, BlendMode.srcIn),
      ),
    );
  }
}
