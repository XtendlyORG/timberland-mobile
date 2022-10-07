// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/faq.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/faq_diamond_icon.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/faq_icon_wrapper.dart';

const faqs = [
  FAQ(
    question: "WHAT IS TMBP?",
    answer:
        "Timberland Mountain Bike Park is a purpose-built network of trails located in the mountain township of Timberland Heights, developed by Filinvest. The trails are specific to mountain bikes and are graded according to difficulty.",
  ),
  FAQ(
    question: "WHAT ARE THE DIFFICULTY RATINGS?",
    subCategory: [
      FAQ(
        question: "GRADE 1 (EASIEST)",
        icon: FaqIconWrapper(
          shape: BoxShape.circle,
          icon: Icon(
            Icons.circle,
            color: Colors.white,
          ),
        ),
        answer:
            "Also identified by a white circle\n\nSuitable for novice riders, families and others seeking an easy, relaxing cycling experience. Trails are smooth, with only gentle climbs and generally wide enough for side-by-side riding.",
      ),
      FAQ(
        question: "GRADE 2 (EASY)",
        icon: FaqIconWrapper(
          shape: BoxShape.circle,
          icon: Icon(
            Icons.circle,
            color: Colors.green,
          ),
        ),
        answer:
            "Also identified by a green circle\n\nSuitable for most riders including beginners, occasional cyclists and families with limited cycling experience. A multi-geared bike with medium to wide knobbly tyres is recommended.\n\nTrails are usually wide and smooth with some gentle climbs. These trails are predictable, i.e. have no surprises.",
      ),
      FAQ(
        question: "GRADE 3 (INTERMEDIATE)",
        icon: FaqIconWrapper(
          icon: Icon(
            Icons.square,
            color: Colors.blue,
          ),
        ),
        answer:
            "Also identified with a light blue square\n\nSuitable for regular experienced cyclists with a good level of fitness and over 12 years old; children should be accompanied by an adult.\n\nTrails can be narrow and may include hills, rollable drop-offs and small water crossings. Trail surfaces are mainly firm but may include muddy or loose sections, and obstacles such as rocks or tree roots.",
      ),
      FAQ(
        question: "GRADE 4 (ADVANCED)",
        icon: FaqDiamondIcon(
          count: 1,
        ),
        answer:
            "Also identified with a dark blue square\n\nSuitable for fit, experienced cyclists with excellent off-road skills and a high level of fitness. Not suitable for children.\n\nA quality, well-maintained, full-suspension mountain bike is recommended. Trails are likely to be challenging with steep climbs and descents, as well as drops.",
      ),
      FAQ(
        question: "GRADE 5 (EXPERT)",
        icon: FaqDiamondIcon(count: 2),
        answer:
            "Also identified with a black diamond\n\nSuitable for fit, experienced cyclists with excellent off-road skills and a high level of fitness. Not suitable for children.\n\nA well-maintained, full-suspension mountain bike is recommended, features will be more technical and difficult than a Grade 4 trail. A full-face helmet and additional body protection is recommended.",
      ),
    ],
  ),
  FAQ(
    question: "HOW DO I GET TO RIDE TMBP?",
    answer:
        "Using this app you can book an available date and also pay for your day pass. The day pass lets you ride as much as you want on your selected date.",
  ),
  FAQ(
    question: "CAN I RIDE TMBP IN THE RAIN?",
    answer:
        "Due to potential trail damage as well as risks to riders, management reserves the right to restrict access to the trails during inclement weather.",
  ),
  FAQ(
    question: "CAN I CANCEL MY BOOKING?",
    answer:
        "While it makes us sad, you may cancel your ride booking up to 48H before your scheduled ride. Cancelled bookings will be credited to your account for a future ride, redeemable within the next 4 months. We miss you that much!",
  ),
  FAQ(
    question: "WHAT IF I DON'T SHOW UP DURING MY SCHEDULED RIDE?",
    answer:
        "No-shows are considered as canceled rides, but your account will be credited with a future ride, which you can redeem/rebook within the next 4 months. We hope to see you soon!",
  ),
  FAQ(
    question: "WHAT IF I SHOW UP WITHOUT A BOOKING?",
    answer:
        "Since slots are limited, all bookings will have to be done using the app. We hope you understand.",
  ),
  FAQ(
    question:
        "WHAT IF I DON’T HAVE A SMARTPHONE? HOW CAN I BOOK WITHOUT THE APP?",
    answer: "Please contact TMBP management via XXXXXXXXX.",
  ),
];
