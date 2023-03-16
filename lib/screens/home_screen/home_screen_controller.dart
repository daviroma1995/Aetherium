import 'package:atherium_saloon_app/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final searchController = TextEditingController();

  void setFavorite(int index) {
    events[index].isFavorite.value = !events[index].isFavorite.value;
  }
}
