import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

void main() {
  runApp(SignLanguageApp());
}

class SignLanguageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    SignatureScreen(),
    HandwritingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.android, color: Colors.black),
        //   onPressed: () {},
        // ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Signature'),
          BottomNavigationBarItem(icon: Icon(Icons.draw), label: 'Handwriting'),
        ],
      ),
    );
  }
}

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          Container(
            height: 250,
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: _imageBytes != null
                ? Image.memory(_imageBytes!, fit: BoxFit.contain)
                : Center(
                    child: Text("Choose an image for your signature",
                        style: TextStyle(fontSize: 16))),
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.upload_file),
            label: Text('Choose image from device',
                style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}

class HandwritingScreen extends StatefulWidget {
  @override
  _HandwritingScreenState createState() => _HandwritingScreenState();
}

class _HandwritingScreenState extends State<HandwritingScreen> {
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 40),
          Container(
            height: 250,
            width: 350,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: _imageBytes != null
                ? Image.memory(_imageBytes!, fit: BoxFit.contain)
                : Center(
                    child: Text("Choose an image for your handwriting",
                        style: TextStyle(fontSize: 16))),
          ),
          SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.upload_file),
            label: Text('Choose image from device',
                style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
