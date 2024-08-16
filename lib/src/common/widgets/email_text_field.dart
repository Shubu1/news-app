import 'package:flutter/material.dart';

class TextFormFieldd extends StatefulWidget {
  const TextFormFieldd({
    super.key,
    this.validator,
    required this.dataController,
    required this.hintText,
    this.textInputType,
    this.labelText,
    this.textInputAction,
  });

  final String? Function(String?)? validator;
  final TextEditingController dataController;
  final String hintText;
  final TextInputType? textInputType;
  final String? labelText;
  final TextInputAction? textInputAction;

  @override
  State<TextFormFieldd> createState() => _TextFormFielddState();
}

class _TextFormFielddState extends State<TextFormFieldd> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      controller: widget.dataController,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // Set the background color to white
        labelText: widget.labelText,
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
