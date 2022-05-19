import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            '${ kIsWeb ? "Web" : Platform.operatingSystem} Device Info ',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        FutureBuilder<BaseDeviceInfo>(
            future: deviceInfo.deviceInfo,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox(height: 50, child: CircularProgressIndicator());
              var info = snapshot.data!.toMap();
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.80,
                child: ListView.builder(
                    itemCount: info.length,
                    itemBuilder: (ctx, i) => ListTile(
                            title: RichText(
                          text: TextSpan(
                              text: '${info.keys.elementAt(i)} : ',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                              children: [
                                TextSpan(
                                    text: info[info.keys.elementAt(i)].toString(),
                                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal))
                              ]),
                        ))),
              );
            })
      ]),
    );
  }
}
