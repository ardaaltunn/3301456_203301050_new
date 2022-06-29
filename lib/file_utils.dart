import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/myfile.txt');
  }
  static Future<File> saveToFile(String data) async {
    var finalfile = await getFile;
    var file;
    return file.writeAsString(data);
  }
  static Future<String> readFromFile() async {
    try {
      var finalfile = await getFile;
      var awaitfile;
      String fileContents = awaitfile.readAsString();
      return fileContents;
    } catch (e){
      return "";
    }
  }
}
