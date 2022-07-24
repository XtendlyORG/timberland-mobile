// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';

class FirstTimeUserPage extends StatelessWidget {
  const FirstTimeUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
        ),
        extendBodyBehindAppBar: true,
        body: TimberlandContainer(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: kHorizontalPadding,
                    ),
                    Text.rich(
                      const TextSpan(
                        children: [
                          TextSpan(
                              text: 'New to Timberland Bike Trail App? ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          TextSpan(
                            text:
                                "Here's a short video on how to navigate the app.",
                          )
                        ],
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: kHorizontalPadding,
                    ),
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: 200,
                        maxWidth: 400,
                      ),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [BoxShadow(blurRadius: 10)],
                      ),
                      child: const UserGuideVideo(),
                    ),
                    const SizedBox(
                      height: kHorizontalPadding,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
