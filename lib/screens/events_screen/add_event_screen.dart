import 'dart:io';

import 'package:atherium_saloon_app/models/client.dart';
import 'package:atherium_saloon_app/screens/account_info_screen/account_info_controller.dart';
import 'package:atherium_saloon_app/screens/events_screen/events_controller.dart';
import 'package:atherium_saloon_app/screens/home_screen/home_screen_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_label_widget.dart';
import '../../widgets/form_field_widget.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final controller = Get.put(EventsController());
  final homeController = Get.put(HomeScreenController());

  addEvent() {

    controller.validateTitle();
    controller.validateSubtitle();
    controller.validateDescription();
    controller.validatePlace();
    controller.validateEndTime();
    if (controller.titleControllerHasError.value ||
        controller.subTitleControllerHasError.value ||
        controller.descriptionControllerHasError.value ||
        controller.placeControllerHasError.value ||
        controller.endTimeHasError.value ) {
      print('arived for event');

      return;
    }

    if (controller.imageFileString.value == '') {

      Fluttertoast.showToast(msg: tr('image_is_required'));
      return;
    }

    controller.addEvent();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    AppAssets.ACOUNTS_INFO_SCREEN_CURVE,
                    height: Get.size.height * 0.30,
                    fit: BoxFit.fitHeight,
                    colorFilter: ColorFilter.mode(
                        isDark
                            ? AppColors.PRIMARY_DARK
                            : AppColors.PRIMARY_COLOR,
                        BlendMode.srcIn),
                  ),
                  Positioned(
                    bottom: 0,
                    left: (Get.width / 2) - 55.5,
                    child: Stack(
                      children: [
                        Container(
                            width: 111.0,
                            height: 111.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5.0, color: AppColors.BORDER_COLOR),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Obx(
                                () => controller.imageFileString.isEmpty
                                    ? Obx(
                                        () => Visibility(
                                          visible:
                                              controller.eventImage.isEmpty,
                                          replacement: CachedNetworkImage(
                                            imageUrl:
                                                controller.eventImage.value,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return Container(
                                                color: Colors.grey,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: isDark
                                                        ? AppColors
                                                            .SECONDARY_COLOR
                                                        : AppColors.GREY_COLOR,
                                                  ),
                                                ),
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return Image.asset(
                                                AppAssets.PROFILE_PIC,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                          child: Image.asset(
                                            AppAssets.PROFILE_PIC,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Obx(
                                        () => Image.file(
                                          File(
                                            controller.imageFileString.value,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              controller.pickImageFromMobile(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 35.0,
                              width: 35.0,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppColors.BACKGROUND_DARK
                                    : AppColors.PRIMARY_COLOR,
                                border: Border.all(
                                  color: AppColors.BORDER_COLOR,
                                  width: 3.3,
                                ),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                              child: SvgPicture.asset(AppAssets.CAMERA_ICON),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 21.0,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomLabelWidget(
                        label: 'title',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                      ),
                      Obx(
                        () => CustomInputFormField(
                          textEdigintController: controller.titleController,
                          hintText: tr('title'),
                          isValid: !controller.titleControllerHasError.value,
                          onSubmit: () {},
                          autoFocus: true,
                          onchange: (value) {
                            controller.validateTitle();
                          },
                          paddingSymetric: 16.0,
                        ),
                      ),
                      Obx(() => controller.titleControllerHasError.value == true
                          ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          controller.titleControllerErrorMessage.value,
                          style: const TextStyle(
                              color: AppColors.ERROR_COLOR),
                        ),
                      )
                          : const SizedBox()),
                      const SizedBox(height: 12.0),
                      CustomLabelWidget(
                        label: 'subtitle',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.WHITE_COLOR
                              : AppColors.SECONDARY_COLOR,
                        ),
                      ),
                      Obx(
                            () => CustomInputFormField(
                          textEdigintController: controller.subTitleController,
                          hintText: tr('subtitle'),
                          isValid: !controller.subTitleControllerHasError.value,
                          onSubmit: () {},
                          autoFocus: true,
                          onchange: (value) {
                            controller.validateSubtitle();
                          },
                          paddingSymetric: 16.0,
                        ),
                      ),
                      Obx(() => controller.subTitleControllerHasError.value == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                controller.subTitleControllerErrorMessage.value,
                                style: const TextStyle(
                                    color: AppColors.ERROR_COLOR),
                              ),
                            )
                          : const SizedBox()),
                      const SizedBox(height: 12.0),
                      CustomLabelWidget(
                        label: 'description',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.WHITE_COLOR
                              : AppColors.SECONDARY_COLOR,
                        ),
                      ),
                      Obx(
                            () => CustomInputFormField(
                          textEdigintController: controller.descriptionController,
                          hintText: tr('description'),
                          isValid: !controller.descriptionControllerHasError.value,
                          onSubmit: () {},
                              maxLines: 5,
                          autoFocus: true,
                          onchange: (value) {
                            controller.validateSubtitle();
                          },
                          paddingSymetric: 16.0,
                        ),
                      ),
                      Obx(() => controller.descriptionControllerHasError.value == true
                          ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          controller.descriptionControllerErrorMessage.value,
                          style: const TextStyle(
                              color: AppColors.ERROR_COLOR),
                        ),
                      )
                          : const SizedBox()),
                      const SizedBox(height: 12.0),
                      CustomLabelWidget(
                        label: 'place',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                      ),
                      Obx(
                        () => CustomInputFormField(
                          textEdigintController: controller.placeController,
                          hintText: tr('place'),
                          isValid: !controller.placeControllerHasError.value,
                          onSubmit: () {},
                          onchange: (value) {
                            controller.validatePlace();
                          },
                          autoFocus: true,
                          paddingSymetric: 16.0,
                        ),
                      ),
                      Obx(() => controller.placeControllerHasError.value == true
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                controller.placeControllerErrorMessage.value,
                                style: const TextStyle(
                                    color: AppColors.ERROR_COLOR),
                              ),
                            )
                          : const SizedBox()),
                      const SizedBox(height: 12.0),
                      CustomLabelWidget(
                        label: 'lat',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                      ),
                      CustomInputFormField(
                        textEdigintController: controller.latitudeController,
                        hintText: '00.00',
                        isValid: true,
                        keyboardType: TextInputType.number,
                        onSubmit: () {},
                        onchange: (value) {
                          // controller.validateEmail();
                        },
                        autoFocus: true,
                        paddingSymetric: 16.0,
                      ),

                      const SizedBox(height: 12.0),
                      CustomLabelWidget(
                        label: 'long',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                      ),
                      CustomInputFormField(
                        textEdigintController: controller.longitudeController,
                        keyboardType: TextInputType.number,
                        hintText: '00.00',
                        isValid: true,
                        onSubmit: () {},
                        onchange: (value) {
                          // controller.validatePhone();
                        },
                        autoFocus: true,
                        paddingSymetric: 16.0,
                      ),
                      const SizedBox(height: 12.0),
                      CustomLabelWidget(
                        label: 'invited',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                      ),
                      Container(
                        // height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xffDFDFDF))),
                        child: Center(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: MultiSelectDialogField(
                                decoration: BoxDecoration(
                                  // Add this line to customize the decoration
                                  border: Border.all(color: Colors.transparent),
                                  // Set border color to transparent
                                  borderRadius: BorderRadius.circular(
                                      10), // Optional: Add border radius
                                ),
                                items: homeController.allUsers
                                    .map((item) => MultiSelectItem<Client>(
                                        item, item.fullName))
                                    .toList(),
                                listType: MultiSelectListType.CHIP,
                                buttonIcon:
                                    Icon(Icons.arrow_drop_down_outlined),
                                onConfirm: (values) {
                                  controller.selectedClients.value = values;
                                },
                              )),
                        ),
                      ),
                      // Obx(
                      //       () => CustomDropDown(
                      //     height: 50.0,
                      //     label: tr('select_gender'),
                      //     sort: false,
                      //     options: [
                      //       tr('male'),
                      //       tr('female'),
                      //       tr('other')
                      //     ],
                      //     value: controller.genderValue.value,
                      //     onChange: (value) {
                      //       controller.changeValue(value);
                      //     },
                      //   ),
                      // ),


                      const SizedBox(height: 12.0),
                      CustomLabelWidget(
                        label: 'start_time',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          controller.selectTime(context, true);
                          // final date = await showDatePicker(
                          //   context: context,
                          //   initialDate: DateTime.now(),
                          //   firstDate: DateTime.utc(
                          //       1949, DateTime.january, 1),
                          //   lastDate: DateTime.now(),
                          //   helpText: tr('select_date_of_birth'),
                          //   cancelText: tr('cancel'),
                          //   confirmText: 'Ok',
                          //   builder: (context, child) {
                          //     return Theme(
                          //       data: Theme.of(context).copyWith(
                          //         colorScheme: ColorScheme.light(
                          //           primary: isDark
                          //               ? AppColors.PRIMARY_DARK
                          //               : AppColors
                          //               .PRIMARY_COLOR, // <-- SEE HERE
                          //           onPrimary: isDark
                          //               ? AppColors.GREY_COLOR
                          //               : AppColors
                          //               .WHITE_COLOR, // <-- SEE HERE
                          //           onSurface: isDark
                          //               ? AppColors.GREY_COLOR
                          //               : AppColors
                          //               .GREY_DARK, // <-- SEE HERE
                          //         ),
                          //         textButtonTheme:
                          //         TextButtonThemeData(
                          //           style: TextButton.styleFrom(
                          //               foregroundColor: isDark
                          //                   ? AppColors.GREY_COLOR
                          //                   : AppColors
                          //                   .PRIMARY_COLOR),
                          //         ),
                          //       ),
                          //       child: child!,
                          //     );
                          //   },
                          // );
                          // controller.eventDate.value =
                          //     DateTime.parse(
                          //       date.toString(),
                          //     );
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 18.0),
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.PRIMARY_DARK
                                : AppColors.WHITE_COLOR,
                            border: isDark
                                ? const Border()
                                : Border.all(
                                    width: 1.0,
                                    color: AppColors.BORDER_COLOR,
                                  ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Obx(
                            () => Text(DateFormat('dd/MM/yyyy HH:mm').format(controller.startTime.value)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      CustomLabelWidget(
                        label: 'end_time',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          controller.selectTime(context, false);
                          // final date = await showDatePicker(
                          //   context: context,
                          //   initialDate: DateTime.now(),
                          //   firstDate: DateTime.utc(
                          //       1949, DateTime.january, 1),
                          //   lastDate: DateTime.now(),
                          //   helpText: tr('select_date_of_birth'),
                          //   cancelText: tr('cancel'),
                          //   confirmText: 'Ok',
                          //   builder: (context, child) {
                          //     return Theme(
                          //       data: Theme.of(context).copyWith(
                          //         colorScheme: ColorScheme.light(
                          //           primary: isDark
                          //               ? AppColors.PRIMARY_DARK
                          //               : AppColors
                          //               .PRIMARY_COLOR, // <-- SEE HERE
                          //           onPrimary: isDark
                          //               ? AppColors.GREY_COLOR
                          //               : AppColors
                          //               .WHITE_COLOR, // <-- SEE HERE
                          //           onSurface: isDark
                          //               ? AppColors.GREY_COLOR
                          //               : AppColors
                          //               .GREY_DARK, // <-- SEE HERE
                          //         ),
                          //         textButtonTheme:
                          //         TextButtonThemeData(
                          //           style: TextButton.styleFrom(
                          //               foregroundColor: isDark
                          //                   ? AppColors.GREY_COLOR
                          //                   : AppColors
                          //                   .PRIMARY_COLOR),
                          //         ),
                          //       ),
                          //       child: child!,
                          //     );
                          //   },
                          // );
                          // controller.eventDate.value =
                          //     DateTime.parse(
                          //       date.toString(),
                          //     );
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 18.0),
                          height: 50.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.PRIMARY_DARK
                                : AppColors.WHITE_COLOR,
                            border: isDark
                                ? const Border()
                                : Border.all(
                                    width: 1.0,
                                    color: AppColors.BORDER_COLOR,
                                  ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Obx(
                            () => Text(DateFormat('dd/MM/yyyy HH:mm').format(controller.endTime.value)),
                          ),
                        ),
                      ),
                      Obx(() => controller.endTimeHasError.value == true
                          ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          controller.endTimeErrorMessage.value,
                          style: const TextStyle(
                              color: AppColors.ERROR_COLOR),
                        ),
                      )
                          : const SizedBox()),
                      const SizedBox(height: 12.0),
                      Obx(
                        () => AnimatedSize(
                          duration: const Duration(milliseconds: 250),
                          child: Visibility(
                            visible: controller.isLoading.value,
                            child: SizedBox(
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: isDark
                                      ? AppColors.SECONDARY_COLOR
                                      : AppColors.GREY_COLOR,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        children: [
                          PrimaryButton(
                            width: Get.width / 2 - 28,
                            buttonText: 'cancel',
                            onTap: () async {
                              Get.back();
                              // var isconfirmed =
                              //     await showOkCancelAlertDialog(
                              //   context: context,
                              //   title: 'Alert!',
                              //   message: tr(
                              //       'are_you_sure_you_want_to_delete_your_account'),
                              //   okLabel: tr('yes'),
                              //   cancelLabel: tr('no'),
                              //   style: AdaptiveStyle.adaptive,
                              // );
                              // if (isconfirmed ==
                              //     OkCancelResult.ok) {
                              //   controller.deleteUser();
                              // }
                            },
                            // color: Colors.black,
                            bordered: true,
                            borderColor: isDark
                                ? AppColors.SECONDARY_LIGHT
                                : AppColors.PRIMARY_COLOR,
                            buttonTextColor: isDark
                                ? AppColors.SECONDARY_LIGHT
                                : AppColors.PRIMARY_COLOR,
                          ),
                          const SizedBox(width: 12.0),
                          PrimaryButton(
                            width: Get.width / 2 - 28,
                            buttonText: 'save',
                            onTap: () {
                              addEvent();
                              // controller.saveUser();
                            },
                            color: isDark
                                ? AppColors.SECONDARY_LIGHT
                                : AppColors.PRIMARY_COLOR,
                            buttonTextColor: isDark
                                ? AppColors.PRIMARY_DARK
                                : AppColors.WHITE_COLOR,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

List<Item> items = [
  Item(id: 1, name: 'Item 1'),
  Item(id: 2, name: 'Item 2'),
  Item(id: 3, name: 'Item 3'),
  // Add more items as needed
];

class Item {
  int id;
  String name;

  Item({required this.id, required this.name});
}
