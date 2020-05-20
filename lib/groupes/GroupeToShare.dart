import 'package:flutter/foundation.dart';

class GroupeToShare{
  String _name;
  String _code;

  String get name => _name;

  set name(String value) {
    _name = value;
  }
  String get code => _code;

  set code(String value) {
    _code = value;
  }

  GroupeToShare({ String name, String code}){
    _name=name;
    _code=code;
  }
}