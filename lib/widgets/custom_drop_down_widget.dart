import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class CustomDropDown extends StatelessWidget {
  final List? options;
  dynamic value;
  final String label;
  final bool? showLabel;
  final bool? isFowrardArrow;
  final String? hintIcon;
  final String? subHint;
  final double? height;
  final ValueChanged? onChange;
  final VoidCallback? onTap;
  final VoidCallback? onDone;
  final double? iconHeight;
  final double? iconWidth;
  final bool readOnly, isMap, sort;
  CustomDropDown({
    Key? key,
    required this.label,
    this.options,
    this.value,
    this.onChange,
    this.hintIcon,
    this.height,
    this.onTap,
    this.showLabel = false,
    this.readOnly = false,
    this.iconHeight,
    this.iconWidth,
    this.isMap = false,
    this.sort = true,
    this.onDone,
    this.subHint,
    this.isFowrardArrow = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (sort)
      (options ?? []).sort((a, b) {
        return isMap
            ? a['name'].toLowerCase().compareTo(b['name'].toLowerCase())
            : a.toString().toLowerCase().compareTo(b.toString().toLowerCase());
      });
    int index = (options == null)
        ? 0
        : options!
            .indexWhere((element) => element.toString() == value.toString());
    final scrollController = FixedExtentScrollController(initialItem: index);
    print(CupertinoIcons.option);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel!)
          Text(
            label.toUpperCase(),
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        if (showLabel!) const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: height ?? 40,
            decoration: BoxDecoration(
                color: isDark ? AppColors.PRIMARY_DARK : AppColors.WHITE_COLOR,
                border: isDark
                    ? const Border()
                    : Border.all(color: AppColors.BORDER_COLOR, width: 1),
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const []),
            child: InkWell(
              onTap: onTap ??
                  () {
                    if (options == null || readOnly) return;
                    showCupertinoModalPopup(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder: (context) => SizedBox(
                        height: 275,
                        child: Column(
                          children: [
                            Material(
                              color: isDark
                                  ? AppColors.PRIMARY_DARK
                                  : AppColors.GREY_COLOR,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        scrollController.animateToItem(
                                          index == 0 ? -1 : --index,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear,
                                        );
                                      },
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(Icons.arrow_back_ios_new,
                                            color: isDark
                                                ? AppColors.GREY_COLOR
                                                : Colors.black),
                                      ),
                                    ),
                                    const SizedBox(width: 20.0),
                                    InkWell(
                                      onTap: () {
                                        scrollController.animateToItem(
                                          index == options!.length - 1
                                              ? options!.length
                                              : ++index,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.linear,
                                        );
                                      },
                                      child: RotatedBox(
                                        quarterTurns: 1,
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: isDark
                                                ? AppColors.GREY_COLOR
                                                : Colors.black),
                                      ),
                                    ),
                                    const Spacer(),
                                    InkWell(
                                      onTap: () {
                                        if (value == null) {
                                          onChange!(options![index]);
                                        }
                                        if (onDone != null) {
                                          onDone!.call();
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Done',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: isDark
                                              ? AppColors.WHITE_COLOR
                                              : AppColors.BLACK_COLOR,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 225,
                              child: ScrollConfiguration(
                                behavior: ScrollBehavior(),
                                child: CupertinoPicker(
                                  backgroundColor: isDark
                                      ? AppColors.BACKGROUND_DARK
                                      : const Color(0XFFCED2DA),
                                  itemExtent: 33.0,
                                  magnification: 1.22,
                                  squeeze: 1.2,
                                  useMagnifier: true,
                                  scrollController: scrollController,
                                  onSelectedItemChanged: (i) {
                                    if (onChange == null) return;
                                    onChange!(options![i]);
                                    value = options![i];
                                  },
                                  children: List.generate(
                                    options!.length,
                                    (index) => Center(
                                      child: Text(
                                        options![index],
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
              child: Row(
                children: [
                  if (hintIcon != null)
                    Center(
                      child: SvgPicture.asset(
                        'assets/images/svg/$hintIcon.svg',
                        colorFilter: ColorFilter.mode(
                            AppColors.GREY_COLOR, BlendMode.srcIn),
                        height: iconHeight ?? 14,
                        width: iconWidth ?? 14,
                      ),
                    ),
                  if (hintIcon != null)
                    const SizedBox(
                      width: 12,
                    ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (isMap && value != null)
                              ? (value is Map ? value['name'] : value)
                              : value ?? label.toUpperCase(),
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        if (subHint != null)
                          Text(
                            subHint!,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 0.8,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!readOnly)
                    Icon(
                        isFowrardArrow!
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_down,
                        size: isFowrardArrow! ? 25 : 18,
                        color: isDark
                            ? AppColors.GREY_COLOR
                            : AppColors.GREY_COLOR)
                ],
              ),
            )),
      ],
    );
  }
}
