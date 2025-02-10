import 'package:flutter/material.dart';

enum GenderType {
  MAIL(0),
  FEMAIL(1),
  ANOTHER(2);

  const GenderType(this.value);

  final int value;
}
