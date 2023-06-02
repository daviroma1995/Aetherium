import 'package:atherium_saloon_app/utils/constants.dart';
import 'package:atherium_saloon_app/widgets/button_widget.dart';
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
              Text(AppLanguages.NEWCLIENT,
                  style: Theme.of(context).textTheme.headlineLarge),
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
                      label: AppLanguages.NAME,
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
                        hintText: 'Name',
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
                      label: AppLanguages.SURNAME,
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
                        hintText: AppLanguages.SURNAME,
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
                      label: AppLanguages.EMAIL,
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
                      label: AppLanguages.PHONE_NUMBER,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppColors.WHITE_COLOR
                                : AppColors.SECONDARY_COLOR,
                          ),
                    ),
                    Obx(
                      () => CustomInputFormField(
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
                      label: AppLanguages.GENDER,
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
                        options: ['Male', 'Female'],
                        value: controller.genderValue.value,
                        onChange: (value) {
                          controller.changeValue(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    CustomLabelWidget(
                      label: AppLanguages.ADDRESS,
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
                        hintText: 'Address',
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
                      label: AppLanguages.BIRTHDAY,
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
                          () => Text(controller.getDateOfBirth),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Obx(
                      () => AnimatedSize(
                        duration: const Duration(milliseconds: 250),
                        child: Visibility(
                          visible: controller.isLoading.value,
                          child: const SizedBox(
                            height: 150,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        ButtonWidget(
                          width: Get.width / 2 - 28,
                          buttonText: 'Cancel',
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
                        ButtonWidget(
                          width: Get.width / 2 - 28,
                          buttonText: 'Save',
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
