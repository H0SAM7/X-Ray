import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/models/search_model.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/core/widgets/custom_container.dart';
import 'package:x_ray2/fetures/ai/views/save_data.dart';

class ImageClassificationScreen extends StatefulWidget {
  static String id = 'ImageClassificationScreen';
  @override
  _ImageClassificationScreenState createState() =>
      _ImageClassificationScreenState();
}

class _ImageClassificationScreenState extends State<ImageClassificationScreen> {
  late MLService mlService;
  File? _image;
  String _result = "";

  @override
  void initState() {
    super.initState();
    mlService = MLService();
    mlService.loadModel().then((_) {
      log('Model loaded successfully.');
    }).catchError((error) {
      log('Error loading model: $error');
    });
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      classifyImage(pickedFile.path);
    }
  }

  Future<void> classifyImage(String imagePath) async {
    if (_image == null) return;

    Uint8List imageBytes = await convertImageToBytes(imagePath);

    // Ensure the image bytes have the expected size of 256*256*1 (grayscale)
    if (imageBytes.length != 256 * 256) {
      log('Error: Image bytes length is ${imageBytes.length}, expected ${256 * 256}');
      setState(() {
        _result = "Error: Invalid image data";
      });
      return;
    }

    List<double>? result = await mlService.classifyImage(imageBytes);

    setState(() {
      if (result != null && result.isNotEmpty) {
        log('Raw model output: $result');

        double probabilityNormal =
            result[1] * 100; // Assuming index 1 is for normal
        double probabilityCancer =
            result[0] * 100; // Assuming index 0 is for cancer

        String prob = (probabilityCancer - 13.2).toStringAsFixed(2) + '%';

        // Determine if the patient is normal or has cancer based on the rounded prediction
        if (result[1] == 1) {
          // Assuming a threshold of 0.5 for classifying as normal
          _result = ' Normal Patient';
        } else {
          _result = '$prob The patient has Cancer disease';
        }
      } else {
        _result = "Error: Invalid result from model.";
      }
    });
  }

  Future<Uint8List> convertImageToBytes(String imagePath) async {
    try {
      // Read and decode the image file
      final image = img.decodeImage(await File(imagePath).readAsBytes());
      if (image == null) {
        log('Failed to decode image');
        throw Exception('Failed to decode image');
      }

      // Convert the image to grayscale and resize it to (256, 256)
      final grayscaleImage = img.grayscale(image);
      final resizedImage =
          img.copyResize(grayscaleImage, width: 256, height: 256);

      // Convert pixel data to a flat list of bytes
      List<int> pixelData = [];
      for (int y = 0; y < resizedImage.height; y++) {
        for (int x = 0; x < resizedImage.width; x++) {
          img.Pixel pixel = resizedImage.getPixel(x, y);
          pixelData
              .add(pixel.r.round()); // Accessing the red value for grayscale
        }
      }

      log('Pixel data length: ${pixelData.length}');
      if (pixelData.length != 256 * 256) {
        throw Exception('Pixel data does not have the expected size');
      }

      return Uint8List.fromList(pixelData);
    } catch (e) {
      log('Error converting image to bytes: $e');
      throw e;
    }
  }

  @override
  void dispose() {
    mlService.dispose(); // Dispose of the interpreter
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Cancer Classification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text('Click on the Button for starting')
                :
                //Image.file(_image!, height: 200),
                CircleAvatar(
                    radius: 80,
                    backgroundImage:
                       FileImage(_image!),
                  ),
            SizedBox(height: 20),
            //  Text('Prediction: $_result'),
            SizedBox(
              height: 20,
            ),
            _image == null
                ? CustomContainer(
                    onTap: pickImage,
                    child: Text(
                      'Upload Image for Analyze',
                      textAlign: TextAlign.center,
                      style: AppStyles.poppinsStylebold20
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  )
                : Column(
                    children: [
                      CustomContainer(
                        color: blueColor,
                        height: 60,
                        child: Text(
                          'Prediction: $_result',
                          style: AppStyles.styleMeduim24
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomContainer(
                        color: Colors.blue,
                        child: Text(
                          'Save The Result',
                          style: AppStyles.styleMeduim24
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            Uint8List imageBytes = _image!.readAsBytesSync();

                            addHistory(SearchModel(
                                result: _result, imageBytes: imageBytes));
                            _image = null;
                          });
                          fetchAllHistory();
                        },
                      ),
                    ],
                  )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: pickImage,
      //   tooltip: 'Pick Image',
      //   child: Icon(Icons.add_a_photo),
      // ),
    );
  }
}

class MLService {
  late Interpreter _interpreter;

  // Correct model path

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(modelPath);
    } catch (e) {
      log('Failed to load model: $e');
      throw e;
    }
  }

  Future<List<double>?> classifyImage(Uint8List image) async {
    var inputShape = [1, 256, 256, 1]; // Input shape for grayscale
    var outputShape = [1, 2]; // Adjust based on your model's output shape

    log('Output shape: $outputShape');

    if (outputShape.isEmpty || outputShape.any((dim) => dim <= 0)) {
      log('Error: Output shape is invalid or empty!');
      return null;
    }

    // Normalize pixel values to [0, 1]
    var inputImage = List<double>.generate(
      256 * 256,
      (index) => image[index] / 255.0,
    ).reshape<double>(inputShape);

    // Prepare the output array
    var output = List<List<double>>.generate(
        1, (_) => List<double>.filled(2, 0.0)); // Output shape is [1, 2]

    // Run inference
    _interpreter.run(inputImage, output);

    log('Output: $output');

    return output[0]; // Return the predictions as a flat list
  }

  void dispose() {
    _interpreter.close();
  }
}
