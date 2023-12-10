// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class DropDownItemsWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final List<dynamic> options;
  final Function(String?) onTap;
  final String? selected;
  const DropDownItemsWidget({
    Key? key,
    this.height,
    this.width,
    required this.options,
    required this.onTap,
    this.selected,
  }) : super(key: key);

  @override
  State<DropDownItemsWidget> createState() => _DropDownItemsWidgetState();
}

class _DropDownItemsWidgetState extends State<DropDownItemsWidget> {
  String selectedValue = '';
  bool _isExpanded = false;
  String? _selected = tr('select');
  @override
  void initState() {
    super.initState();
    _selected = widget.selected ?? tr('select');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            height: widget.height ?? 50.0,
            width: widget.width ?? size.width,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.BORDER_COLOR),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 20.0),
                    Text(_selected ?? ''),
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.ARROW_DOWN),
                    const SizedBox(width: 20.0),
                  ],
                )
              ],
            ),
          ),
        ),
        _isExpanded
            ? const SizedBox(height: 10.0)
            : const SizedBox(height: 0.0),
        Container(
          width: widget.width ?? size.width,
          decoration: BoxDecoration(
            border: _isExpanded
                ? Border.all(color: AppColors.BORDER_COLOR)
                : Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _isExpanded
                  ? widget.options.map((e) {
                      return InkWell(
                        onTap: () {
                          widget.onTap(e);
                          setState(() {
                            _selected = e;
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(e),
                          ),
                        ),
                      );
                    }).toList()
                  : [],
            ),
          ),
        )
      ],
    );
  }
}
