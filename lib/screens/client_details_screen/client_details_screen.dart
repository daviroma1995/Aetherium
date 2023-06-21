// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../models/client.dart';
import '../../utils/constants.dart';
import '../../widgets/text_row_widget.dart';
import 'client_details_controller.dart';

class ClientDetailsScreen extends StatelessWidget {
  ClientDetailsScreen({
    Key? key,
    required this.client,
  }) : super(key: key);
  final ClientDetailsController controller = Get.put(ClientDetailsController());

  final Client client;
  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;
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
              onTap: () => controller.handleBack(),
              child: Container(
                alignment: Alignment.center,
                width: 25.0,
                height: 25.0,
                child: SvgPicture.asset(AppAssets.BACK_ARROW,
                    height: 14.0, width: 14.0),
              ),
            ),
            const SizedBox(width: 12.0),
            Text(AppLanguages.CLIENT_DETAILS,
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    border: isDark
                        ? const Border()
                        : Border.all(color: AppColors.BORDER_COLOR),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextRowWidget(
                            textOne: 'Nome: ',
                            textTwo: 'Cognome: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextRowWidget(
                            textOne: '${client.firstName}',
                            textTwo: '${client.lastName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextRowWidget(
                            textOne: 'Compleanno: ',
                            textTwo: 'Genere: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextRowWidget(
                            textOne: client.getBirthday(),
                            textTwo: '${client.gender}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextRowWidget(
                            textOne: 'Email: ',
                            textTwo: 'Numero: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextRowWidget(
                            textOne: '${client.email}',
                            textTwo: '${client.phoneNumber}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            '${AppLanguages.ADDRESS}:',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            client.address!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                              color: AppColors.GREY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextRowWidget(
                            textOne: 'Tier: ',
                            textTwo: 'Points: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.0,
                              color: isDark
                                  ? AppColors.WHITE_COLOR
                                  : AppColors.SECONDARY_COLOR,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Obx(
                            () => TextRowWidget(
                              textOne: controller.loading.value
                                  ? 'Waiting...'
                                  : controller.membershipType.value.name!
                                      .toString()
                                      .capitalize!,
                              textTwo: controller.clientMembership.value.points
                                  .toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                                color: AppColors.GREY_COLOR,
                              ),
                            ),
                          ),
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
