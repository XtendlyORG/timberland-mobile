import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../core/themes/timberland_color.dart';

class TrailSearchBar extends StatelessWidget {
  const TrailSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchCtrl = TextEditingController();
    return Row(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              controller: searchCtrl,
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (val) {
                //TODO: FETCH FILTERED TRAILS HERE
                log("search $val");
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                fillColor: TimberlandColor.primary.withOpacity(.05),
                hintText: 'Trail Name',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                prefixIconColor: Theme.of(context).disabledColor,
                suffixIcon: GestureDetector(
                  onTap: () {
                    searchCtrl.clear();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Icon(Icons.circle),
                      Icon(
                        Icons.close,
                        size: 16,
                        color: TimberlandColor.text,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.filter_alt_outlined,
            color: Theme.of(context).disabledColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Icon(
            Icons.map_outlined,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ],
    );
  }
}
