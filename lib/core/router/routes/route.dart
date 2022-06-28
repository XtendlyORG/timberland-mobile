part of 'routes.dart';

class _Route {
  final String path;
  final String name;
  const _Route({
    required this.path,
    required this.name,
  });

  String asSubPath() => path.replaceAll('/', '');
  String addParams(String params) => '$path/:$params';
}
