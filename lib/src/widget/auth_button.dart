import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget{
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  const AuthButton({super.key, required this.text, required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
   return ElevatedButton(onPressed: onTap, child: isLoading ?const Center(child: CircularProgressIndicator(),) : Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),));
  }

}