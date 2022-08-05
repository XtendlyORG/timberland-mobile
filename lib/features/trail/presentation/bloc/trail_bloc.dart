// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/core/utils/device_storage/create_file_from_asset.dart';
import 'package:timberland_biketrail/core/utils/device_storage/get_media_folder.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/params/search_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/repositories/trail_repository.dart';

part 'trail_event.dart';
part 'trail_state.dart';

class TrailBloc extends Bloc<TrailEvent, TrailState> {
  final TrailRepository repository;
  TrailBloc({
    required this.repository,
  }) : super(TrailInitial()) {
    on<TrailEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchTrailsEvent>((event, emit) async {
      emit(const LoadingTrails());
      final result = await repository.fetchTrails(event.fetchTrailsParams);

      result.fold(
        (failure) => emit(
          TrailError(message: failure.message),
        ),
        (trails) => emit(AllTrailsLoaded(trails: trails)),
      );
    });

    on<SearchTrailsEvent>((event, emit) async {
      emit(const SearchingTrails());
      final result = await repository.searchTrails(event.searchParams);

      result.fold(
        (failure) {
          emit(TrailError(message: failure.message));
        },
        (trails) {
          emit(SearchResultsLoaded(
            searchParams: event.searchParams,
            trails: trails,
          ));
        },
      );
    });

    on<SaveTrailMapEvent>((event, emit) async {
      emit(SavingTrailMap());
      final imgPath = await getPhotoDirectory('Timberland');
      try {
        await event.imageFile.copy("$imgPath/trail-map.png");
        emit(
          TrailMapSaved(
            path: imgPath,
          ),
        );
      } catch (e) {
        emit(
          const TrailMapSaveError(
            errorMessage: "Failed to save Trail Map",
          ),
        );
      }
    });
  }
}
