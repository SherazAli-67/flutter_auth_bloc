import 'package:flutter/material.dart';
import 'package:flutter_auth_bloc/src/utils/app_constants.dart';

class InputFieldWidget extends StatefulWidget{
  const InputFieldWidget({super.key, required this.textEditingController, required this.hintText, this.isPassword =false});

  final TextEditingController textEditingController;
  final String hintText;
  final bool isPassword;

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textEditingController,
      obscureText: widget.isPassword && _hidePassword,
      onTapOutside: (event)=> FocusManager.instance.primaryFocus!.unfocus(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isPassword? IconButton(onPressed: _toggleVisibility, icon: _hidePassword ? Icon(Icons.visibility_off) :Icon(Icons.visibility)) : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  void _toggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }
}