import 'Admin.dart';
import 'Arret.dart';
import 'Message.dart';
import 'Messages.dart';
import 'Arret.dart';
import 'Messages.dart';
import 'Personne.dart';
import 'Admin.dart';


class Groupe{


  String _id;
  Object _photo;
  Admin _adm;
  String _code;
  String _destination ;
  List  <Personne> _listMembres= new List<Personne>() ;
  List  <Personne> _listMasters;
  List <String> _lieuxCommuns =new List<String>();
  Map <String, DateTime> _historique= new Map<String,DateTime>(); //<lieu,date>
  List <Personne> _listDemandes= new List<Personne>(); //les personnes qui ont le code doivent etre approuver par tt le groupe
  List<Arret> _listArret= new List<Arret>();
  Map <Personne,Message> _listMessages = new Map<Personne,Message>();
  //* List<Message> _listMessages = new List<Message>() ;
  String _lastMessage ;
  bool _unread = false;
  String _timeLast;
  bool _master;

  String get lastMessage => _lastMessage;

  set lastMessage(String value) {
    _lastMessage = value;
  }

  List<Message> _messages ;

  bool get master => _master;
  set master (bool mas){
    _master=mas;
  }
  Map<Personne, Message> get listMessages => _listMessages;

  set listMessages(Map<Personne, Message> value) {
    _listMessages = value;
  }

  List<Arret> getArret()
  {
    return _listArret;
  }

  List  <Personne> getMembres()
  {
    return _listMembres;
  }

  List  <Personne> getDemandes()
  {
    return _listDemandes;
  }

  Admin get admin => _adm;
  List <Personne> get membres => _listMembres;
  List <Personne> get listMasters => _listMasters;
  Map <String, DateTime> get historique => _historique;
  List <Personne> get demandes => _listDemandes;
  List<Arret> get arrets => _listArret;
  //Map <Personne,Message> get messages => _listMessages;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get code => _code;

  String getDestination()
  {
    return _destination;
  }

  String get destination => _destination;

  set destination(String value) {
    _destination = value;
  }



  void ajouterDemande (Personne p)
  {
    _listDemandes.add(p);
  }

  @override
  String toString()
  {
    String s;
    s = 'id : ${_id} photo : ${_photo} admin : ${_adm} code : ${_code} destination : ${_destination} membres : ${_listMembres}';
    return s;
  }


  String getCode()
  {
    return _code;
  }
  void setCode(String code)
  {
    this._code=code;
  }
  void setAdmin(Admin adm)
  {
    this._adm=adm;
  }
  Admin getAdmin()
  {
    return _adm;
  }
  void setId(String id)
  {
    this._id=id;
  }

  String getId()
  {
    return _id;
  }
  void setPhoto(Object photo)
  {
    this._photo=photo;
  }
  String getlastMsg()
  {
    return _lastMessage;
  }
  void setUnread()
  {
    _unread = false;
  }
  bool getUnread()
  {
    return _unread;
  }
  void setTime(String time)
  {
    _timeLast = time;
  }
  String getTime()
  {
    return _timeLast;
  }

  void ajouterMembre (Personne p)
  {
    _listMembres.add(p);
  }

  bool supprimerMembre (Personne p)
  {
    return _listMembres.remove(p);
  }

  ///*********************************************************************///
  Groupe ({Admin p, String id, String photo, List<Personne> listMembres,List<Personne> listMasters, String code,
    String lastMsg,bool unread, String time,bool master})
  {
    _code=code;
    _listArret = new List<Arret>();
    _listMembres = new List<Personne>();
    _listMasters= new List<Personne>();
    _historique = new Map<String,DateTime>();
    _listDemandes = new List<Personne>();
    _adm = p;
    _id = id;
    _photo = photo;
    _listMembres.add(p);
    _lastMessage = lastMsg;
    _unread = unread;
    _timeLast = time;
    _master=master;
  }

  List<bool> collectAvisA (Personne p) // collecter l'avis des membres sur l'ajout d'une personne provenant de la list des demandes
  {
    var verdict = List(_listMembres.length);
    if (_listDemandes.contains(p))
    {
      for ( var n in _listMembres )
      {
        var bbool = n.Accepter(p);
        verdict.add(bbool);
      }
    }
    else
    {
      print("Cette personne n'a pas demande a joindre ce groupe ");
    }
    return verdict;
  }

  List<bool> collectAvisR (Personne p) // collecter l'avis des membres sur l'ajout d'une personne provenant de la list des demandes
  {
    var verdict = List(_listMembres.length);
    if (_listDemandes.contains(p))
    {
      for ( var n in _listMembres )
      {
        var bbool = n.Refuser(p);
        verdict.add(bbool);
      }
    }
    else
    {
      print("Cette personne n'a pas demande a joindre ce groupe ");
    }
    return verdict;
  }

  void confirmerDemande(Personne p) // il faut l'approbation de tt les membres pour accepter une personne qui a deja entrer le code
  {
    var verdict = new List<bool>();
    verdict = collectAvisA(p);
    if ( verdict.contains(false))
    {
      _listMembres.add(p);
      print('Cette personne va etre ajoutee au groupe');

    }
    else
    {
      print('Cette Personne ne sera pas ajoutee au groupe');
    }
  }
  void visualiserDemandes()
  {
    var it = _listDemandes.iterator;
    while ( it.moveNext())
    {
      var other = it.current;
      other.afficher();
    }
  }

  void supprimer(Personne p) // pour supprimer une personne il faut l'approbation de tt les membres du groupe
  {
    var verdict = new List<bool>();
    verdict = collectAvisR(p);
    if ( verdict.contains(true))
    {
      _listMembres.remove(p);
      print('Cette personne va etre supprimee du groupe ');

    }
    else
    {
      print('Cette Personne ne sera pas supprimee du groupe ');
    }
  }

  void visulaliserListPersonnes()
  {
    var it = _listMembres.iterator;
    while ( it.moveNext())
    {
      var other = it.current;
      other.afficher();
    }
  }

  void archiverDestination () // destination deja parcourues sont stockees dans historique
  {
    var dateDestinationFinie = DateTime.now();
    _historique.putIfAbsent( _destination ,() => dateDestinationFinie);
  }
  void ajouterArret( Arret a)
  {
    _listArret.add(a);
  }

  void alerter ()
  {

  }

  Object get photo => _photo;

  set photo(Object value) {
    _photo = value;
  }

  Admin get adm => _adm;

  set adm(Admin value) {
    _adm = value;
  }



  set code(String value) {
    _code = value;
  }

  List<Personne> get listMembres => _listMembres;

  set listMembres(List<Personne> value) {
    _listMembres = value;
  }
  set listMasters(List<Personne> value) {
    _listMasters = value;
  }


  List<Arret> get listArret => _listArret;

  set listArret(List<Arret> value) {
    _listArret = value;
  }

  List<Personne> get listDemandes => _listDemandes;

  set listDemandes(List<Personne> value) {
    _listDemandes = value;
  }



  set historique(Map<String, DateTime> value) {
    _historique = value;
  }

  List<String> get lieuxCommuns => _lieuxCommuns;

  set lieuxCommuns(List<String> value) {
    _lieuxCommuns = value;
  }

  bool existMaster (String mail) {
    bool exist = false;
    var it = _listMasters.iterator;
    while (it.moveNext()) {
      var other = it.current;
      if (other.compte.email == mail) {
        exist = true;
      }
    }
    return exist;
  }

  bool existPer (List<Personne> mail) {
    bool exist = false;
    var it = _listMembres.iterator;
    while (it.moveNext() && (exist==false)) {
      var other = it.current;
      var itt = mail.iterator;
      while (itt.moveNext() && (exist==false))
      {
        var otherr = itt.current;
        if (other.compte.email == otherr.compte.email) {
          exist = true;
        }
      }

    }
    return exist;
  }

  bool get unread => _unread;

  set unread(bool value) {
    _unread = value;
  }

  String get timeLast => _timeLast;

  set timeLast(String value) {
    _timeLast = value;
  }

}

