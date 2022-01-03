import 'package:flutter/material.dart';

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