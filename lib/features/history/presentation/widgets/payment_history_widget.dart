import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class PaymentHistoryWidget extends StatelessWidget {
  const PaymentHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(kVerticalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            'http://assets.stickpng.com/images/627bba8d2bc3a3762a1d0ba1.png',
            height: 32,
            width: 32,
          ),
          const SizedBox(
            width: kVerticalPadding,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'BDO Unibank, Inc.\n',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const TextSpan(
                        text: 'John Doe\n',
                      ),
                      const TextSpan(
                        text: '****2945',
                      ),
                    ],
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
