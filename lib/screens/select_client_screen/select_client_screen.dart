// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
              Text('select_client',
                      style: Theme.of(context).textTheme.headlineLarge)
                  .tr(),
            ],
          ),
        ),
        body: Obx(() =>  Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: CustomInputFormField(
                      textEdigintController: controller.search,
                      hintText: tr('search'),
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

                     IgnorePointer(
                       ignoring: controller.isDeleting.value,
                       child: Padding(
                          padding: const EdgeInsets.only(left: 22.0, right: 22.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(),
                            ),
                            child: Obx(
                              () => controller.clients.isEmpty || controller.tier.isEmpty
                                  ? CircularProgressIndicator(
                                      color: isDark
                                          ? AppColors.SECONDARY_COLOR
                                          : AppColors.GREY_COLOR,
                                    )
                                  : controller.isLoaded.value
                                      ? Container(
                                          height:
                                              MediaQuery.of(context).size.height / 1.41,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            itemCount: controller.clients
                                                .where((client) {
                                                  return client.fullName
                                                      .toLowerCase()
                                                      .contains(
                                                          controller.searchText.value);
                                                })
                                                .toList()
                                                .length,
                                            // shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              controller.searchedClients.value =
                                                  controller.clients.where((client) {
                                                return client.fullName
                                                    .toLowerCase()
                                                    .contains(
                                                        controller.searchText.value);
                                              }).toList();
                                              int selectedIndex =
                                                  controller.searchedClients.length > 1
                                                      ? index
                                                      : controller.clients
                                                          .indexWhere((client) {
                                                          return client.fullName
                                                              .toLowerCase()
                                                              .contains(controller
                                                                  .searchText.value);
                                                        });
                                              return  GestureDetector(
                                                onLongPress: () {
                                                  //
                                                  //     return AlertDialog(
                                                  //       alignment: Alignment.center,
                                                  //       title: Text(tr('are_you_sure')),
                                                  //       content: FutureBuilder(
                                                  //         // Replace with the asynchronous operation that deletes the account
                                                  //         future: controller.longPress(
                                                  //                           controller.searchedClients
                                                  //                                       .length >
                                                  //                                   1
                                                  //                               ? index
                                                  //                               : selectedIndex
                                                  //         ),
                                                  //         builder: (context, snapshot) {
                                                  //           if (snapshot.connectionState == ConnectionState.waiting) {
                                                  //             // Show a loading indicator while the deletion is in progress
                                                  //             return CircularProgressIndicator();
                                                  //           } else if (snapshot.hasError) {
                                                  //             // Handle error case
                                                  //             return Text(tr('error_occurred'));
                                                  //           } else {
                                                  //             // Show the confirmation message after successful deletion
                                                  //             return Text(tr('user_account_deleted'));
                                                  //           }
                                                  //         },
                                                  //       ),
                                                  //       actions: [
                                                  //         // If the deletion is still in progress, disable the buttons
                                                  //         // until the operation completes
                                                  //         TextButton(
                                                  //           onPressed: snapshot.connectionState == ConnectionState.waiting
                                                  //               ? null
                                                  //               : () {
                                                  //             Navigator.of(context).pop();
                                                  //           },
                                                  //           child: Text(tr('no')),
                                                  //         ),
                                                  //         ElevatedButton(
                                                  //           onPressed: snapshot.connectionState == ConnectionState.waiting
                                                  //               ? null
                                                  //               : () async {
                                                  //             // Perform the deletion operation here
                                                  //             await controller.longPress(
                                                  //                 controller.searchedClients.length > 1
                                                  //                     ? index
                                                  //                     : selectedIndex);
                                                  //             Fluttertoast.showToast(msg: tr('user_deleted'));
                                                  //             // Close the dialog
                                                  //             Navigator.of(context).pop();
                                                  //             Navigator.of(context).pop();
                                                  //           },
                                                  //           child: Text(tr('yes')),
                                                  //         ),
                                                  //       ],
                                                  //     );
                                                  //   },
                                                  // );

                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        var yesButton = PrimaryButton(
                                                            color: AppColors.ERROR_COLOR,
                                                            width: 60,
                                                            buttonText: 'yes',
                                                            onTap: () async {
                                                              Navigator.of(context).pop();
                                                              await controller.longPress(
                                                                  controller.searchedClients
                                                                              .length >
                                                                          1
                                                                      ? index
                                                                      : selectedIndex);

                                                              // ignore: use_build_context_synchronously
                                                              Get.back();
                                                              // Get.back();
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      tr('user_deleted'));
                                                            });
                                                        var noButton = TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text(tr('no')),
                                                        );
                                                        return controller.isDeleting.value?CupertinoActivityIndicator():
                                                        AlertDialog(
                                                          alignment: Alignment.center,
                                                          title: Text(tr('are_you_sure')),
                                                          content: Text(tr(
                                                              'user_account_will_be_deleted_permanently')),
                                                          actions: [yesButton, noButton],
                                                        );
                                                      });
                                                },
                                                onTap: () {
                                                  controller.onTap(
                                                      controller.searchedClients.length >
                                                              1
                                                          ? index
                                                          : selectedIndex);
                                                },
                                                child: !controller.selectedClients
                                                        .contains(controller
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
                                                        onTap:
                                                            controller.getClientDetails,
                                                        name:
                                                            '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].firstName!} ${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].lastName}',
                                                        membership:
                                                        // '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].membershipName}',
                                                            controller.tier[index].name!,
                                                        checkColor:
                                                            AppColors.BORDER_COLOR,
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
                                                        onTap:
                                                            controller.getClientDetails,
                                                        name:
                                                            '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].firstName!} ${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].lastName}',
                                                        membership:
                                                        // '${{controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].membershipName!}}',
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
                                        )
                                      : Container(
                                          height:
                                              MediaQuery.of(context).size.height / 1.41,
                                          width: MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            itemCount: controller.clients
                                                .where((client) {
                                                  return client.fullName
                                                      .toLowerCase()
                                                      .contains(
                                                          controller.searchText.value);
                                                })
                                                .toList()
                                                .length,
                                            // shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // return Container(
                                              //   height: 30,
                                              //   width: 100,
                                              //   color: Colors.green,
                                              //   child: Text(index.toString()),
                                              // );
                                              controller.searchedClients.value =
                                                  controller.clients.where((client) {
                                                return client.fullName
                                                    .toLowerCase()
                                                    .contains(
                                                        controller.searchText.value);
                                              }).toList();
                                              int selectedIndex =
                                                  controller.searchedClients.length > 1
                                                      ? index
                                                      : controller.clients
                                                          .indexWhere((client) {
                                                          return client.fullName
                                                              .toLowerCase()
                                                              .contains(controller
                                                                  .searchText.value);
                                                        });
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.onTap(
                                                      controller.searchedClients.length >
                                                              1
                                                          ? index
                                                          : selectedIndex);
                                                },
                                                child: !controller.selectedClients
                                                        .contains(controller
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
                                                        onTap:
                                                            controller.getClientDetails,
                                                        name:
                                                            '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].firstName!} ${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].lastName}',
                                                        membership:
                                                        // '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].membershipName}',
                                                            controller.tier[index].name!,
                                                        checkColor:
                                                            AppColors.BORDER_COLOR,
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
                                                        onTap:
                                                            controller.getClientDetails,
                                                        name:
                                                            '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].firstName!} ${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].lastName}',
                                                        membership:
                                                        // '${controller.clients[controller.searchedClients.length > 1 ? index : selectedIndex].membershipName!}',
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
                          ),
                        ),
                     ),



                ],
              ),
            ),
            Center(
              child: Visibility(
                visible: controller.isDeleting.value,
                child: CupertinoActivityIndicator(
                  radius: 30,
                ),
              ),
            ),
          ],
        )),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 22.0),
        //   child: PrimaryButton(
        //     color: isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
        //     buttonText: 'next',
        //     width: Get.width,
        //     onTap: () {
        //       controller.goToServicesScreen();
        //     },
        //   ),
        // ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
          child: PrimaryButton(
            color: isDark ? AppColors.PRIMARY_DARK : AppColors.PRIMARY_COLOR,
            buttonText: 'next',
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
