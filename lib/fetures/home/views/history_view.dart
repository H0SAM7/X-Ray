import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:x_ray2/constants.dart';
import 'package:x_ray2/core/models/search_model.dart';
import 'package:x_ray2/core/utils/app_styles.dart';
import 'package:x_ray2/core/utils/assets.dart';
import 'package:x_ray2/fetures/ai/views/save_data.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
class HistoryView extends StatefulWidget {
  const HistoryView({super.key});
  static String id = 'HistoryView';

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
    Future<void> clearHistory() async {
    final box = Hive.box<SearchModel>(kSearchHistoryBox);
    await box.clear();
    history?.clear();
    log('All entries in the historyBox have been cleared.');
  }
  @override
  void initState() {
    fetchAllHistory();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
                 backgroundColor: Colors.white,

elevation: 0,
        title: Text(
          'History',
          style: AppStyles.poppinsStylebold20,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  PopupMenuItem(
                    child: TextButton.icon(
                        label: Text('Clear all history'),
                        onPressed: () async{
                             await clearHistory();
                          setState(() {});
                        },
                        icon: Icon(Icons.delete)),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            history == null || history!.isEmpty
                ? Expanded(
                    child: Center(child: Image.asset(Assets.imagesNohistory)))
                : Expanded(
                    child: ListView.builder(
                      itemCount: history!.length,
                      itemBuilder: (context, ind) {
                        return CustomHistoryCard(
                          searchModel: history![ind],
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class CustomHistoryCard extends StatelessWidget {
  const CustomHistoryCard({
    super.key,
    required this.searchModel,
  });
  final SearchModel searchModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('History'),
      subtitle: Text(searchModel.result),
      trailing: Image.memory(
        searchModel.imageBytes, // Display the image
        height: 200,
        width: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
