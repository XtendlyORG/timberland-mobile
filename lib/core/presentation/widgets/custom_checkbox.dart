// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final void Function(bool val) onChange;
  const CustomCheckbox({
    Key? key,
    required this.onChange,
    this.child,
  }) : super(key: key);
  final Widget? child;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool agreedToTermsOfUse;

  @override
  void initState() {
    super.initState();
    agreedToTermsOfUse = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: agreedToTermsOfUse,
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity,
          ),
          onChanged: (val) {
            setState(() {
              agreedToTermsOfUse = !agreedToTermsOfUse;
            });
            widget.onChange(agreedToTermsOfUse);
          },
        ),
        if (widget.child != null)
          GestureDetector(
            onTap: () {
              setState(() {
                agreedToTermsOfUse = !agreedToTermsOfUse;
              });
              widget.onChange(agreedToTermsOfUse);
            },
            child: widget.child!,
          ),
      ],
    );
  }
}
