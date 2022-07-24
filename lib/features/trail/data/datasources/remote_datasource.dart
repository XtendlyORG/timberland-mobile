import '../../domain/entities/trail.dart';
import '../../domain/params/fetch_trails.dart';
import '../../domain/params/search_trails.dart';

abstract class RemoteDatasource {
  Future<List<Trail>> fetchTrails(FetchTrailsParams fetchTrailsParams);
  Future<List<Trail>> searchTrails(SearchTrailsParams searchParams);
}
