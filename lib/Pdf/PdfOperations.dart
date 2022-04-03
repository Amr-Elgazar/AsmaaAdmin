import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/widgets.dart'as pw;

Future<void> savedAndLaunchFile(List<int> bytes , String fileName) async{
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes , flush: true);
  OpenFile.open('$path/$fileName');
}

