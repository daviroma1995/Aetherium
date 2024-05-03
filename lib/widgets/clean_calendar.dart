// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:atherium_saloon_app/widgets/simple_gesture_detector.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../utils/constants.dart';
import '../utils/date_utils.dart';
import 'calender_tile.dart';

// ignore: prefer_generic_function_type_aliases
typedef DayBuilder(BuildContext context, DateTime day);

class Range {
  final DateTime from;
  final DateTime? to;

  Range(this.from, this.to);
}

// ignore: must_be_immutable
class Calendar extends StatefulWidget {
  final bool? isLoading;
  final ValueChanged<DateTime>? onDateSelected;
  final ValueChanged<DateTime>? onMonthChanged;
  final ValueChanged? onRangeSelected;
  final bool isExpandable;
  final DayBuilder? dayBuilder;
  final bool hideArrows;
  final bool hideTodayIcon;
  final Map<DateTime, List>? events;
  final Color? selectedColor;
  final Color? todayColor;
  final Color? eventColor;
  final Color? eventDoneColor;
  final DateTime? initialDate;
  bool isExpanded;
  final List<String> weekDays;
  final String locale;
  final bool startOnMonday;
  final bool hideBottomBar;
  final TextStyle? dayOfWeekStyle;
  final TextStyle? bottomBarTextStyle;
  final Color? bottomBarArrowColor;
  final Color? bottomBarColor;
  bool? reload;
  Calendar({
    super.key,
    this.onMonthChanged,
    this.isLoading,
    this.onDateSelected,
    this.onRangeSelected,
    this.hideBottomBar = false,
    this.isExpandable = false,
    this.events,
    this.dayBuilder,
    this.hideTodayIcon = false,
    this.hideArrows = false,
    this.selectedColor,
    this.todayColor,
    this.eventColor,
    this.eventDoneColor,
    this.initialDate,
    this.isExpanded = false,
    this.weekDays = const ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
    this.locale = "en_US",
    this.startOnMonday = false,
    this.dayOfWeekStyle,
    this.bottomBarTextStyle,
    this.bottomBarArrowColor,
    this.bottomBarColor,
    this.reload,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final calendarUtils = Utils();
  late List<DateTime> selectedMonthsDays;
  late Iterable<DateTime> selectedWeekDays;
  DateTime _selectedDate = DateTime.now();
  String? currentMonth;
  bool isExpanded = false;
  String displayMonth = "";
  bool isSwapped = false;
  DateTime get selectedDate => _selectedDate;

  @override
  void initState() {
    if (mounted) {
      _selectedDate = widget.initialDate ?? DateTime.now();
      isExpanded = widget.isExpanded;
      isSwapped = false;
      selectedMonthsDays = _daysInMonth(_selectedDate);
      selectedWeekDays = Utils.daysInRange(
              _firstDayOfWeek(_selectedDate), _lastDayOfWeek(_selectedDate))
          .toList();
      initializeDateFormatting(widget.locale, null).then((_) => setState(() {
            var monthFormat =
                DateFormat("MMMM", widget.locale).format(_selectedDate);
            displayMonth =
                "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
          }));
      super.initState();
    }
  }

  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    if (mounted) {
      _selectedDate = widget.initialDate ?? DateTime.now();
      isSwapped = false;
      selectedMonthsDays = _daysInMonth(_selectedDate);
      selectedWeekDays = Utils.daysInRange(
              _firstDayOfWeek(_selectedDate), _lastDayOfWeek(_selectedDate))
          .toList();

      initializeDateFormatting(widget.locale, null).then((_) {
        if (mounted) {
          setState(() {
            var monthFormat =
                DateFormat("MMMM", widget.locale).format(_selectedDate);
            displayMonth =
                "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
          });
        }
      });
      super.didUpdateWidget(oldWidget);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget get nameAndIconRow {
    var todayIcon;
    var leftArrow;
    var rightArrow;

    if (!widget.hideArrows) {
      leftArrow = InkWell(
        // onTap: isExpanded ? previousMonth : previousWeek,
        onTap: previousMonth,
        child: const Icon(Icons.chevron_left),
      );
      rightArrow = InkWell(
        // onTap: isExpanded ? nextMonth : nextWeek,
        onTap: nextMonth,
        child: const Icon(Icons.chevron_right),
      );
    } else {
      leftArrow = Container();
      rightArrow = Container();
    }

    if (!widget.hideTodayIcon) {
      todayIcon = InkWell(
        onTap: resetToToday,
        child: const Text('Today'),
      );
    } else {
      todayIcon = Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            leftArrow ?? Container(),
            leftArrow == false ? const SizedBox(width: 10.0) : const SizedBox(),
            Column(
              children: [
                todayIcon ?? const SizedBox(),
                Text(tr(displayMonth.toLowerCase()),
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w400,
                        )).tr(),
              ],
            ),
            rightArrow ?? Container(),
          ],
        ),
        IconButton(
          onPressed: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          icon: SvgPicture.asset(
            AppAssets.CALANDER_ICON,
            colorFilter: ColorFilter.mode(
                Theme.of(context).brightness == Brightness.dark
                    ? AppColors.WHITE_COLOR
                    : AppColors.BLACK_COLOR,
                BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Widget get calendarGridView {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: SimpleGestureDetector(
        onSwipeUp: _onSwipeUp,
        onSwipeDown: _onSwipeDown,
        onSwipeLeft: _onSwipeLeft,
        onSwipeRight: _onSwipeRight,
        swipeConfig: const SimpleSwipeConfig(
          verticalThreshold: 10.0,
          horizontalThreshold: 40.0,
          swipeDetectionMoment: SwipeDetectionMoment.onUpdate,
        ),
        child: Column(
          children: <Widget>[
            GridView.count(
              childAspectRatio: 1,
              primary: false,
              shrinkWrap: true,
              crossAxisCount: 7,
              addSemanticIndexes: true,
              padding: const EdgeInsets.only(),
              children: calendarBuilder(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
        isExpanded ? selectedMonthsDays : selectedWeekDays as List<DateTime>;
    for (var day in widget.weekDays) {
      var fullday = '';
      if (day == 'Sun') {
        fullday = 'Suday';
      }
      if (day == 'Mon') {
        fullday = 'Monday';
      }
      if (day == 'Tue') {
        fullday = 'Tuesday';
      }
      if (day == 'Wed') {
        fullday = 'Wednesday';
      }
      if (day == 'Thu') {
        fullday = 'Thursday';
      }
      if (day == 'Fri') {
        fullday = 'Friday';
      }
      if (day == 'Sat') {
        fullday = 'Saturday';
      }
      dayWidgets.add(
        CalendarTile(
          onDateSelected: (date) {
            if (widget.isLoading ?? false) {
              return;
            }
            handleSelectedDateAndUserCallback(date);
          },
          selectedColor: widget.selectedColor,
          todayColor: widget.todayColor,
          eventColor: widget.eventColor,
          eventDoneColor: widget.eventDoneColor,
          events: widget.events![day.toLowerCase()],
          isDayOfWeek: true,
          date: calendarDays.firstWhereOrNull((e) =>
              DateFormat("EEE").format(e).toLowerCase() == day.toLowerCase()),
          dayOfWeek: tr(day.toLowerCase()),
          dayOfWeekStyle: widget.dayOfWeekStyle ??
              TextStyle(
                color: widget.selectedColor,
                fontWeight: FontWeight.w500,
                fontSize: 11,
              ),
          isSelected: DateFormat.EEEE().format(_selectedDate) == fullday,
          isExpended: isExpanded,
          isSwapped: isSwapped,
        ),
      );
    }

    bool monthStarted = false;
    bool monthEnded = false;

    for (var day in calendarDays) {
      if (day.hour > 0) {
        day = day.toLocal();
        day = day.subtract(Duration(hours: day.hour));
      }

      if (monthStarted && day.day == 01) {
        monthEnded = true;
      }

      if (Utils.isFirstDayOfMonth(day)) {
        monthStarted = true;
      }

      if (widget.dayBuilder != null) {
        dayWidgets.add(
          CalendarTile(
            selectedColor: widget.selectedColor,
            todayColor: widget.todayColor,
            eventColor: widget.eventColor,
            eventDoneColor: widget.eventDoneColor,
            events: widget.events![day],
            child: widget.dayBuilder!(context, day),
            date: day,
            onDateSelected: (date) {
              if (widget.isLoading ?? false) {
                return;
              }
              handleSelectedDateAndUserCallback(date);
            },
            isExpended: isExpanded,
            isSwapped: isSwapped,
          ),
        );
      } else {
        dayWidgets.add(
          CalendarTile(
              isSwapped: isSwapped,
              isExpended: isExpanded,
              selectedColor: widget.selectedColor,
              todayColor: widget.todayColor,
              eventColor: widget.eventColor,
              eventDoneColor: widget.eventDoneColor,
              events: widget.events![day],
              onDateSelected: (date) {
                if (widget.isLoading ?? false) {
                  return;
                }
                handleSelectedDateAndUserCallback(date);
              },
              date: day,
              dateStyles: configureDateStyle(monthStarted, monthEnded),
              isSelected: Utils.isSameDay(selectedDate, day),
              inMonth: day.month == selectedDate.month),
        );
      }
    }
    return dayWidgets;
  }

  TextStyle? configureDateStyle(monthStarted, monthEnded) {
    TextStyle? dateStyles;
    final TextStyle? body1Style = Theme.of(context).textTheme.bodyText2;

    if (isExpanded) {
      final TextStyle body1StyleDisabled = body1Style!.copyWith(
          color: Color.fromARGB(
        100,
        body1Style.color!.red,
        body1Style.color!.green,
        body1Style.color!.blue,
      ));

      dateStyles =
          monthStarted && !monthEnded ? body1Style : body1StyleDisabled;
    } else {
      dateStyles = body1Style;
    }
    return dateStyles;
  }

  Widget get expansionButtonRow {
    if (widget.isExpandable) {
      return GestureDetector(
        onTap: toggleExpanded,
        child: Container(
          color:
              widget.bottomBarColor ?? const Color.fromRGBO(200, 200, 200, 0.2),
          height: 10,
          margin: const EdgeInsets.only(top: 8.0),
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(width: 40.0),
              Text(
                Utils.fullDayFormat(selectedDate),
                style:
                    widget.bottomBarTextStyle ?? const TextStyle(fontSize: 13),
              ),
              IconButton(
                onPressed: toggleExpanded,
                iconSize: 25.0,
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                icon: isExpanded
                    ? Icon(
                        Icons.arrow_drop_up,
                        color: widget.bottomBarArrowColor ?? Colors.black,
                      )
                    : Icon(
                        Icons.arrow_drop_down,
                        color: widget.bottomBarArrowColor ?? Colors.black,
                      ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 400),
      child: Column(
        key: UniqueKey(),
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          nameAndIconRow,
          ExpansionCrossFade(
            collapsed: calendarGridView,
            expanded: calendarGridView,
            isExpanded: isExpanded,
          ),
          expansionButtonRow
        ],
      ),
    );
  }

  void resetToToday() {
    _selectedDate = DateTime.now();
    var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);

    setState(() {
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat = DateFormat("MMMM", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });

    _launchDateSelectionCallback(_selectedDate);
  }

  void nextMonth() {
    setState(() {
      _selectedDate = Utils.nextMonth(_selectedDate);
      isSwapped = true;
      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat = DateFormat("MMMM", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousMonth() {
    setState(() {
      _selectedDate = Utils.previousMonth(_selectedDate);
      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
      isSwapped = true;
      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = _daysInMonth(_selectedDate);
      var monthFormat = DateFormat("MMMM", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void nextWeek() {
    setState(() {
      isSwapped = true;
      _selectedDate = Utils.nextWeek(_selectedDate);
      var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      var monthFormat = DateFormat("MMMM", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousWeek() {
    var firstDayOfCurrentWeek = _firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = _lastDayOfWeek(_selectedDate);
    setState(() {
      isSwapped = true;
      _selectedDate = Utils.previousWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      var monthFormat = DateFormat("MMMM", widget.locale).format(_selectedDate);
      displayMonth =
          "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void updateSelectedRange(DateTime start, DateTime? end) {
    Range rangeSelected = Range(start, end);
    if (widget.onRangeSelected != null) {
      widget.onRangeSelected!(rangeSelected);
    }
  }

  void _onSwipeUp() {
    if (isExpanded) toggleExpanded();
  }

  void _onSwipeDown() {
    if (!isExpanded) toggleExpanded();
  }

  void _onSwipeRight() {
    if (isExpanded) {
      previousMonth();
      setState(() {
        isSwapped = true;
      });
    } else {
      previousWeek();
      setState(() {
        isSwapped = true;
      });
    }
  }

  void _onSwipeLeft() {
    if (isExpanded) {
      setState(() {
        nextMonth();
      });
    } else {
      setState(() {
        nextWeek();
      });
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = _firstDayOfWeek(day);
    var lastDayOfCurrentWeek = _lastDayOfWeek(day);

    setState(() {
      isSwapped = false;
      _selectedDate = day;
      selectedWeekDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = _daysInMonth(day);
    });
    if (_selectedDate.month > day.month) {
      previousMonth();
    }
    if (_selectedDate.month < day.month) {
      nextMonth();
    }
    _launchDateSelectionCallback(day);
  }

  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      if (widget.isLoading ?? false) {
        return;
      }
      widget.onDateSelected!(day);
    }
    if (widget.onMonthChanged != null) {
      widget.onMonthChanged!(day);
    }
  }

  _firstDayOfWeek(DateTime date) {
    var day = DateTime.utc(date.year, date.month, date.day, 12);
    return day
        .subtract(Duration(days: day.weekday - (widget.startOnMonday ? 1 : 0)));
  }

  _lastDayOfWeek(DateTime date) {
    return _firstDayOfWeek(date).add(const Duration(days: 7));
  }

  List<DateTime> _daysInMonth(DateTime month) {
    var first = Utils.firstDayOfMonth(month);
    var daysBefore = first.weekday;
    var firstToDisplay = first
        .subtract(Duration(days: daysBefore - 1))
        .subtract(Duration(days: !widget.startOnMonday ? 1 : 0));
    var last = Utils.lastDayOfMonth(month);

    var daysAfter = 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    if (daysAfter == 0) {
      daysAfter = 7;
    }

    var lastToDisplay = last.add(Duration(days: daysAfter));
    return Utils.daysInRange(firstToDisplay, lastToDisplay).toList();
  }
}

class ExpansionCrossFade extends StatelessWidget {
  final Widget? collapsed;
  final Widget? expanded;
  final bool? isExpanded;

  const ExpansionCrossFade(
      {super.key, this.collapsed, this.expanded, this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: AnimatedCrossFade(
        firstChild: collapsed!,
        secondChild: expanded!,
        firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.decelerate,
        crossFadeState:
            isExpanded! ? CrossFadeState.showSecond : CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
