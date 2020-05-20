import 'Groupe.dart';
import 'Personne.dart';

class Favoris{
  DateTime _dateTime;
  String _name;
  String _adresse;

  Favoris(this._name, this._adresse);

  @override
  String toString() {
    return 'Favoris{_dateTime: $_dateTime, _name: $_name, _adresse: $_adresse}';
  }

  String get adresse => _adresse;

  set adresse(String value) {
    _adresse = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  DateTime get dateTime => _dateTime;

  set dateTime(DateTime value) {
    _dateTime = value;
  }


}