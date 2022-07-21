import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/params/search_trails.dart';

abstract class RemoteDatasource {
  Future<List<Trail>> fetchTrails(FetchTrailsParams fetchTrailsParams);
  Future<List<Trail>> searchTrails(SearchTrailsParams searchParams);
}
