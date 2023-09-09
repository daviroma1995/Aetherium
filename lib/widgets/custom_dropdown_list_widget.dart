// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

// ignore: must_be_immutable
class CustomDropDownListWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final List items;
  final List selectedItems;
  final List price;
  final List time;
  final Function serviceDetailController;
  final Function selectedServices;
  final int serviceIndex;
  bool isExpanded;

  CustomDropDownListWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.price,
    required this.time,
    required this.serviceDetailController,
    required this.selectedServices,
    required this.serviceIndex,
    required this.isExpanded,
  }) : super(key: key);

  @override
  State<CustomDropDownListWidget> createState() =>
      _CustomDropDownListWidgetState();
}

class _CustomDropDownListWidgetState extends State<CustomDropDownListWidget>
    with SingleTickerProviderStateMixin {
  _CustomDropDownListWidgetState();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
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
          child: AnimatedSize(
            duration: const Duration(milliseconds: 150),
            reverseDuration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: widget.isExpanded
                                      ? AppColors.WHITE_COLOR
                                      : AppColors.WHITE_COLOR,
                                  width: 2.0),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: CachedNetworkImage(
                                imageUrl: widget.imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.white, BlendMode.colorBurn)),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                     CircularProgressIndicator(
                                              color: isDark? AppColors.SECONDARY_COLOR : AppColors.GREY_COLOR,

                                    ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              widget.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: .75,
                                    color: !widget.isExpanded
                                        ? isDark
                                            ? AppColors.SECONDARY_LIGHT
                                            : AppColors.PRIMARY_COLOR
                                        : isDark
                                            ? AppColors.WHITE_COLOR
                                            : AppColors.BLACK_COLOR,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.isExpanded = !widget.isExpanded;
                        });
                      },
                      icon: !widget.isExpanded
                          ? SvgPicture.asset(
                              AppAssets.ARROW_DOWN,
                              colorFilter: ColorFilter.mode(
                                  isDark
                                      ? AppColors.WHITE_COLOR
                                      : AppColors.BLACK_COLOR,
                                  BlendMode.srcIn),
                            )
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
                              setState(
                                () {
                                  if (widget.selectedItems
                                      .contains(widget.items[index])) {
                                    widget.selectedItems
                                        .remove(widget.items[index]);
                                  } else {
                                    widget.selectedItems
                                        .add(widget.items[index]);
                                  }
                                  widget.selectedServices(
                                      widget.serviceIndex, index);
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                bottom: 13.0,
                              ),
                              decoration: BoxDecoration(
                                border: (index + 1) == widget.items.length
                                    ? const Border()
                                    : const Border(
                                        bottom: BorderSide(
                                            color: AppColors.BORDER_COLOR),
                                      ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            widget.serviceDetailController(
                                                widget.serviceIndex, index);
                                          },
                                          child: SvgPicture.asset(
                                            AppAssets.INFO_ICON,
                                            colorFilter: ColorFilter.mode(
                                                widget.selectedItems.contains(
                                                        widget.items[index])
                                                    ? isDark
                                                        ? AppColors
                                                            .SECONDARY_LIGHT
                                                        : AppColors
                                                            .SECONDARY_COLOR
                                                    : isDark
                                                        ? AppColors.WHITE_COLOR
                                                        : AppColors.BLACK_COLOR,
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.items[index],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                  color: widget.selectedItems
                                                          .contains(widget
                                                              .items[index])
                                                      ? isDark
                                                          ? AppColors
                                                              .SECONDARY_LIGHT
                                                          : AppColors
                                                              .SECONDARY_COLOR
                                                      : isDark
                                                          ? AppColors
                                                              .WHITE_COLOR
                                                          : AppColors
                                                              .BLACK_COLOR,
                                                ),
                                              ),
                                              Text(
                                                '${widget.time[index]} min - ${widget.price[index]} €',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                  color: widget.selectedItems
                                                          .contains(widget
                                                              .items[index])
                                                      ? isDark
                                                          ? AppColors
                                                              .SECONDARY_LIGHT
                                                          : AppColors
                                                              .SECONDARY_COLOR
                                                      : isDark
                                                          ? AppColors
                                                              .WHITE_COLOR
                                                          : AppColors
                                                              .BLACK_COLOR,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  widget.selectedItems
                                          .contains(widget.items[index])
                                      ? SvgPicture.asset(
                                          AppAssets.CHECKED_ICON,
                                          colorFilter: ColorFilter.mode(
                                              isDark
                                                  ? AppColors.SECONDARY_LIGHT
                                                  : AppColors.SECONDARY_COLOR,
                                              BlendMode.srcIn),
                                        )
                                      : SvgPicture.asset(
                                          AppAssets.UNCHECKED_ICON),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
