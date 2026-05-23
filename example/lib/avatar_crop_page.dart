import 'dart:io';
import 'dart:ui' as ui;
import 'package:crop_image_pro/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AvatarCropPage extends StatefulWidget {
  AvatarCropPage({super.key, required this.mode, required this.data});
  final CropInteractionMode mode;

  ValueChanged<Uint8List> data;

  @override
  State<AvatarCropPage> createState() => _AvatarCropPageState();
}

class _AvatarCropPageState extends State<AvatarCropPage> {
  late final CropController _controller = CropController(
    aspectRatio: 1, // 正方形头像
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9), // 默认居中一块
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: CropImagePro(
            controller: _controller,
            image: Image.asset('assets/images.jpg'),
            alwaysShowThirdLines: true,
            interactionMode: widget.mode,
            showCorners: false,
          )),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.black,
                border:
                    Border(top: BorderSide(width: 0.6, color: Colors.black26))),
            child: SafeArea(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const SizedBox(
                    width: 90,
                    height: 48,
                    child: Center(
                      child: Text(
                        '取消',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    final ui.Image bitmap = await _controller.croppedBitmap();
                    final byteData =
                        await bitmap.toByteData(format: ui.ImageByteFormat.png);

                    Uint8List? du = byteData?.buffer.asUint8List();
                    widget.data(du!);
                    Navigator.pop(context);
                  },
                  child: const SizedBox(
                    width: 90,
                    height: 48,
                    child: Center(
                      child: Text(
                        '完成',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
