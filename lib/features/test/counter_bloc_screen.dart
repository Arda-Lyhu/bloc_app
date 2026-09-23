import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/counter_bloc.dart';
import 'bloc/counter_event.dart';

class CounterBlocScreen extends StatelessWidget {
  const CounterBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Counter BLoC'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterIncremented());
                  },
                  icon: Icon(
                    Icons.add,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterDecremented());
                  },
                  icon: Icon(
                    Icons.remove,
                  ),
                ),
              ],
            ),
            body: Center(
              child: BlocBuilder<CounterBloc, int>(
                builder: (context, state) {
                  return Center(
                    child: Text(
                      state.toString(),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
