import 'dart:io';

import 'package:atherium_saloon_app/screens/account_info_screen/account_info_controller.dart';
import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_label_widget.dart';
import '../../widgets/form_field_widget.dart';

class AccountInfoScreen extends StatelessWidget {
  final controller = Get.put(AccountInfoController());
  AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
            () => controller.isLoading.value
                ? SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: isDark
                            ? AppColors.SECONDARY_COLOR
                            : AppColors.GREY_COLOR,
                      ),
                    ),
                  )
                : Column(
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
                                          width: 5.0,
                                          color: AppColors.BORDER_COLOR),
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Obx(
                                        () => controller.imageFileString.isEmpty
                                            ? Obx(
                                                () => Visibility(
                                                  visible: controller
                                                      .profileImageUrl.isEmpty,
                                                  replacement:
                                                      CachedNetworkImage(
                                                    imageUrl: controller
                                                        .profileImageUrl.value,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) {
                                                      return Container(
                                                        color: Colors.grey,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: isDark
                                                                ? AppColors
                                                                    .SECONDARY_COLOR
                                                                : AppColors
                                                                    .GREY_COLOR,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url, error) {
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
                                                    controller
                                                        .imageFileString.value,
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
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                      child: SvgPicture.asset(
                                          AppAssets.CAMERA_ICON),
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
                        child: Obx(
                          () => controller.currentClient.value.email != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomLabelWidget(
                                      label: 'name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR,
                                          ),
                                    ),
                                    Obx(
                                      () => CustomInputFormField(
                                        textEdigintController: controller.name,
                                        hintText: tr('name'),
                                        isValid: !controller.nameHasError.value,
                                        onSubmit: () {},
                                        autoFocus: true,
                                        onchange: (value) {
                                          controller.validateName();
                                        },
                                        paddingSymetric: 16.0,
                                      ),
                                    ),
                                    Obx(() => controller.nameHasError.value ==
                                            true
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              controller.nameErrorMessage.value,
                                              style: const TextStyle(
                                                  color: AppColors.ERROR_COLOR),
                                            ),
                                          )
                                        : const SizedBox()),
                                    const SizedBox(height: 12.0),
                                    CustomLabelWidget(
                                      label: 'surname',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR,
                                          ),
                                    ),
                                    Obx(
                                      () => CustomInputFormField(
                                        textEdigintController:
                                            controller.surName,
                                        hintText: tr('surname'),
                                        isValid:
                                            !controller.surNameHasError.value,
                                        onSubmit: () {},
                                        onchange: (value) {
                                          controller.validateSurName();
                                        },
                                        autoFocus: true,
                                        paddingSymetric: 16.0,
                                      ),
                                    ),
                                    Obx(() => controller
                                                .surNameHasError.value ==
                                            true
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              controller
                                                  .surNameErrorMessage.value,
                                              style: const TextStyle(
                                                  color: AppColors.ERROR_COLOR),
                                            ),
                                          )
                                        : const SizedBox()),
                                    const SizedBox(height: 12.0),
                                    CustomLabelWidget(
                                      label: 'email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR,
                                          ),
                                    ),
                                    CustomInputFormField(
                                      textEdigintController: controller.email,
                                      hintText: 'Email@gmail.com',
                                      isValid: !controller.emailHasError.value,
                                      onSubmit: () {},
                                      onchange: (value) {
                                        controller.validateEmail();
                                      },
                                      autoFocus: true,
                                      paddingSymetric: 16.0,
                                    ),
                                    Obx(() => controller.emailHasError.value ==
                                            true
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              controller
                                                  .emailErrorMessage.value,
                                              style: const TextStyle(
                                                  color: AppColors.ERROR_COLOR),
                                            ),
                                          )
                                        : const SizedBox()),
                                    const SizedBox(height: 12.0),
                                    CustomLabelWidget(
                                      label: 'telephone',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR,
                                          ),
                                    ),
                                    CustomInputFormField(
                                      textEdigintController: controller.phone,
                                      keyboardType: TextInputType.number,
                                      hintText: '+956 424 2687',
                                      isValid: !controller.phoneHasError.value,
                                      onSubmit: () {},
                                      onchange: (value) {
                                        controller.validatePhone();
                                      },
                                      autoFocus: true,
                                      paddingSymetric: 16.0,
                                    ),
                                    Obx(() => controller.phoneHasError.value ==
                                            true
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              controller
                                                  .phoneErrorMessage.value,
                                              style: const TextStyle(
                                                  color: AppColors.ERROR_COLOR),
                                            ),
                                          )
                                        : const SizedBox()),
                                    const SizedBox(height: 12.0),
                                    CustomLabelWidget(
                                      label: 'gender',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR,
                                          ),
                                    ),
                                    Obx(
                                      () => CustomDropDown(
                                        height: 50.0,
                                        label: tr('select_gender'),
                                        options: [tr('male'), tr('female')],
                                        value: controller.genderValue.value,
                                        onChange: (value) {
                                          controller.changeValue(value);
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    CustomLabelWidget(
                                      label: tr('address'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR,
                                          ),
                                    ),
                                    CustomInputFormField(
                                      textEdigintController: controller.address,
                                      hintText: tr('address'),
                                      isValid:
                                          !controller.addressHasError.value,
                                      onSubmit: () {},
                                      onchange: (value) {
                                        controller.validateAddress();
                                      },
                                      autoFocus: false,
                                      paddingSymetric: 16.0,
                                    ),
                                    Obx(() => controller
                                                .addressHasError.value ==
                                            true
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              controller
                                                  .addressErrorMessage.value,
                                              style: const TextStyle(
                                                  color: AppColors.ERROR_COLOR),
                                            ),
                                          )
                                        : const SizedBox()),
                                    const SizedBox(height: 12.0),
                                    CustomLabelWidget(
                                      label: 'birthday',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: isDark
                                                ? AppColors.WHITE_COLOR
                                                : AppColors.SECONDARY_COLOR,
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.utc(
                                              1949, DateTime.january, 1),
                                          lastDate: DateTime.now(),
                                          helpText: tr('select_date_of_birth'),
                                        );
                                        controller.dateOfBirth.value =
                                            DateTime.parse(
                                          date.toString(),
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        padding:
                                            const EdgeInsets.only(left: 18.0),
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
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Obx(
                                          () => Text(controller.getDateOfBirth),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    Obx(
                                      () => AnimatedSize(
                                        duration:
                                            const Duration(milliseconds: 250),
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
                                            controller.saveUser();
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
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: isDark
                                        ? AppColors.SECONDARY_COLOR
                                        : AppColors.GREY_COLOR,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
