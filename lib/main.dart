import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';
import 'package:test_printer/test_print.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Printer Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BluetoothPrinter _bluePrinter = BluetoothPrinter();

  bool connected = false;
  String pathImage = '';
  late TestPrint testPrint;

  @override
  void initState() {
    super.initState();
    testPrint = TestPrint();
    initPlatformState();
    //testPrint = TestPrint();
  }

  Future<void> initPlatformState() async {
    await _bluePrinter.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await initPlatformState(),
        child: const Icon(Icons.search),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<List<BluetoothDevice>>(
                stream: _bluePrinter.scanResults,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final printer = snapshot.data![index];
                        return ListTile(
                          onTap: () async {
                            final isConnected = await printer.connect();
                            if (isConnected) {
                              setState(() => connected = true);
                            }
                          },
                          title: Text(printer.name),
                          subtitle: Text(printer.address),
                        );
                      });
                },
              ),
            ),
            Visibility(
              visible: connected,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.brown),
                  onPressed: () async {
                   final connectedDevice = await _bluePrinter.getConnectedDevice();
                   if(connectedDevice == null) return;
                   final ticket = await TestPrint.getTicket();
                   await connectedDevice.printBytes(bytes: Uint8List.fromList(ticket));
                  },
                  child: const Text(
                    'PRINT TEST',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
