part 'route.dart';

abstract class Routes {
  static const onboarding = _Route(
    path: '/onboarding',
    name: 'onboarding',
  );

  // Authentiaction
  static const login = _Route(path: '/login', name: 'login');
  static const loginVerify = _Route(path: '/verify', name: 'login-verify');
  static const forgotPassword = _Route(
    path: '/forgot-password',
    name: 'forgot-password',
  );
  static const resetPassword = _Route(
    path: '/reset',
    name: 'reset-password',
  );
  static const register = _Route(path: '/register', name: 'register');
  static const registerContinuation =
      _Route(path: '/continuation', name: 'register-continuation');
  static const registerVerify =
      _Route(path: '/verify', name: 'register-verify');
  // static const otpVerification = _Route(
  //   path: '/otp-verification',
  //   name: 'otp-verification',
  // );

  //---MAIN PAGE
  static const home = _Route(path: '/', name: 'home');
  // trail-directory tab
  static const trails = _Route(path: '/trails', name: 'trails');
  static const specificTrail = _Route(path: ':id', name: 'specific-trail');
  static const trailMap = _Route(path: 'trail-map', name: 'trail-map');

  // profile - tab
  static const profile = _Route(path: '/profile', name: 'profile');
  static const updateProfile = _Route(
    path: '/update-profile',
    name: 'update-profile',
  );
  static const updateEmail = _Route(
    path: '/update-email',
    name: 'update-email',
  );
  static const verifyUpdateOtp = _Route(
    path: '/verification',
    name: 'update-email-verification',
  );
  static const updatePassword = _Route(
    path: '/update-password',
    name: 'update-password',
  );
  static const qr = _Route(path: '/my-qr', name: 'qr');
  static const bookingHistory = _Route(
    path: '/booking-history',
    name: 'booking-history',
  );
  static const bookingHistoryDetails = _Route(
    path: '/detail',
    name: 'booking-history-details',
  );

  static const paymentHistory = _Route(
    path: '/payment-history',
    name: 'payment-history',
  );

  static const booking = _Route(
    path: '/booking',
    name: 'booking',
  );
  static const bookingWaiver = _Route(
    path: '/booking/waiver',
    name: 'booking-waiver',
  );
  static const checkout = _Route(
    path: '/booking/checkout-page',
    name: 'checkout',
  );
  static const successfulBooking = _Route(
    path: '/success',
    name: 'successful-booking',
  );
  static const failedfulBooking = _Route(
    path: '/failed',
    name: 'failed-booking',
  );
  static const cancelledfulBooking = _Route(
    path: '/cancelled',
    name: 'cancelled-booking',
  );
  static const rules = _Route(path: '/rules', name: 'rules');
  static const contacts = _Route(path: '/contacts', name: 'contacts');
  static const faqs = _Route(path: '/faqs', name: 'faqs');
  static const emergency = _Route(path: '/emergency', name: 'emergency');
}
