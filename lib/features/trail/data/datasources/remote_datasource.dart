import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';

abstract class RemoteDatasource {
  Future<List<Trail>> fetchTrails(FetchTrailsParams fetchTrailsParams);
}
