import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final void Function(bool val) onChange;
  const CustomCheckbox({
    Key? key,
    required this.onChange,
  }) : super(key: key);

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
    return Checkbox(
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
    );
  }
}
