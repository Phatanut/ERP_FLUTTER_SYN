import 'package:flutter/material.dart';
import 'package:inventory_app/models/profiles.dart';
import 'package:inventory_app/pallete.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.icon,
    required this.hint,
    required this.inputType,
    required this.inputAction,
  });

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.green[200]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextFormField(
            key: formKey,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  widget.icon,
                  size: 28,
                  color: kWhite,
                ),
              ),
              hintText: widget.hint,
              hintStyle: kBodyText,
            ),
            obscureText: true,
            style: kBodyText,
            keyboardType: widget.inputType,
            onSaved: (String? passwords) {
              profile.passwords = passwords;
            },
            textInputAction: widget.inputAction,
          ),
        ),
      ),
    );
  }
}
