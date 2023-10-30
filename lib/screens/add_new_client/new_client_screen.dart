import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/primary_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_drop_down_widget.dart';
import '../../widgets/custom_label_widget.dart';
import '../../widgets/form_field_widget.dart';
import 'add_new_client_controller.dart';

class AddNewClient extends StatelessWidget {
  final controller = Get.put(AddNewClientController());
  AddNewClient({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
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
              Text('new_client',
                      style: Theme.of(context).textTheme.headlineLarge)
                  .tr(),
            ],
          ),
        ),
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomLabelWidget(
                      label: 'name',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                        autoFocus: false,
                        onchange: (value) {
                          controller.validateName();
                        },
                        paddingSymetric: 16.0,
                      ),
                    ),
                    Obx(() => controller.nameHasError.value == true
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.nameErrorMessage.value,
                              style:
                                  const TextStyle(color: AppColors.ERROR_COLOR),
                            ),
                          )
                        : const SizedBox()),
                    const SizedBox(height: 12.0),
                    CustomLabelWidget(
                      label: 'surname',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.SECONDARY_COLOR,
                          ),
                    ),
                    Obx(
                      () => CustomInputFormField(
                        textEdigintController: controller.surName,
                        hintText: tr('surname'),
                        isValid: !controller.surNameHasError.value,
                        onSubmit: () {},
                        onchange: (value) {
                          controller.validateSurName();
                        },
                        autoFocus: false,
                        paddingSymetric: 16.0,
                      ),
                    ),
                    Obx(() => controller.surNameHasError.value == true
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.surNameErrorMessage.value,
                              style:
                                  const TextStyle(color: AppColors.ERROR_COLOR),
                            ),
                          )
                        : const SizedBox()),
                    const SizedBox(height: 12.0),
                    CustomLabelWidget(
                      label: 'email',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.SECONDARY_COLOR,
                          ),
                    ),
                    Obx(
                      () => CustomInputFormField(
                        textEdigintController: controller.email,
                        hintText: 'Email@gmail.com',
                        isValid: !controller.emailHasError.value,
                        onSubmit: () {},
                        onchange: (value) {
                          controller.validateEmail();
                        },
                        autoFocus: false,
                        paddingSymetric: 16.0,
                      ),
                    ),
                    Obx(() => controller.emailHasError.value == true
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.emailErrorMessage.value,
                              style:
                                  const TextStyle(color: AppColors.ERROR_COLOR),
                            ),
                          )
                        : const SizedBox()),
                    const SizedBox(height: 12.0),
                    CustomLabelWidget(
                      label: 'telephone',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.SECONDARY_COLOR,
                          ),
                    ),
                    Obx(
                      () => CustomInputFormField(
                        keyboardType: TextInputType.phone,
                        textEdigintController: controller.phone,
                        hintText: '+956 424 2687',
                        isValid: !controller.phoneHasError.value,
                        onSubmit: () {},
                        onchange: (value) {
                          controller.validatePhone();
                        },
                        autoFocus: false,
                        paddingSymetric: 16.0,
                      ),
                    ),
                    Obx(() => controller.phoneHasError.value == true
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.phoneErrorMessage.value,
                              style:
                                  const TextStyle(color: AppColors.ERROR_COLOR),
                            ),
                          )
                        : const SizedBox()),
                    const SizedBox(height: 12.0),
                    CustomLabelWidget(
                      label: 'gender',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.SECONDARY_COLOR,
                          ),
                    ),
                    Obx(
                      () => CustomDropDown(
                        height: 50.0,
                        label: 'Select Gender',
                        options: [tr('male'), tr('female'), tr('other')],
                        value: controller.genderValue.value,
                        sort: false,
                        onChange: (value) {
                          controller.changeValue(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    CustomLabelWidget(
                      label: tr('address'),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.SECONDARY_COLOR,
                          ),
                    ),
                    Obx(
                      () => CustomInputFormField(
                        textEdigintController: controller.address,
                        hintText: tr('address'),
                        isValid: !controller.addressHasError.value,
                        onSubmit: () {},
                        onchange: (value) {
                          controller.validateAddress();
                        },
                        autoFocus: false,
                        paddingSymetric: 16.0,
                      ),
                    ),
                    Obx(() => controller.addressHasError.value == true
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              controller.addressErrorMessage.value,
                              style:
                                  const TextStyle(color: AppColors.ERROR_COLOR),
                            ),
                          )
                        : const SizedBox()),
                    const SizedBox(height: 12.0),
                    CustomLabelWidget(
                      label: 'birthday',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                          firstDate: DateTime.utc(1949, DateTime.january, 1),
                          lastDate: DateTime.now(),
                          helpText: 'Select Date of Birth',
                          cancelText: tr('cancel'),
                          confirmText: 'Ok',
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: isDark
                                      ? AppColors.PRIMARY_DARK
                                      : AppColors.PRIMARY_COLOR, // <-- SEE HERE
                                  onPrimary: isDark
                                      ? AppColors.GREY_COLOR
                                      : AppColors.WHITE_COLOR, // <-- SEE HERE
                                  onSurface: isDark
                                      ? AppColors.GREY_COLOR
                                      : AppColors.GREY_DARK, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                      foregroundColor: isDark
                                          ? AppColors.GREY_COLOR
                                          : AppColors.PRIMARY_COLOR),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        controller.dateOfBirth.value = DateTime.parse(
                          date.toString(),
                        );
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
                          () => Text(
                            controller.getDateOfBirth,
                            style: TextStyle(
                                color: isDark
                                    ? controller.getDateOfBirth == tr('date')
                                        ? AppColors.GREY_COLOR
                                        : AppColors.GREY_COLOR
                                    : controller.getDateOfBirth == tr('date')
                                        ? AppColors.GREY_COLOR
                                        : AppColors.PRIMARY_DARK),
                          ),
                        ),
                      ),
                    ),
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
                    Row(
                      children: [
                        PrimaryButton(
                          width: Get.width / 2 - 28,
                          buttonText: 'cancel',
                          onTap: () async {
                            Get.back();
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
                            controller.validateAndSave();
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
