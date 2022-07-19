import 'package:flutter/material.dart';

class TermsOfUse extends StatefulWidget {
  final void Function(bool val) onChange;
  const TermsOfUse({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
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
      onChanged: (val) {
        setState(() {
          agreedToTermsOfUse = !agreedToTermsOfUse;
        });
        widget.onChange(agreedToTermsOfUse);
      },
    );
  }
}
