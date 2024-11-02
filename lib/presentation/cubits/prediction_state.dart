import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:voiceline/domain/entities/prediction_entity.dart';

part 'prediction_state.freezed.dart';

@freezed
class PredictionState with _$PredictionState {
  const factory PredictionState.initial() = _PredictionInitial;
  const factory PredictionState.loadInProgress() = _PredictionLoadInProgress;
  const factory PredictionState.loadSuccess(PredictionEntity predictionEntity) = _PredictionLoadSuccess;
  const factory PredictionState.loadFailure(String error) = _PredictionLoadFailure;
}
