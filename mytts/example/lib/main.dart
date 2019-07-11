import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mytts/mytts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Mytts.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: <Widget>[
            RaisedButton(
                child: const Text('设置成汉语'),
                onPressed: () {
                  Mytts.setLanguage('zh-CN').then((v) {
                    debugPrint('r = $v');
                  });
                }),
            RaisedButton(
                child: const Text('播放汉语'),
                onPressed: () {
                  Mytts.speak('你好，世界');
                }),
            RaisedButton(
                child: const Text('播放长句子'),
                onPressed: () {
                  Mytts.speak('你好，世界。我正在测试播放很长的句子，你可以点击下方的播放暂停按钮来终止我的播放，如果我没有停止那就意味着这个停止功能还有问题。请你继续修复。啦啦啦啦！');
                }),
            RaisedButton(
                child: const Text('播放暂停'),
                onPressed: () {
                  Mytts.stop();
                }),
            RaisedButton(
                child: const Text('播放暂停，立刻开始新句子'),
                onPressed: () {
                  Mytts.stop();
                  Mytts.speak('hello,world');
                }),
            RaisedButton(
                child: const Text('中文可用性'),
                onPressed: () {
                  Mytts.isLanguageAvailable('zh-CN').then((v) {
                    debugPrint('r = $v');
                  });
                }),
            RaisedButton(
                child: const Text('设置语速为1正常'),
                onPressed: () {
                  Mytts.setSpeechRate(0.5);
                }),
            RaisedButton(
                child: const Text('设置语速为0.5'),
                onPressed: () {
                  Mytts.setSpeechRate(0.25);
                }),
            RaisedButton(
                child: const Text('设置语速为2'),
                onPressed: () {
                  Mytts.setSpeechRate(1);
                }),
            Center(child: Text('Running on: $_platformVersion\n')),
            RaisedButton(child: Text('Running on: $_platformVersion\n'), onPressed: () => setState(() {})),
          ],
        ),
      ),
    );
  }
}
