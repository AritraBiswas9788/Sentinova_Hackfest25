import 'package:flutter/material.dart';

class KeyInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;

  const KeyInputField({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15), // translucent white
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(width: 20,),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter Password',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: onSubmit,
            icon: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
