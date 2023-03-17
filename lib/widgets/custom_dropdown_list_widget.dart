// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/constants.dart';

class CustomDropDownListWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final List items;
  const CustomDropDownListWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  State<CustomDropDownListWidget> createState() =>
      _CustomDropDownListWidgetState();
}

class _CustomDropDownListWidgetState extends State<CustomDropDownListWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isSelected = false;
  List selectedItems = [];

  _CustomDropDownListWidgetState();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.BORDER_COLOR),
        borderRadius: BorderRadius.circular(8.0),
        color: !_isExpanded
            ? AppColors.SECONDARY_COLOR
            : AppColors.BACKGROUND_COLOR,
      ),
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
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: .75,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  color: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: !_isExpanded
                      ? SvgPicture.asset(AppAssets.ARROW_DOWN)
                      : SvgPicture.asset(AppAssets.ARROW_UP),
                ),
              ],
            ),
            _isExpanded ? const SizedBox(height: 10.0) : const SizedBox(),
            _isExpanded
                ? ListView.builder(
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
                                      ? AppColors.SECONDARY_LIGHT
                                      : AppColors.BLACK_COLOR,
                                ),
                              ),
                              selectedItems.contains(widget.items[index])
                                  ? SvgPicture.asset(AppAssets.CHECKED_ICON)
                                  : SvgPicture.asset(AppAssets.UNCHECKED_ICON),
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
    );
  }
}
