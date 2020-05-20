class Compte {

  String _userName;
  String _passWord;
  String _email;
  String _token ;
  String _numTel;

  String get token => _token;

  set token(String value) {
    _token = value;
  }


  Compte ({String userName,String passWord,String email , String numTel ,String token})
  {
    _userName=userName;
    _passWord=passWord;
    _email=email;
    _numTel=numTel;
    _token=token;
  }
  void setuserName (String s)
  {
    _userName=s;
  }

  String get numTel => _numTel;

  set numTel(String value) {
    _numTel = value;
  }


  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  @override
  String toString()
  {
    String s;
    s = 'username : ${_userName} phone number : ${_email}';
    return s;
  }
  void AfficherCompte()
  {
    print(this);
  }

  String getUserName()
  {
    return _userName;
  }
  String getPassWord()
  {
    return _passWord;
  }
  String getemail()
  {
    return _email;
  }
  String getEmail()
  {
    return _email;
  }
  String getNumTel()
  {
    return _numTel;
  }

  desactiverCompte ()
  {

  }
  supprimerCompte ()
  {

  }

  String get passWord => _passWord;

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  set passWord(String value) {
    _passWord = value;
  }

}