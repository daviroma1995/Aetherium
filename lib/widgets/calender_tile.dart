import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import '../utils/constants.dart';

class CalendarTile extends StatefulWidget {
  // final VoidCallback? onDateSelected;
  final ValueChanged<DateTime>? onDateSelected;
  final DateTime? date;
  final String? dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool inMonth;
  final List? events;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? dateStyles;
  final Widget? child;
  final Color? selectedColor;
  final Color? todayColor;
  final Color? eventColor;
  final Color? eventDoneColor;
  final bool? isExpended;
  final bool? isSwapped;
  const CalendarTile({
    super.key,
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyle,
    this.isDayOfWeek = false,
    this.isSelected = false,
    this.inMonth = true,
    this.events,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
    this.isExpended = false,
    this.isSwapped = false,
  });

  @override
  State<CalendarTile> createState() => _CalendarTileState();
}

class _CalendarTileState extends State<CalendarTile> {
  Widget renderDateOrDayOfWeek(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (widget.isDayOfWeek) {
      var inkWell = Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(
                  color: widget.isSelected &&
                          !widget.isExpended! &&
                          !widget.isSwapped!
                      ? isDark
                          ? AppColors.SECONDARY_LIGHT
                          : AppColors.SECONDARY_COLOR
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0))),
              child: InkWell(
                onTap: () {
                  widget.onDateSelected?.call(widget.date!);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: widget.isSelected &&
                              !widget.isExpended! &&
                              !widget.isSwapped!
                          ? isDark
                              ? AppColors.SECONDARY_LIGHT
                              : AppColors.SECONDARY_COLOR
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      )),
                  child: Text(
                    widget.dayOfWeek!,
                    style: TextStyle(
                      color: widget.isSelected &&
                              !widget.isExpended! &&
                              !widget.isSwapped!
                          ? isDark
                              ? AppColors.BACKGROUND_DARK
                              : AppColors.WHITE_COLOR
                          : isDark
                              ? AppColors.WHITE_COLOR
                              : AppColors.BLACK_COLOR,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ).tr(),
                ),
              ),
            ),
          ),
        ],
      );
      return inkWell;
    } else {
      int eventCount = 0;
      return InkWell(
        onTap: () {
          widget.onDateSelected?.call(widget.date!);
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
          child: Container(
            padding: const EdgeInsets.only(bottom: 5.0),
            decoration: widget.isSelected && !widget.isSwapped!
                ? BoxDecoration(
                    color: isDark
                        ? AppColors.SECONDARY_LIGHT
                        : AppColors.SECONDARY_COLOR,
                    shape: widget.isExpended!
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                  )
                : const BoxDecoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat("d").format(widget.date!),
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: .75,
                          color: widget.isSelected && !widget.isSwapped!
                              ? isDark
                                  ? AppColors.BLACK_COLOR
                                  : AppColors.WHITE_COLOR
                              : isDark
                                  ? AppColors.GREY_COLOR
                                  : AppColors.BLACK_COLOR),
                    ),
                  ),
                ),
                // const SizedBox(height: 5.0),
                widget.events != null && widget.events!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.events!.map((event) {
                          eventCount++;
                          if (eventCount > 3) return Container();
                          return Container(
                            margin:
                                const EdgeInsets.only(left: 2.0, right: 2.0),
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: event["isDone"]
                                  ? widget.isSelected
                                      ? AppColors.PRIMARY_COLOR
                                      : AppColors.SECONDARY_LIGHT
                                  : widget.isSelected
                                      ? Colors.redAccent
                                      : Colors.red,
                            ),
                          );
                        }).toList())
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child != null) {
      return InkWell(
        child: widget.child,
        onTap: () => widget.onDateSelected?.call(widget.date!),
      );
    }
    return renderDateOrDayOfWeek(context);
  }
}
