import 'package:flutter/material.dart';
import 'package:instagram/count_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ChangeNotifierProvider<CountModel>(
        create: (_) => CountModel(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarColor = context.select((CountModel model) => model.appBarColor);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'First Counter',
                ),
                const CountBody(),
                Consumer<CountModel>(builder: (context, model, child) {
                  return FloatingActionButton(
                    onPressed: model.incrementCounter,
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  );
                }),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Second Counter',
                ),
                const SecondCountBody(),
                Consumer<CountModel>(builder: (context, model, child) {
                  return FloatingActionButton(
                    onPressed: model.incrementSecondCounter,
                    tooltip: 'Increment Second Counter',
                    child: const Icon(Icons.add),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CountBody extends StatelessWidget {
  const CountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountModel>(
      builder: (context, model, child) => Text(
        '${model.counter}',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class SecondCountBody extends StatelessWidget {
  const SecondCountBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountModel>(
      builder: (context, model, child) => Text(
        '${model.secondCounter}',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
