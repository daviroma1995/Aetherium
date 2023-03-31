// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:atherium_saloon_app/screens/appointment_confirm_detail_screen/appointment_confirm_detail_controller.dart';
import 'package:atherium_saloon_app/screens/appointment_confirm_screen/appointment_confirm_screen.dart';

import '../../utils/constants.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/text_row_widget.dart';
import '../appointment_booking_screen/appointment_booking_screen.dart';

class AppointmentConfirmDetailScreen extends StatelessWidget {
  final bool? isDetail;
  final bool? isEditable;
  final controller = Get.put(AppointmentConfirmDetailController());
  AppointmentConfirmDetailScreen({
    Key? key,
    this.isDetail,
    this.isEditable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.args = Get.arguments;
    print(controller.args);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
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
                Get.back();
                controller.args = [];
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
            Expanded(
              child: Text(
                isDetail ?? false
                    ? AppLanguages.AppuntamentoDettagli
                    : AppLanguages.APPOINTMENTCONFERMA,
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: Get.width * .055),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18.0),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.PRIMARY_DARK
                          : AppColors.WHITE_COLOR,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      border: isDark
                          ? const Border()
                          : Border.all(color: AppColors.BORDER_COLOR)),
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextRowWidget(
                            textOne: 'Date: ',
                            textTwo: 'Time: ',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                    color: isDark
                                        ? AppColors.WHITE_COLOR
                                        : AppColors.SECONDARY_COLOR),
                          ),
                          const SizedBox(height: 20.0),
                          TextRowWidget(
                            textOne: '02/02/2023',
                            textTwo: '8:00 AM - 8:30 AM',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: isDark
                                  ? AppColors.GREY_COLOR
                                  : AppColors.BLACK_COLOR,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextRowWidget(
                            textOne: 'Number',
                            textTwo: 'Email',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                    color: isDark
                                        ? AppColors.WHITE_COLOR
                                        : AppColors.SECONDARY_COLOR),
                          ),
                          const SizedBox(height: 20.0),
                          TextRowWidget(
                            textOne: '+981 547 12545',
                            textTwo: 'client@example.com',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: isDark
                                  ? AppColors.GREY_COLOR
                                  : AppColors.BLACK_COLOR,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Services Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.0,
                                        color: isDark
                                            ? AppColors.WHITE_COLOR
                                            : AppColors.SECONDARY_COLOR),
                              ),
                              const SizedBox(height: 20.0),
                              controller.args!.isEmpty
                                  ? Text('Services are not selected')
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: controller.args!.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${controller.args![index].title} - ${controller.args![index].time}',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: isDark
                                                        ? AppColors.GREY_COLOR
                                                        : AppColors.BLACK_COLOR,
                                                  ),
                                                ),
                                                Text(
                                                  '${controller.args![index].price} \$',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: isDark
                                                        ? AppColors.GREY_COLOR
                                                        : AppColors.BLACK_COLOR,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10.0),
                                          ],
                                        );
                                      },
                                    ),
                              controller.args!.isEmpty
                                  ? const SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Total'),
                                        Text('${controller.totalPrice} \$'),
                                      ],
                                    ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Beauty Specialist',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                    color: isDark
                                        ? AppColors.WHITE_COLOR
                                        : AppColors.SECONDARY_COLOR),
                          ),
                          const SizedBox(height: 20.0),
                          specialistCard(
                            title: 'Ruth Ozaki',
                            imageUrl: AppAssets.USER_IMAGE,
                            subtitle: 'Fragrances',
                            isDark: isDark,
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            AppLanguages.NOTES,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0,
                                    color: isDark
                                        ? AppColors.WHITE_COLOR
                                        : AppColors.SECONDARY_COLOR),
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          const Text(
                            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 33.0),
                          isEditable ?? false
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ButtonWidget(
                                        width: Get.width / 2 - 32,
                                        buttonText: 'Cancel',
                                        buttonTextColor: isDark
                                            ? AppColors.SECONDARY_LIGHT
                                            : AppColors.BLACK_COLOR,
                                        borderColor: isDark
                                            ? AppColors.SECONDARY_LIGHT
                                            : AppColors.BLACK_COLOR,
                                        bordered: true,
                                        onTap: () {},
                                      ),
                                      ButtonWidget(
                                        width: Get.width / 2 - 32,
                                        buttonText: 'Edit',
                                        buttonTextColor: isDark
                                            ? AppColors.BACKGROUND_DARK
                                            : AppColors.WHITE_COLOR,
                                        color: isDark
                                            ? AppColors.SECONDARY_LIGHT
                                            : AppColors.PRIMARY_COLOR,
                                        bordered: false,
                                        onTap: () {},
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          isDetail ?? false
                              ? const SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: ButtonWidget(
                                    width: (Get.width) - 56.0,
                                    buttonText: 'Confirm',
                                    onTap: () {
                                      Get.to(
                                        () => AppointmentConfirmScreen(),
                                        duration:
                                            const Duration(milliseconds: 600),
                                        transition: Transition.leftToRight,
                                      );
                                    },
                                    color: isDark
                                        ? AppColors.SECONDARY_LIGHT
                                        : AppColors.PRIMARY_COLOR,
                                    buttonTextColor: isDark
                                        ? AppColors.PRIMARY_DARK
                                        : AppColors.WHITE_COLOR,
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
