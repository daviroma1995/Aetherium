import 'dart:developer';

import 'package:flutter/material.dart';
import "package:intl/intl.dart";

import '../utils/constants.dart';

class CalendarTile extends StatefulWidget {
  final VoidCallback? onDateSelected;
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

  CalendarTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyle,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.inMonth: true,
    this.events,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
  });

  @override
  State<CalendarTile> createState() => _CalendarTileState();
}

class _CalendarTileState extends State<CalendarTile> {
  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (widget.isDayOfWeek) {
      return InkWell(
        child: Container(
          alignment: Alignment.center,
          child: Text(
            widget.dayOfWeek!,
            style: widget.dayOfWeekStyle,
          ),
        ),
      );
    } else {
      int eventCount = 0;
      return InkWell(
        onTap: widget.onDateSelected,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 30,
            decoration: widget.isSelected
                ? const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.SECONDARY_COLOR,
                  )
                : const BoxDecoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateFormat("d").format(widget.date!),
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                widget.events != null && widget.events!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.events!.map((event) {
                          eventCount++;
                          if (eventCount > 3) return Container();
                          return Container(
                            margin: const EdgeInsets.only(
                                left: 2.0, right: 2.0, top: 2.0),
                            width: 7.0,
                            height: 7.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: event["isDone"]
                                  ? widget.isSelected
                                      ? Colors.black
                                      : Colors.green
                                  : widget.isSelected
                                      ? Colors.white38
                                      : Colors.black45,
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
      return new InkWell(
        child: widget.child,
        onTap: widget.onDateSelected,
      );
    }
    return new Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
