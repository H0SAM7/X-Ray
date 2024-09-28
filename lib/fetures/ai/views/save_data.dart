import 'dart:developer';

import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/models/search_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

addHistory(SearchModel searchModel) async {
  try {
    var historyBox = Hive.box<SearchModel>(kSearchHistoryBox);
    await historyBox.add(searchModel);
      log('Image and result saved to Hive');

  } catch (e) {
  log('Image and result errrrrrrrrrr saved to Hive');

  }
}

List<SearchModel>? history;
fetchAllHistory() {
  var noteBox = Hive.box<SearchModel>(kSearchHistoryBox);
  history = noteBox.values.toList();
}
