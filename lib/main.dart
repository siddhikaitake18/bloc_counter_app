import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/counter_bloc.dart';
import 'bloc/counter_event.dart';
import 'bloc/counter_state.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CounterBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLoC Counter App',
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLoC Counter App'),
      ),
      body: BlocListener<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.count == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Counter Reset'),
              ),
            );
          }
        },
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Counter Value',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${state.count}',
                    style: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: state.count == 10
                            ? null
                            : () {
                                context
                                    .read<CounterBloc>()
                                    .add(Increment());
                              },
                        child: const Text('➕ Increment'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: state.count == 0
                            ? null
                            : () {
                                context
                                    .read<CounterBloc>()
                                    .add(Decrement());
                              },
                        child: const Text('➖ Decrement'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CounterBloc>().add(Reset());
                        },
                        child: const Text('🔄 Reset'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (state.count == 10)
                    const Text(
                      'Maximum limit reached',
                      style: TextStyle(fontSize: 18),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}