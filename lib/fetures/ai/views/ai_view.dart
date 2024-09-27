// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image/image.dart' as img;
// import 'package:x_ray2/fetures/ai/views/test_view.dart';
// import 'dart:io';

// class BrainTumorDetector extends StatefulWidget {
//   @override
//   _BrainTumorDetectorState createState() => _BrainTumorDetectorState();
// }

// class _BrainTumorDetectorState extends State<BrainTumorDetector> {
//   final ImagePicker _picker = ImagePicker();
//   BrainTumorModel model = BrainTumorModel();
//   File? _image;
//   String _result = '';

//   @override
//   void initState() {
//     super.initState();
//     model.loadModel();  // Load the model when the app starts
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//       _classifyImage(File(pickedFile.path));
//     }
//   }

//   Future<void> _classifyImage(File imageFile) async {
//     final bytes = await imageFile.readAsBytes();
//     final image = img.decodeImage(bytes);

//     if (image != null) {
//       await model.classifyImage(image);
//       setState(() {
//         _result = 'Classification completed!';  // Modify to show actual result
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Brain Tumor Detector'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           _image == null
//               ? Text('No image selected.')
//               : Image.file(_image!),
//           SizedBox(height: 16),
//           Text('Result: $_result'),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: _pickImage,
//             child: Text('Pick an Image'),
//           ),
//         ],
//       ),
//     );
//   }
// }
