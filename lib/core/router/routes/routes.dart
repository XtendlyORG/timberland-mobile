part 'route.dart';

abstract class Routes {
  // Authentiaction
  static const login = _Route(path: '/login', name: 'login');
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
      _Route(path: '/register/continuation', name: 'register-continuation');
  static const otpVerification = _Route(
    path: '/otp-verification',
    name: 'otp-verification',
  );

  //---MAIN PAGE
  static const home = _Route(path: '/', name: 'home');
  // trail-directory tab
  static const trails = _Route(path: '/trails', name: 'trails');
  static const specificTrail =
      _Route(path: 'home/trails/:id', name: 'specific-trail');
  static const trailMap = _Route(path: '/trail-map', name: 'trail-map');

  // profile - tab
  static const profile = _Route(path: '/profile', name: 'profile');
  static const updateProfile = _Route(
    path: '/update-profile',
    name: 'update-profile',
  );
  static const verifyUpdateOtp = _Route(
    path: '/update-profile/verification',
    name: 'update-profile-verification',
  );
  static const qr = _Route(path: '/my-qr', name: 'qr');
  static const bookingHistory =
      _Route(path: '/booking-history', name: 'booking-history');
  static const paymentHistory =
      _Route(path: '/payment-history', name: 'payment-history');

  static const booking = _Route(path: '/booking', name: 'booking');
  static const checkout =
      _Route(path: '/booking/checkout-page', name: 'checkout');

  static const rules = _Route(path: '/rules', name: 'rules');
  static const contacts = _Route(path: '/contacts', name: 'contacts');
  static const faqs = _Route(path: '/faqs', name: 'faqs');
  static const emergency = _Route(path: '/emergency', name: 'emergency');
}
