// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final void Function(bool val) onChange;
  final bool initValue;
  const CustomCheckbox({
    Key? key,
    required this.onChange,
    this.initValue = false,
    this.child,
  }) : super(key: key);
  final Widget? child;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (val) {
            setState(() {
              value = !value;
            });
            widget.onChange(value);
          },
        ),
        if (widget.child != null) widget.child!,
        // GestureDetector(
        //   onTap: () {
        //     setState(() {
        //       value = !value;
        //     });
        //     widget.onChange(value);
        //   },
        //   child:
        // ),
      ],
    );
  }
}
