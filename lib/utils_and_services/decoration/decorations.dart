import 'package:flutter/material.dart';

import 'colors.dart';

final List<BoxShadow> boxShadow = [
  BoxShadow(
    color: Colors.grey[200]!,
    blurRadius: 5,
    offset: const Offset(0, 3),
    spreadRadius: 3,
  ),
];

const BoxDecoration curvedContainer = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(20),
  ),
);

final InputDecoration inputDecoration = InputDecoration(
  contentPadding: EdgeInsets.zero,
  hintStyle: const TextStyle(
    color: greyC8C8C8,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(2),
    borderSide: const BorderSide(color: greyB5B5B5),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(2),
    borderSide: const BorderSide(color: greyB5B5B5),
  ),
);
