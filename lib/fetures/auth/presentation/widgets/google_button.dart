
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
      child: Card(
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 5,
        child: Container(
          height: 50,
            width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: .2),
              borderRadius: BorderRadius.circular(30),
              //color: orangeColor,
              ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Image.asset(Assets.imagesGoogle,width: 50,height: 40,) ,
                 const Text(
                  textAlign: TextAlign.center,
                 'Continue with Google',
                  style: TextStyle(
                 //  color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}