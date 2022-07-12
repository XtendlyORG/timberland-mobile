part 'route.dart';

abstract class Routes {
  // Authentiaction
  static const login = _Route(path: '/login', name: 'login');
  static const forgotPassword =
      _Route(path: '/forgot-password', name: 'forgot-password');
  static const register = _Route(path: '/register', name: 'register');
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

  // profile - tab
  static const profile = _Route(path: '/profile', name: 'profile');
  static const booking = _Route(path: '/booking', name: 'booking');
  static const qr = _Route(path: '/qr', name: 'qr');
  static const rules = _Route(path: '/rules', name: 'rules');
  static const contacts = _Route(path: '/contacts', name: 'contacts');
  static const faqs = _Route(path: '/faqs', name: 'faqs');
  static const emergency = _Route(path: '/emergency', name: 'emergency');
}
