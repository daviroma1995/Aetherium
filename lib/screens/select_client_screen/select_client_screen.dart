// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/select_client_screen/select_client_controller.dart';

import '../../utils/constants.dart';
import '../../widgets/primary_button.dart';
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
        resizeToAvoidBottomInset: false,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: CustomInputFormField(
                  textEdigintController: controller.search,
                  hintText: 'Search',
                  iconColor: AppColors.TEXT_FIELD_HINT_TEXT,
                  isValid: true,
                  onSubmit: () {},
                  autoFocus: false,
                  iconUrl: AppAssets.SEARCH_ICON,
                  onchange: (value) {
                    controller.searchText.value = value;
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
                    () => controller.clients.isEmpty || controller.tier.isEmpty
                        ?  CircularProgressIndicator(
                                              color: isDark? AppColors.SECONDARY_COLOR : AppColors.GREY_COLOR,

                        )
                        : controller.isLoaded.value
                            ? ListView.builder(
                                itemCount: controller.clients
                                    .where((client) {
                                      return client.fullName
                                          .toLowerCase()
                                          .contains(
                                              controller.searchText.value);
                                    })
                                    .toList()
                                    .length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  controller.searchedClients.value =
                                      controller.clients.where((client) {
                                    return client.fullName
                                        .toLowerCase()
                                        .contains(controller.searchText.value);
                                  }).toList();
                                  int selectedIndex = controller
                                              .searchedClients.length >
                                          1
                                      ? index
                                      : controller.clients.indexWhere((client) {
                                          return client.fullName
                                              .toLowerCase()
                                              .contains(
                                                  controller.searchText.value);
                                        });
                                  return GestureDetector(
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            var yesButton = PrimaryButton(
                                                color: AppColors.ERROR_COLOR,
                                                width: 60,
                                                buttonText: 'Yes',
                                                onTap: () async {
                                                  await controller.longPress(
                                                      controller.searchedClients
                                                                  .length >
                                                              1
                                                          ? index
                                                          : selectedIndex);
                                                  Fluttertoast.showToast(
                                                      msg: 'User deleted');
                                                  // ignore: use_build_context_synchronously
                                                  Get.back();
                                                  Get.back();
                                                });
                                            var noButton = TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('No'),
                                            );
                                            return AlertDialog(
                                              alignment: Alignment.center,
                                              title:
                                                  const Text('Are you sure?'),
                                              content: const Text(
                                                  'User account will be deleted permanently'),
                                              actions: [yesButton, noButton],
                                            );
                                          });
                                    },
                                    onTap: () {
                                      controller.onTap(
                                          controller.searchedClients.length > 1
                                              ? index
                                              : selectedIndex);
                                    },
                                    child: !controller.selectedClients.contains(
                                            controller
                                                .clients[controller
                                                            .searchedClients
                                                            .length >
                                                        1
                                                    ? index
                                                    : selectedIndex]
                                                .userId)
                                        ? ClientTile(
                                            index: controller.searchedClients
                                                        .length >
                                                    1
                                                ? index
                                                : selectedIndex,
                                            onTap: controller.getClientDetails,
                                            name:
                                                '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].firstName!} ${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].lastName}',
                                            membership:
                                                controller.tier[index].name!,
                                            checkColor: AppColors.BORDER_COLOR,
                                            textColor: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.BLACK_COLOR,
                                            iconColor: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.BLACK_COLOR,
                                          )
                                        : ClientTile(
                                            index: controller.searchedClients
                                                        .length >
                                                    1
                                                ? index
                                                : selectedIndex,
                                            onTap: controller.getClientDetails,
                                            name:
                                                '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].firstName!} ${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].lastName}',
                                            membership:
                                                controller.tier[index].name!,
                                            textColor:
                                                AppColors.SECONDARY_COLOR,
                                            iconColor:
                                                AppColors.SECONDARY_COLOR,
                                            checkColor:
                                                AppColors.SECONDARY_COLOR),
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: controller.clients
                                    .where((client) {
                                      return client.fullName
                                          .toLowerCase()
                                          .contains(
                                              controller.searchText.value);
                                    })
                                    .toList()
                                    .length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  controller.searchedClients.value =
                                      controller.clients.where((client) {
                                    return client.fullName
                                        .toLowerCase()
                                        .contains(controller.searchText.value);
                                  }).toList();
                                  int selectedIndex = controller
                                              .searchedClients.length >
                                          1
                                      ? index
                                      : controller.clients.indexWhere((client) {
                                          return client.fullName
                                              .toLowerCase()
                                              .contains(
                                                  controller.searchText.value);
                                        });
                                  return GestureDetector(
                                    onTap: () {
                                      controller.onTap(
                                          controller.searchedClients.length > 1
                                              ? index
                                              : selectedIndex);
                                    },
                                    child: !controller.selectedClients.contains(
                                            controller
                                                .clients[controller
                                                            .searchedClients
                                                            .length >
                                                        1
                                                    ? index
                                                    : selectedIndex]
                                                .userId)
                                        ? ClientTile(
                                            index: controller.searchedClients
                                                        .length >
                                                    1
                                                ? index
                                                : selectedIndex,
                                            onTap: controller.getClientDetails,
                                            name:
                                                '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].firstName!} ${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].lastName}',
                                            membership:
                                                controller.tier[index].name!,
                                            checkColor: AppColors.BORDER_COLOR,
                                            textColor: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.BLACK_COLOR,
                                            iconColor: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.BLACK_COLOR,
                                          )
                                        : ClientTile(
                                            index: controller.searchedClients
                                                        .length >
                                                    1
                                                ? index
                                                : selectedIndex,
                                            onTap: controller.getClientDetails,
                                            name:
                                                '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].firstName!} ${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].lastName}',
                                            membership:
                                                controller.tier[index].name!,
                                            textColor:
                                                AppColors.SECONDARY_COLOR,
                                            iconColor:
                                                AppColors.SECONDARY_COLOR,
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: PrimaryButton(
            color: isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
            buttonText: AppLanguages.AVANTI,
            width: Get.width,
            onTap: () {
              controller.goToServicesScreen();
            },
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
