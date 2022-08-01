import 'package:flutter/material.dart';

import '../presentation/widgets/bottom_navbar.dart';
import '../router/router.dart';

final List<BottomNavBarConfigs> navbarConfigs = [
  BottomNavBarConfigs(
    icon: const Icon(Icons.map_outlined),
    label: 'Trail',
    routeName: Routes.trails.name,
  ),
  BottomNavBarConfigs(
    icon: const Image(
      image: AssetImage('assets/icons/rules-icon.png'),
      height: 24,
      width: 24,
    ),
    label: 'Rules',
    routeName: Routes.rules.name,
  ),
  BottomNavBarConfigs(
    icon: const Image(
      image: AssetImage('assets/icons/emergency-icon.png'),
      height: 24,
      width: 24,
      color: Color(0xffF60505),
    ),
    label: 'Emergency',
    routeName: Routes.emergency.name,
  ),
  BottomNavBarConfigs(
    icon: const Image(
      image: AssetImage('assets/icons/profile-icon.png'),
      height: 24,
      width: 24,
    ),
    label: 'Profile',
    routeName: Routes.profile.name,
  ),
  BottomNavBarConfigs(
    icon: const Image(
      image: AssetImage('assets/icons/booking-icon.png'),
      height: 24,
      width: 24,
    ),
    label: 'Booking',
    routeName: Routes.booking.name,
  ),
];
