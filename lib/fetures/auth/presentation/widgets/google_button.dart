
import 'package:flutter/material.dart';
import 'package:x_ray2/core/utils/assets.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(width: .2),
            borderRadius: BorderRadius.circular(10),
            //color: orangeColor,
            ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Image.asset(Assets.imagesGoogle,width: 50,height: 40,) ,
               const Text(
                textAlign: TextAlign.center,
               'Sign in With Google',
                style: TextStyle(
               //  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}