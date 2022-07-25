// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import '../../../trail/domain/entities/trail.dart';

class TrailListDropDown extends StatefulWidget {
  const TrailListDropDown({
    Key? key,
    required this.onChanged,
    required this.selectedTrail,
    required this.trails,
  }) : super(key: key);

  final void Function(Trail? trail) onChanged;
  final Trail? selectedTrail;
  final List<Trail> trails;

  @override
  State<TrailListDropDown> createState() => _TrailListDropDownState();
}

class _TrailListDropDownState extends State<TrailListDropDown> {
  late Trail? _selectedTrail;
  late List<Trail> _trails;
  @override
  void initState() {
    super.initState();
    _selectedTrail = widget.selectedTrail;
    _trails = widget.trails;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Trail>(
      isExpanded: true,
      items: _trails
          .map(
            (category) => DropdownMenuItem<Trail>(
              value: category,
              child: SizedBox(
                width: 200,
                child: Text(
                  category.trailName,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: (selected) {
        _selectedTrail = selected ?? widget.selectedTrail;
        widget.onChanged(_selectedTrail);
      },
      value: _selectedTrail,
      borderRadius: BorderRadius.circular(10),
      hint: const Text('Trail'),
      decoration: const InputDecoration(),
      validator: (trail) {
        if (trail == null) {
          return 'Please select a trail';
        }
        return null;
      },
    );
  }
}
