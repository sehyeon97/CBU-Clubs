import 'dart:io';
import 'dart:typed_data';

class Writer {
  String fileName;

  Writer(this.fileName);

  void write(Uint8List content) {
    _writeToFile(content);
  }

  void _writeToFile(Uint8List content) async {
    final file = File(fileName);
    await file.writeAsBytes(content);
  }
}
