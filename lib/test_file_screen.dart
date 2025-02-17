import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestFileScreen extends StatefulWidget {
  @override
  _TestFileScreenState createState() => _TestFileScreenState();
}

class _TestFileScreenState extends State<TestFileScreen> {
  File? _image;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadSavedImage();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File tempImage = File(pickedFile.path);
      await _saveImage(tempImage);
    }
  }

  Future<void> _saveImage(File imageFile) async {
    final directory =
        await getLibraryDirectory(); // 📌 getLibraryDirectory() 사용
    final String path = '${directory.path}/saved_image.png';
    final File savedImage = await imageFile.copy(path);

    // 경로를 SharedPreferences에 저장
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'saved_image_path', 'saved_image.png'); // 🔹 전체 경로가 아닌 상대 경로로 저장

    setState(() {
      _image = savedImage;
      _imagePath = path;
    });

    print('이미지 저장 완료: $path');
  }

  Future<void> _loadSavedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedRelativePath = prefs.getString('saved_image_path');

    if (savedRelativePath != null) {
      final directory = await getLibraryDirectory();
      String fullPath = '${directory.path}/$savedRelativePath';

      if (File(fullPath).existsSync()) {
        setState(() {
          _image = File(fullPath);
          _imagePath = fullPath;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('이미지 선택 및 저장')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null ? Image.file(_image!) : Text('이미지를 선택하세요'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('이미지 선택'),
            ),
            Image.file(File(
                '/Users/jongseowon/Library/Developer/CoreSimulator/Devices/F656C15C-C6EC-4DD2-878E-AAF544729C0E/data/Containers/Data/Application/2DABF4B7-8196-4023-BC24-18FB33686124/Library/saved_image.png'))
          ],
        ),
      ),
    );
  }
}


//