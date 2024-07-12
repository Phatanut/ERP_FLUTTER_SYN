import 'package:flutter/material.dart';

class PreprForm extends StatelessWidget {
  const PreprForm(
      {super.key,
      required this.fieldName,
      this.prefixIconColor = Colors.red,
      required this.onSave});

  final String fieldName;

  final Color prefixIconColor;
  final void Function(String?)? onSave;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: size.height * 0.08,
          width: size.width * 0.4,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: fieldName,
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent.shade400),
              ),
              labelStyle: const TextStyle(color: Colors.blueAccent),
            ),
            onSaved: onSave,
          ),
        ));
  }
}
