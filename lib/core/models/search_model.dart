import 'dart:io';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
part 'search_model.g.dart';
@HiveType(typeId: 0)
class SearchModel extends HiveObject{
  @HiveField(0)
  final String result;
    @HiveField(1)
  final Uint8List imageBytes;

  SearchModel({required this.result, required this.imageBytes, File? pickedFile});
}