import 'package:flutter/material.dart';
import 'package:instagram/count_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ChangeNotifierProvider(
        create: (_) => CountModel(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const CountBody(),
      floatingActionButton: Builder(builder: (context) {
        final model = context.read<CountModel>();
        return FloatingActionButton(
          onPressed: model.incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}

class CountBody extends StatelessWidget {
  const CountBody({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<CountModel>(context);
    final model = context.watch<CountModel>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '${model.counter}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
