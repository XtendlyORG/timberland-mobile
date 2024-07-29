import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/faq_widget.dart';
import 'package:timberland_biketrail/features/constants/helpers.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/timberland_scaffold.dart';

class AnnouncementViewPage extends StatelessWidget {
  const AnnouncementViewPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);
  final String title;
  final String description;
  final String imagePath;

  @override
  Widget build(BuildContext context) {

    String newDescription = description
        .replaceAll('<h3>', '<p>')
        .replaceAll('</h3>', '</p>')
        .replaceAll('<h4>', '<p>')
        .replaceAll('</h4>', '</p>')
        .replaceAll('<h5>', '<p>')
        .replaceAll('</h5>', '</p>');

    Map<String, Style> htmlStyle = {
      "ql-align-right": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        textAlign: TextAlign.right
        //fontWeight: FontWeight.normal,
      ),
      "ql-align-center": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        textAlign: TextAlign.center
        //fontWeight: FontWeight.normal,
      ),
      "ql-align-left": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        textAlign: TextAlign.left
        //fontWeight: FontWeight.normal,
      ),
      "h1": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontWeight: FontWeight.normal,
      ),
      "h2": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontWeight: FontWeight.normal,
      ),
      "h3": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontWeight: FontWeight.normal,
      ),
      "h4": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontWeight: FontWeight.normal,
      ),
      "h5": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontWeight: FontWeight.normal,
      ),
      "h6": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontWeight: FontWeight.normal,
      ),
      "strong.ql-size-small": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.small,
      ),
      "strong.ql-size-large": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.xLarge,
      ),
      "strong.ql-size-huge": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.xxLarge,
      ),
      "strong.normal": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontSize: FontSize(16),
        //fontWeight: FontWeight.normal,
      ),
      "em.ql-size-small": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.small,
      ),
      "em.ql-size-large": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.xLarge,
      ),
      "em.ql-size-huge": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.xxLarge,
      ),
      "em.normal": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontSize: FontSize(16),
        //fontWeight: FontWeight.normal,
      ),
      "u.ql-size-small": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.small,
      ),
      "u.ql-size-large": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.xLarge,
      ),
      "u.ql-size-huge": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.xxLarge,
      ),
      "u.normal": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontSize: FontSize(16),
        //fontWeight: FontWeight.normal,
      ),
      "span.ql-size-small": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize.small,
      ),
      "span.ql-size-large": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize(28), // FontSize.xLarge,
      ),
      "span.ql-size-huge": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize(36), // FontSize.xxLarge,
      ),
      "span.normal": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        //fontSize: FontSize(16),
        //fontWeight: FontWeight.normal,
      ),
      "span.styled": Style(
        fontFamily: 'Poppins',
        fontSize: FontSize(16),
        //fontWeight: FontWeight.normal,
      ),
      "p.normal": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize(16),
        //fontWeight: FontWeight.normal,
      ),
      "p.p-styled": Style(
        //color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize(16),
        //fontWeight: FontWeight.normal,
      ),
      "li": Style(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: FontSize(16),
        //fontWeight: FontWeight.normal,
      ),
    };

    String formatHTMLString(String currentString) {
      String tempString = currentString;
      
      // String tempListTags = '<ol><li data-list="bullet">';
      // int count = 0;
      // for (int i = 0; i < tempString.length - tempListTags.length + 1; i++) {
      //   if (tempString.substring(i, i + tempListTags.length) == tempListTags) {
      //     count++;
      //   }
      // }

      // for (int i = 0; i < count; i++) {
      //   tempString = tempString
      //       .replaceFirst(
      //           '<ol><li data-list="bullet">', '<ul><li data-list="bullet">')
      //       .replaceFirst('</ol>', '</ul>');
      // }

      debugPrint("This is the html $description");

      return """${tempString.replaceAll('<p><span class', '<p class="p-classed"><span class').replaceAll('<p><span style', '<p class="p-styled"><span style').replaceAll('<p><span ', '<p class="normal"><span class="normal').replaceAll('<p>', '<p class="normal">').replaceAll('rgb(255, 193, 7)', 'rgb(226, 149, 55)')}""";
    }
            
    Widget html = Html(
      data: formatHTMLString(description),
      style: htmlStyle,
      onLinkTap: (url, data, elem) {
        //
      },
    );

      return DecoratedSafeArea(
        child: TimberlandScaffold(
          backButtonColor: Colors.white,
          extendBodyBehindAppbar: true,
          body: SizedBox.fromSize(
            size: MediaQuery.of(context).size,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    foregroundDecoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                            Colors.white,
                            Colors.transparent,
                                ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.center,
                            stops: [0, 0.10],
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.25),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(0),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.cover
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imagePath,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Container(
                          color: TimberlandColor.lightBlue,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          alignment: Alignment.center,
                          color: TimberlandColor.lightBlue,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline_rounded,
                                size: 48,
                              ),
                              Text(
                                "Failed to load Image",
                                style: Theme.of(context).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.all(30),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            title,
                            minFontSize: Theme.of(context).textTheme.titleLarge!.fontSize!,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          html,
                          // AutoSizeText(
                          //   removeHtmlTags(description),
                          //   minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
                          //   style: Theme.of(context).textTheme.titleSmall,
                          //   textAlign: TextAlign.left,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
