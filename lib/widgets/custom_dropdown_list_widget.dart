// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class CustomDropDownListWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final List items;
  bool isExpanded;

  CustomDropDownListWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.items,
    required this.isExpanded,
  }) : super(key: key);

  @override
  State<CustomDropDownListWidget> createState() =>
      _CustomDropDownListWidgetState();
}

class _CustomDropDownListWidgetState extends State<CustomDropDownListWidget>
    with SingleTickerProviderStateMixin {
  bool _isSelected = false;
  List selectedItems = [];

  _CustomDropDownListWidgetState();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        border:
            isDark ? const Border() : Border.all(color: AppColors.BORDER_COLOR),
        borderRadius: BorderRadius.circular(8.0),
        color: !widget.isExpanded
            ? isDark
                ? AppColors.PRIMARY_DARK
                : AppColors.SECONDARY_LIGHT
            : isDark
                ? AppColors.PRIMARY_DARK
                : AppColors.BACKGROUND_COLOR,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.isExpanded = !widget.isExpanded;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 10.0,
            bottom: 10.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 50.0,
                        width: 50.0,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset(widget.imageUrl)),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        widget.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .75,
                            ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isExpanded = !widget.isExpanded;
                      });
                    },
                    icon: !widget.isExpanded
                        ? SvgPicture.asset(AppAssets.ARROW_DOWN)
                        : SvgPicture.asset(
                            AppAssets.ARROW_UP,
                            colorFilter: ColorFilter.mode(
                                isDark
                                    ? AppColors.WHITE_COLOR
                                    : AppColors.BLACK_COLOR,
                                BlendMode.srcIn),
                          ),
                  ),
                ],
              ),
              widget.isExpanded
                  ? const SizedBox(height: 10.0)
                  : const SizedBox(),
              widget.isExpanded
                  ? ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedItems.contains(widget.items[index])) {
                                selectedItems.remove(widget.items[index]);
                              } else {
                                selectedItems.add(widget.items[index]);
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15.0),
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              bottom: 13.0,
                            ),
                            decoration: BoxDecoration(
                              border: (index + 1) == widget.items.length
                                  ? Border()
                                  : Border(
                                      bottom: BorderSide(
                                          color: AppColors.BORDER_COLOR),
                                    ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.items[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: selectedItems
                                            .contains(widget.items[index])
                                        ? AppColors.SECONDARY_COLOR
                                        : isDark
                                            ? AppColors.WHITE_COLOR
                                            : AppColors.BLACK_COLOR,
                                  ),
                                ),
                                selectedItems.contains(widget.items[index])
                                    ? SvgPicture.asset(AppAssets.CHECKED_ICON)
                                    : SvgPicture.asset(
                                        AppAssets.UNCHECKED_ICON),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
