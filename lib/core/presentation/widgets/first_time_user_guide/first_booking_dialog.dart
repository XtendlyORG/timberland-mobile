// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../filled_text_button.dart';

class FirstBookingDialog extends StatelessWidget {
  const FirstBookingDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        height: 200,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/first-booking-dialog-bg.png'),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: FilledTextButton(
                onPressed: () {
                  Navigator.pop(context,true);
                },
                child: const Text(
                  "Book Now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                icon: Icon(
                  Icons.cancel_outlined,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
