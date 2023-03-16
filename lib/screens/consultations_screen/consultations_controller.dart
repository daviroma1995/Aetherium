// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class ConsultationsController extends GetxController {
  // TODO Implementation
}

class Consultation {
  final String title;
  final String subTitle;
  Consultation({
    required this.title,
    required this.subTitle,
  });
}

List<Consultation> consultations = [
  Consultation(title: 'Ayse Cam', subTitle: 'Ultra-Shine Nourishing Lipsting'),
  Consultation(title: 'Imdat Cimsit', subTitle: 'Weightless Foundation'),
  Consultation(title: 'Kamile Kurtoglu', subTitle: 'Waterproof Eye Pencil'),
  Consultation(
      title: 'Sefika Gulsen Yildiz', subTitle: 'Velvet Plush Lipstick'),
  Consultation(title: 'Ayse Cam', subTitle: 'Ultra-Shine Nourishing Lipsting'),
  Consultation(title: 'Imdat Cimsit', subTitle: 'Weightless Foundation'),
  Consultation(title: 'Kamile Kurtoglu', subTitle: 'Waterproof Eye Pencil'),
  Consultation(
      title: 'Sefika Gulsen Yildiz', subTitle: 'Velvet Plush Lipstick'),
];
