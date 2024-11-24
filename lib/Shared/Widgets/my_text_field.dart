import 'package:flutter/material.dart';
import '../Constants/colors.dart';

class CusumizedTextFormField extends StatelessWidget {
  const CusumizedTextFormField({
    super.key,
    required this.searchController,
    required this.emptyFieldMessage,
    required this.labelText,
  });

  final TextEditingController searchController;
  final String emptyFieldMessage;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return emptyFieldMessage;
        }
      },
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: AppColors.color5,
            width: 1,
          ),
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white30,
          fontSize: 20,
        ),
      ),
    );
  }
}
