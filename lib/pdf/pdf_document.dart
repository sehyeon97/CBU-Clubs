import 'package:archive/archive.dart';
import 'package:flutter/services.dart';

class PDFDocument {
  static const int controlCharRange = 31;
  Uint8List fileData = Uint8List(1024);

  Future<void> load(String fileName) async {
    try {
      fileData =
          (await rootBundle.load('lib/pdf/schedule.pdf')).buffer.asUint8List();
    } on Exception catch (_) {
      print("path not found");
    }
  }

  List<Uint8List> getAllDecompressedStreams() {
    List<Uint8List> list = [];

    List<int> objOffsets = _getAllObjOffsets();
    for (int offset in objOffsets) {
      List<Object> data = _getStreamAt(offset);

      Uint8List stream = data[0] as Uint8List;
      int length = data[1] as int;

      if (length > 0) {
        Uint8List decompressedStream = _decompress(stream);
        list.add(_removeControlChars(decompressedStream));
      }
    }

    return list;
  }

  List<Object> _getStreamAt(int offset) {
    int length = 0;
    int x = 0;
    bool lengthFound = false;

    for (int i = offset; i < fileData.length; i++) {
      final b = fileData[i];

      if (b == 47) {
        while ("/Length".contains(String.fromCharCode(fileData[++i]))) {
          continue;
        }

        if (fileData[i] == 32) {
          i += 1;

          while (48 <= fileData[i] && fileData[i] <= 57) {
            length *= 10;
            length += int.parse(String.fromCharCode(fileData[i++]));
          }

          List<String> startOfStreamData = _getLineAndNextOffset(i);
          x = int.parse(startOfStreamData[1]);
          lengthFound = true;
        }
      }

      if (b == 101) {
        String line = _getLineAndNextOffset(i)[0];

        if (line == "endobj") {
          length = 0;
          lengthFound = true;
        }
      }

      if (lengthFound) {
        break;
      }
    }

    Uint8List output = Uint8List(length);
    int index = 0;
    for (int i = x; i < x + length; i++) {
      output[index++] = fileData[i];
    }

    return [output, length];
  }

  List<int> _getAllObjOffsets() {
    List<int> offsets = [];

    bool isZero = true;
    String s = "";
    List<String> results = _getLineAndNextOffset(_getOffsetToXRefTable());

    while (!results[0].contains("trailer")) {
      String result = results[0];
      if (result[result.length - 2] == 'n') {
        for (int i = 0; i < result.length; i++) {
          String letter = result[i];
          if (letter == ' ') {
            break;
          }

          if (isZero && letter != '0') {
            isZero = false;
          }

          if (!isZero) {
            s += letter;
          }
        }

        offsets.add(int.parse(s));
        s = "";
      }

      results = _getLineAndNextOffset(int.parse(results[1]));
      isZero = true;
    }

    return offsets;
  }

  Uint8List _decompress(Uint8List compressed) {
    const zLibDecoder = ZLibDecoder();
    final decompressedData = zLibDecoder.decodeBytes(compressed);
    return decompressedData;
  }

  int _getOffsetToXRefTable() {
    int offset = 0;
    int index = fileData.length - 8;

    while (fileData[index] != 10) {
      offset *= 10;
      offset += fileData[index];
      index -= 1;
    }

    int reversedOffset = 0;
    while (offset != 0) {
      int digit = offset % 10;
      reversedOffset = reversedOffset * 10 + digit;
      offset = offset ~/ 10;
    }

    return reversedOffset;
  }

  Uint8List _removeControlChars(Uint8List decompressedData) {
    Uint8List bytes = Uint8List(1024);

    for (var value in decompressedData) {
      if ((value == 10 || value > controlCharRange) && value != 127) {
        bytes.add(value);
      }
    }

    Uint8List output = Uint8List(bytes.length);
    for (var value in bytes) {
      output.add(value);
    }

    return output;
  }

  List<String> _getLineAndNextOffset(int offset) {
    String s = "";

    while (offset < fileData.length && fileData[offset] != 10) {
      s += String.fromCharCode(fileData[offset++]);
    }

    return [s, '$offset'];
  }
}
