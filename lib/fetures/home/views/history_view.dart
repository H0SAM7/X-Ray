import 'package:flutter/material.dart';
import 'package:x_ray2/core/utils/assets.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});
  static String id = 'HistoryView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, ind) {
                  return ListTile(
                    title: Text('History'),
                    subtitle: Text('This is a history page'),
                    trailing: Image.asset(Assets.imagesLogo),
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
