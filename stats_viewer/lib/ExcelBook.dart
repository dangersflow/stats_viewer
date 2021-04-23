import 'dart:io';
import 'package:excel/excel.dart';

class ExcelBook {
  var file;
  var bytes;
  var excel;
  ExcelBook(this.file) {
    bytes = File(file).readAsBytesSync();
    excel = Excel.decodeBytes(bytes);
  }

  getRangeByName(String range) {}
}
