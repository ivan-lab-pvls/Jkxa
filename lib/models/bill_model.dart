
import 'package:flutter/material.dart';

class BillModel {
  final double value;
  final String comment;
  final String type;
  final DateTime date;

  BillModel({
    required this.value,
    required this.comment,
    required this.date,
    required this.type,
  });
}