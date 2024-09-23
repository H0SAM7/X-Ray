import 'package:flutter/material.dart';

class CustomTextFrom extends StatefulWidget {
  const CustomTextFrom({
    super.key,
    this.onChanged,
    required this.label,
    required this.hint,
    this.hide = false,
    this.validator,
    this.isPasswordField = false,
    this.controller,
  });
  final void Function(String)? onChanged;
  final String label, hint;
  final bool hide;
  final String? Function(String?)? validator;
  final bool isPasswordField;
  final TextEditingController? controller;
  @override
  State<CustomTextFrom> createState() => _CustomTextFromState();
}

class _CustomTextFromState extends State<CustomTextFrom> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'fill all fields pleas';
              }
              return null;
            },
        onChanged: widget.onChanged,
        obscureText: widget.isPasswordField ? _isObscure : false,
        decoration: InputDecoration(
          label: Text(widget.label),
          hintText: widget.hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
