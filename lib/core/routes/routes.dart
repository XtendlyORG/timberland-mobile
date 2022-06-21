class Routes {
  static const home = Route(path: '/', name: 'home');
  static const login = Route(path: '/login', name: 'login');
  static const register = Route(path: '/register', name: 'register');
}

class Route {
  final String path;
  final String name;
  const Route({
    required this.path,
    required this.name,
  });

  String asSubPath() => path.replaceAll('/', '');
  String addParams(String params) => '$path/:$params';
}
