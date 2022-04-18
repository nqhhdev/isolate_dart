// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                child: const Text("Click"),
                onPressed: () {
                  demoCompute();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void demoCompute() async {
    int sesult = await compute(calculate, 7);
    print(sesult);
  }

  static int calculate(int number) {
    return number * 10000;
  }

  void createNewIsolate() async {
    //Main isolate
    ReceivePort receivePort = ReceivePort();
    //Create   New Isolate
    Isolate newIsolate = await Isolate.spawn(
      taskRunner,
      receivePort.sendPort,
    );

    Future.delayed(
      const Duration(seconds: 1),
      () {
        newIsolate.kill(priority: Isolate.immediate);
        print("New Isolate killed");
      },
    );

    Isolate.spawn(
      taskRunner,
      receivePort.sendPort,
    );
    receivePort.listen((message) {
      print(message[0]);
      if (message[1] is SendPort) {
        message[1].send("From Main ISolate");
      }
    });
  }

  // Static function, top function (same function main)
  static void taskRunner(SendPort sendPort) {
    //New Isolate
    ReceivePort receivePort = ReceivePort();

    receivePort.listen((message) {
      print(message);
    });
    for (int i = 0; i < 10000000; i++) {
      print("New ISolate");
    }
    sendPort.send([
      print("New ISolate"),
      receivePort.sendPort,
    ]);
  }
}
