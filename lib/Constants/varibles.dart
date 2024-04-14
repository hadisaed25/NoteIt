import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// text style of the title in app bar
const TextStyle titleBartextStyle =
    TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
// date time of the notes
String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
// done