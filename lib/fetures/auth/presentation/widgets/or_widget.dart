import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 20,
      width: 100,
      child: Row(
        children: [
          Container(
            height: 2,
            width: 30,
            color: Colors.grey,
          ),
          const Text(
            "OR",
            style: TextStyle(color: Colors.grey),
          ),
          Container(
            height: 2,
            width: 30,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
