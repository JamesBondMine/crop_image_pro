import 'dart:io';

import 'package:crop_image_pro/crop_image.dart';
import 'package:example/avatar_crop_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String path = '';

  String imagePath = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  void _navigateToCropPage(String mode) {
    // 假设你有 pickedFile 变量，先设置 path
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvatarCropPage(
          mode: mode== 'image' ? CropInteractionMode.panZoomImage : CropInteractionMode.resizeCropRect,
          data: (value) async {
            // 获取应用文档目录
            final directory = Directory.systemTemp;
            path = '${directory.path}/avatar_crop_${DateTime.now().millisecondsSinceEpoch}.png';
            final croppedFile = File(path)
              ..writeAsBytesSync(value, flush: true);
            if (croppedFile.path.isNotEmpty) {
              setState(() {
                imagePath = croppedFile.path;
              });
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _navigateToCropPage('image'),
              child: const Text('图片模式'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _navigateToCropPage('crop'),
              child: const Text('裁剪框模式'),
            ),
            imagePath.isEmpty ? const SizedBox() : Image.file(File(imagePath), width: 200, height: 200,fit: BoxFit.cover,)
          ],
        ),
      ),
    );
  }
}
