import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget{
  final TextEditingController controller;
  final Function(String value)? onChanged;

  const SearchInput({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffe0e4ff),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Cari disini',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(17.0),
        ),
      ),
    );
  }
}
