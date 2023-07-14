import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class SelectThemeDialog extends StatefulWidget {
  const SelectThemeDialog({Key? key, this.themeMode}) : super(key: key);
  final AdaptiveThemeMode? themeMode;
  @override
  // ignore: library_private_types_in_public_api
  _SelectThemeDialogState createState() => _SelectThemeDialogState();
}

class _SelectThemeDialogState extends State<SelectThemeDialog> {
  int themeValue = 0;
  @override
  void initState() {
    super.initState();
    themeValue = 0;
    if (widget.themeMode == AdaptiveThemeMode.dark) {
      themeValue = 1;
    } else if (widget.themeMode == AdaptiveThemeMode.light) {
      themeValue = 2;
    } else {
      themeValue = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      backgroundColor:
          isDark ? AppColors.BACKGROUND_DARK : theme.colorScheme.background,
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: const Text(
                              'app_theme',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ).tr(),
                          )),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: MaterialButton(
                          height: 0,
                          shape: const CircleBorder(),
                          color: Colors.black,
                          onPressed: () {
                            Get.back();
                          },
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.clear,
                              size: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    const SizedBox(height: 25),
                    const Text(
                      "Please_select_from_the_following_three_choices",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ).tr(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          themeValue = 0;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                              value: 0,
                              groupValue: themeValue,
                              onChanged: (selectedValue) {
                                setState(() {
                                  themeValue = selectedValue as int;
                                });
                              }),
                          const Text(
                            "system_default",
                          ).tr(),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          themeValue = 1;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                              value: 1,
                              groupValue: themeValue,
                              onChanged: (selectedValue) {
                                setState(() {
                                  themeValue = selectedValue as int;
                                });
                              }),
                          const Text(
                            "dark_theme",
                            style: TextStyle(
                              fontFamily: 'Lato',
                            ),
                          ).tr(),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          themeValue = 2;
                        });
                      },
                      child: Row(
                        children: [
                          Radio(
                              value: 2,
                              groupValue: themeValue,
                              onChanged: (selectedValue) {
                                setState(() {
                                  themeValue = selectedValue as int;
                                });
                              }),
                          const Text(
                            "light_theme",
                          ).tr(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  child: const Text('apply').tr(),
                  onPressed: () {
                    if (themeValue == 0) {
                      AdaptiveTheme.of(context).setSystem();
                    } else if (themeValue == 1) {
                      AdaptiveTheme.of(context).setDark();
                    } else {
                      AdaptiveTheme.of(context).setLight();
                    }
                    Get.back();
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
