// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:atherium_saloon_app/utils/constants.dart';

class OnBoardingModel {
  final int id;
  final String backgroundImageUrl;
  final String avatarImageUrl;
  final String title;
  final String description;
  final String buttonText;
  OnBoardingModel({
    required this.id,
    required this.backgroundImageUrl,
    required this.avatarImageUrl,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

List<OnBoardingModel> screens = [
  OnBoardingModel(
    id: 0,
    backgroundImageUrl: AppAssets.SCREEN_ONE_CURVE,
    avatarImageUrl: AppAssets.JADE_ROLLER,
    title: AppLanguages.FRAGRANCES_PERFUMES,
    description: AppLanguages.ONBOARDING_DESCRIPTION,
    buttonText: AppLanguages.AVANTI,
  ),
  OnBoardingModel(
    id: 1,
    backgroundImageUrl: 'assets/images/onboarding/screen_two.svg',
    avatarImageUrl: 'assets/images/onboarding/pimple_patches.svg',
    title: AppLanguages.APPDEO,
    description: AppLanguages.ONBOARDING_DESCRIPTION,
    buttonText: AppLanguages.AVANTI,
  ),
  OnBoardingModel(
    id: 2,
    backgroundImageUrl: 'assets/images/onboarding/screen_three.svg',
    avatarImageUrl: 'assets/images/onboarding/skin_care.svg',
    title: AppLanguages.FRAGRANCES_PERFUMES,
    description: AppLanguages.ONBOARDING_DESCRIPTION,
    buttonText: AppLanguages.INZIA,
  ),
];
