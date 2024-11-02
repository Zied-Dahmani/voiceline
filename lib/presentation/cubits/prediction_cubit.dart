import 'dart:async';
import 'dart:developer' as developer;
import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:voiceline/domain/entities/prediction_entity.dart';
import 'package:voiceline/domain/usecases/classifier/classifier_use_case_interface.dart';
import 'package:voiceline/domain/usecases/image/image_use_case_interface.dart';
import 'package:voiceline/presentation/cubits/prediction_state.dart';

class PredictionCubit extends Cubit<PredictionState> {
  final IImageUseCase _imageUseCase;
  final IClassifierUseCase _classifierUseCase;

  PredictionCubit(this._imageUseCase, this._classifierUseCase) : super(const PredictionState.initial());

  Future<void> predict() async {
    try {
      final XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        emit(const PredictionState.loadInProgress());
        final Uint8List image = await _imageUseCase.removeBackground(pickedImage.path);
        final Category category = _classifierUseCase.predict(image);
        emit(PredictionState.loadSuccess(PredictionEntity(image, category)));
      }
    } catch (e) {
      developer.log(e.toString(), name: 'Catch PredictionCubit');
      emit(PredictionState.loadFailure(e.toString()));
    }
  }
}
