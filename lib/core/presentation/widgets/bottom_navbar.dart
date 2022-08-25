// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/emergency/presentation/widgets/emergency_dialog.dart';

class BottomNavBar extends StatefulWidget {
  final int index;
  final List<BottomNavBarConfigs> configs;
  final void Function(int index) onTap;

  const BottomNavBar({
    Key? key,
    required this.index,
    required this.configs,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return _CustomNavBar(
      items: widget.configs
          .map(
            (navBarConfig) => BottomNavigationBarItem(
              icon: navBarConfig.icon,
              label: navBarConfig.label,
              tooltip: navBarConfig.label,
            ),
          )
          .toList(),
      index: widget.index,
      onTap: (index) {
        if (widget.configs[index].routeName != Routes.emergency.name) {
          widget.onTap(index);
        } else {
          if (widget.index != index) {
            showDialog(
              context: context,
              builder: (ctx) {
                return const EmergencyDialog();
              },  
            );
          }
        }
      },
    );
  }
}

class _CustomNavBar extends StatefulWidget {
  const _CustomNavBar({
    Key? key,
    required this.items,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final List<BottomNavigationBarItem> items;
  final int index;

  final void Function(int index) onTap;
  @override
  State<_CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<_CustomNavBar> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    if (selectedIndex != widget.index) {
      selectedIndex = widget.index;
    }
    return Container(
      height: kBottomNavigationBarHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.items.length,
              (index) => Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    widget.onTap(index);
                  },
                  child: Tooltip(
                    message: widget.items[index].tooltip,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 48,
                            child: index != widget.items.length ~/ 2
                                ? widget.items[index].icon
                                : null,
                          ),
                        ),
                        if (widget.items[index].tooltip != null) ...[
                          Expanded(
                            child: Text(
                              widget.items[index].tooltip!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontSize:
                                        index != selectedIndex ? 12 : null,
                                    fontWeight: index == selectedIndex
                                        ? FontWeight.w500
                                        : null,
                                    color: index != selectedIndex
                                        ? Theme.of(context)
                                            .backgroundColor
                                            .withOpacity(.5)
                                        : Theme.of(context).backgroundColor,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -55),
            child: Container(
              height: 55,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).backgroundColor,
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 5),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  widget.onTap(2);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: navbarConfigs[2].icon,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBarConfigs {
  final Widget icon;
  final String label;
  final String routeName;
  final Widget Function(BuildContext context)? pageBuider;
  const BottomNavBarConfigs({
    required this.icon,
    required this.label,
    required this.routeName,
    this.pageBuider,
  });
}
