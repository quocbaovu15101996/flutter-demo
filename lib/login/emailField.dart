import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  _EmailFieldState createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final textFieldFocusNode = FocusNode();

  void _toggleObscured() {
    setState(() {
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      focusNode: textFieldFocusNode,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never, //Hides label on focus or if filled
        labelText: "Email",
        filled: true, // Needed for adding a fill color
        fillColor: const Color.fromARGB(255, 234, 234, 234),
        isDense: true,  // Reduces height a bit
        border: OutlineInputBorder(
          borderSide: BorderSide.none,              // No border
          borderRadius: BorderRadius.circular(12),  // Apply corner radius
        ),
        prefixIcon: const Icon(Icons.account_box_outlined, size: 24),
      ),
    );
  }
}