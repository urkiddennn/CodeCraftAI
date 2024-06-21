import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeProvider extends ChangeNotifier {
  Uint8List? imageData;
  TextEditingController textController = TextEditingController();

  bool isLoading = false;
  bool searchChanging = false;

  void loadingUpdate(bool val) {
    isLoading = val;
    notifyListeners();
  }

  void searchUpdate(bool val) {
    searchChanging = val;
    notifyListeners();
  }

  Future<void> textToImage() async {
    String engine_id = "stable-diffusion-v1-6";
    String api_host = "https://api.stability.ai";
    String api_key = "sk-D4KHBClKLBmNXoBQedAnZbVwhfYoYc5nsFNsUiTkpsMgHnbg";

    final response = await http.post(
        Uri.parse('$api_host/v1/generation/$engine_id/text-to-image'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'image/png',
          'Authorization': 'Bearer $api_key'
        },
        body: jsonEncode(
          {
            "text_prompts": [
              {
                "text": textController.text,
                "weight": 1,
              }
            ],
            "cfg_scale": 7,
            "height": 1024,
            "width": 1024,
            "samples": 1,
            "steps": 30,
          },
        ));
    if (response.statusCode == 200) {
      imageData = response.bodyBytes;
      loadingUpdate(false);
      searchUpdate(true);
      notifyListeners();
    } else {
      debugPrint(response.statusCode.toString());
    }
  }

  Future<void> saveImage() async {
    if (imageData != null) {
      // Request storage permission
      if (await Permission.storage.request().isGranted) {
        final directory = await getExternalStorageDirectory();
        final path = directory?.path;
        final file = File('$path/generated_image.png');
        await file.writeAsBytes(imageData!);

        // Notify user that the image is saved
        print('Image saved to $path/generated_image.png');
      } else {
        // Handle the case where the permission is not granted
        print('Storage permission denied');
      }
    }
  }
}
