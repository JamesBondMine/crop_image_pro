
# Crop Image Pro

[![pub package](https://img.shields.io/pub/v/crop_image.svg)](https://pub.dev/packages/crop_image)

一个支持多平台（Flutter移动端、Web、桌面）的图片裁剪插件，完全用 Dart 实现，无需依赖原生库。

## 功能特性

- 支持拖拽图片、放大缩小图片，灵活选定裁剪区域
- 支持拖动裁剪框、放大缩小裁剪框，精准选定裁剪区域
- 可自定义裁剪框外观（颜色、线宽、圆角等）
- 支持固定/自定义裁剪比例
- 支持裁剪区域旋转
- 支持获取裁剪后图片像素数据
- 兼容所有 Flutter 支持的平台


## 预览

<img src="https://github.com/JamesBondMine/crop_image_pro/blob/main/crow_image_pro_preview.jpg?raw=true" alt="插件预览" width="300" />


## 快速开始

```dart
final controller = CropController(
  aspectRatio: 1, // 可选，裁剪框宽高比
  defaultCrop: Rect.fromLTRB(0.1, 0.1, 0.9, 0.9), // 可选，初始裁剪区域
);

Expanded(
  child: CropImagePro(
    controller: controller,
    image: Image.asset('assets/images.jpg'),
    alwaysShowThirdLines: true,
    interactionMode: CropInteractionMode.image, // 或 CropInteractionMode.crop
    showCorners: false,
  ),
)
```

> 你可以将 `CropImagePro` 放在任意布局中，常见用法如上。`interactionMode` 可选 "image" 或 "crop"，分别对应图片拖拽/缩放和裁剪框拖拽/缩放模式。

## 主要参数说明

- `aspectRatio`：裁剪框宽高比
- `defaultCrop`：初始裁剪区域（百分比）
- `gridColor`、`gridInnerColor`、`gridCornerColor`：裁剪框线条颜色
- `gridCornerSize`、`cornerOffset`：裁剪框角尺寸与偏移
- `minimumImageSize`、`maximumImageSize`：裁剪框最小/最大像素尺寸
- `alwaysShowThirdLines`：是否总显示九宫格辅助线
- `scrimColor`：裁剪区域外遮罩颜色

## 裁剪与导出

```dart
// 获取裁剪区域（百分比和像素）
Rect cropRect = controller.crop;
Rect cropRectPx = controller.cropSize;

// 导出裁剪后的图片
ui.Image bitmap = await controller.croppedBitmap();
Image image = await controller.croppedImage();
```

## 旋转裁剪区域

```dart
controller.rotation = CropRotation.right;
controller.rotateLeft();
controller.rotateRight();
```

## 保存图片到文件

```dart
data = await bitmap.toByteData(format: ImageByteFormat.png);
bytes = data!.buffer.asUint8List();
file.writeAsBytes(bytes, flush: true);
```

## 常见问题

- Flutter Web 下请优先使用 CanvasKit 渲染，HTML 渲染器不支持 `Picture.toImage()`。

# 支持

如果你喜欢这个插件，欢迎支持作者。

<a href="https://www.buymeacoffee.com/deakjahn" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Book" height="60" width="217"></a>