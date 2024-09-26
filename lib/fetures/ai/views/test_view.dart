import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';




class ImageClassifierScreen extends StatefulWidget {
     static String id='ImageClassifierScreen';
  @override
  _ImageClassifierScreenState createState() => _ImageClassifierScreenState();
}

class _ImageClassifierScreenState extends State<ImageClassifierScreen> {
  File? _image;
  final picker = ImagePicker();
  late Interpreter _interpreter;
  String _result = '';

  @override
  void initState() {
  
  super.initState();
  
    _loadModel();
  
  }

  // Load the TFLite model
  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('model.tflite');
      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  // Pick image from gallery or camera
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _classifyImage(_image!);
    }
  }

  // Preprocess and classify the image using the model
  Future<void> _classifyImage(File image) async {
    // Load and preprocess the image
    var imageInput = await _loadImage(image);

    // Prepare input and output buffers
    var input = imageInput.buffer.asUint8List();
    var output = List.filled(1, 0).reshape([1, 1]);

    // Run inference
    _interpreter.run(input, output);

    setState(() {
      _result = 'Prediction: ${output[0][0]}';  // Display the prediction
    });
  }

  // Helper function to load and preprocess image
  Future<TensorImage> _loadImage(File imageFile) async {
    var image = TensorImage.fromFile(imageFile);

    // Preprocess the image: resize and normalize
    final processor = ImageProcessorBuilder()
        .add(ResizeOp(224, 224, ResizeMethod.BILINEAR))  // Resize to 224x224
        .add(NormalizeOp(0, 255))  // Normalize pixel values (0-255)
        .build();

    image = processor.process(image);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Classifier'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(_image!, height: 200),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
