import 'dart:io';

class MapPrinter {

  late String indentation;

  MapPrinter([String indentation = "  "]){
    this.indentation = indentation;
  }

  printMap(Map map) {
    _printMap(1, map);
  }

  _printMap(int indentationLevel, Map map) {
    // start map
    print(indentation * (indentationLevel - 1) + "{");

    map.forEach((key, value) {

      stdout.write(indentation * (indentationLevel - 1) + key + " : ");

      if (value is Map) {
        _printMap(indentationLevel + 1, value);
      }
      else {
        print(map[key].toString());
      }
    });

    print(indentation * (indentationLevel - 1) + "}");
  }
}
