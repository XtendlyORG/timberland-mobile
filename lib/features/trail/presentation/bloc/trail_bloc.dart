// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:timberland_biketrail/core/utils/internet_connection.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/params/search_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/repositories/trail_repository.dart';

part 'trail_event.dart';
part 'trail_state.dart';

class TrailBloc extends Bloc<TrailEvent, TrailState> {
  final TrailRepository repository;

  List<Trail> _trails = [];
  TrailBloc({
    required this.repository,
  }) : super(TrailInitial()) {
    on<FetchTrailsEvent>((event, emit) async {
      if (!InternetConnectivity().internetConnected) {
        return;
      }
      emit(const LoadingTrails());
      final result = await repository.fetchTrails(event.fetchTrailsParams);

      result.fold(
        (failure) => emit(
          TrailError(message: failure.message),
        ),
        (trails) {
          _trails = trails;
          emit(AllTrailsLoaded(trails: trails));
        },
      );
    });

    on<SearchTrailsEvent>((event, emit) async {
      if (!InternetConnectivity().internetConnected) {
        return;
      }
      emit(const SearchingTrails());
      // final result = await repository.searchTrails(event.searchParams);

      final trails = _trails
          .where(
            (element) =>
                event.searchParams.difficulties.isEmpty ||
                event.searchParams.difficulties.contains(element.difficulty),
          )
          .where((element) => element.trailName
              .toLowerCase()
              .contains(event.searchParams.name.toLowerCase()))
          .toList();
      emit(SearchResultsLoaded(
        searchParams: event.searchParams,
        trails: trails,
      ));

      // result.fold(
      //   (failure) {
      //     emit(TrailError(message: failure.message));
      //   },
      //   (trails) {
      //     emit(SearchResultsLoaded(
      //       searchParams: event.searchParams,
      //       trails: trails,
      //     ));
      //   },
      // );
    });

    on<SaveTrailMapEvent>((event, emit) async {
      if (!InternetConnectivity().internetConnected) {
        return;
      }
      final initState = state;
      emit(SavingTrailMap());
      // final imgPath = await getPhotoDirectory('Timberland');
      try {
        // await event.imageFile.copy("$imgPath/trail-map.png");
        final bool? didSave = await GallerySaver.saveImage(
          event.imageFile.path,
          albumName: "Timberland",
          toDcim: true,
        );
        if (didSave != null && didSave) {
          emit(
            const TrailMapSaved(
              path: "Gallery",
            ),
          );
        } else {
          throw Exception("Failed to save image");
        }
      } catch (e) {
        emit(
          const TrailMapSaveError(
            errorMessage: "Failed to save Trail Map",
          ),
        );
      }
      emit(initState);
    });
  }
}
