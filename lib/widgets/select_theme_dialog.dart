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
                      const Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              "App Theme",
                              style: TextStyle(
                                fontSize: 18,
                                // TODO TEXT STYLE
                              ),
                            ),
                          )),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: MaterialButton(
                          height: 0,
                          shape: const CircleBorder(),
                          color: Colors.black, // TODO COLOR
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
                      "Please select from the following three choices:\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12), // TODO FONT
                    ),
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
                            "System Default",
                            // TODO FONTS SYSTEM DEFAULT
                          ),
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
                            "Dark Theme",
                            style: TextStyle(
                              fontFamily: 'Lato',
                              // TODO DARK THEME STYLE
                            ),
                          ),
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
                            "Light Theme",
                          ),
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
                  child: const Text('Apply'),
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
