import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voiceline/config/injection.dart';
import 'package:voiceline/domain/entities/prediction_entity.dart';
import 'package:voiceline/presentation/cubits/prediction_cubit.dart';
import 'package:voiceline/presentation/cubits/prediction_state.dart';

class PredictionScreen extends StatelessWidget {
  const PredictionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocProvider<PredictionCubit>(
      create: (BuildContext context) => getIt<PredictionCubit>(),
      child: BlocBuilder<PredictionCubit, PredictionState>(
          builder: (BuildContext context, PredictionState state) {
            return Scaffold(
              body: state.when(
                initial: () => Center(
                  child: Text('Pick an image!', style: theme.textTheme.bodyLarge),
                ),
                loadInProgress: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loadSuccess: (PredictionEntity predictionEntity) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Image.memory(predictionEntity.image),
                      ),
                      Text(
                        predictionEntity.category.label,
                        style: theme.textTheme.headlineSmall,
                      ),
                      Text(
                        'Confidence: ${predictionEntity.category.score.toStringAsFixed(3)}',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                loadFailure: (String error) => Center(
                  child: Text(
                    'Error: $error',
                    style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.error),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.read<PredictionCubit>().predict();
                },
                tooltip: 'Pick Image',
                child: const Icon(Icons.add_a_photo),
              ),
            );
          },
        ),
    );
  }
}
