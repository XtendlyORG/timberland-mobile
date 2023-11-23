enum Routes {
  onboarding(
    path: '/onboarding',
    name: 'onboarding',
  ),

  announcements(name: 'announcements', path: '/announcements'),
  announcements2(name: 'announcements2', path: '/announcements2'),

  checkoutNotification(
    name: 'checkout-notification',
    path: '/checkout',
  ),

  // Authentiaction
  login(path: '/login', name: 'login'),
  loginVerify(path: '/verify', name: 'login-verify'),
  forgotPassword(
    path: '/forgot-password',
    name: 'forgot-password',
  ),
  forgotPasswordVerify(
    path: '/verify',
    name: 'forgot-password-verify',
  ),

  resetPassword(
    path: '/reset',
    name: 'reset-password',
  ),
  register(path: '/register', name: 'register'),
  registerContinuation(path: '/continuation', name: 'register-continuation'),
  registerVerify(path: '/verify', name: 'register-verify'),

  //---MAIN PAGE
  home(path: '/', name: 'home'),
  // trail-directory tab
  trails(path: '/trails', name: 'trails'),
  specificTrail(path: ':id', name: 'specific-trail'),
  trailMap(path: 'trail-map', name: 'trail-map'),

  // profile - tab
  profile(path: '/profile', name: 'profile'),
  updateProfile(
    path: '/update-profile',
    name: 'update-profile',
  ),
  updateEmail(
    path: '/update-email',
    name: 'update-email',
  ),
  verifyUpdateOtp(
    path: '/verification',
    name: 'update-email-verification',
  ),
  updatePassword(
    path: '/update-password',
    name: 'update-password',
  ),
  qr(path: '/my-qr', name: 'qr'),
  bookingHistory(
    path: '/booking-history',
    name: 'booking-history',
  ),
  bookingHistoryDetails(
    path: '/detail',
    name: 'booking-history-details',
  ),

  paymentHistory(
    path: '/payment-history',
    name: 'payment-history',
  ),

  booking(
    path: '/booking',
    name: 'booking',
  ),
  bookingWaiver(
    path: '/booking/waiver',
    name: 'booking-waiver',
  ),
  checkout(
    path: '/booking/checkout-page',
    name: 'checkout',
  ),
  successfulBooking(
    path: '/success',
    name: 'successful-booking',
  ),
  failedfulBooking(
    path: '/failed',
    name: 'failed-booking',
  ),
  cancelledfulBooking(
    path: '/cancelled',
    name: 'cancelled-booking',
  ),
  rules(path: '/rules', name: 'rules'),
  contacts(path: '/contacts', name: 'contacts'),
  contactSuccess(
    path: '/inquiry-sent',
    name: 'inquirey-sent',
  ),
  faqs(path: '/faqs', name: 'faqs'),
  emergency(path: '/emergency', name: 'emergency');

  final String path;
  final String name;
  const Routes({
    required this.path,
    required this.name,
  });

  String asSubPath() => path.replaceAll('/', '');
  String addParams(String params) => '$path/:$params';
}
