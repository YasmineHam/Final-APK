import 'dart:io';

import 'Compte.dart';
import 'Groupe.dart';
import 'Personne.dart';
class GoTrack 
{
  List<Compte> _compteDesactif;
  List<Compte> _comptes;
  List<Groupe> _groupes; 

  GoTrack ()
  {
    _compteDesactif = new List<Compte>();
    _comptes = new List<Compte>();
    _groupes = new List<Groupe>();

  }

  List<Groupe> getListeGroupes ()
  {
    return _groupes;
  }

  void seConnecter()
  {
    print('Enter your username :');
    var line = stdin.readLineSync();
    print('Enter your passWord :');
    var line2 = stdin.readLineSync();

    Compte cmpt= new Compte(userName:line,passWord: line2);
    if (!_comptes.contains(cmpt)) print('Votre compte n''éxiste pas veuillez réessayer ou vous inscrire, merci' );
    else print('connexion réussie');

  }

  Compte sinscrire()
  {
    print('Enter your username :');
    var line = stdin.readLineSync();
    print('Enter your passWord :');
    var line2 = stdin.readLineSync();
    print('Enter your phone number :');
    var line3 = stdin.readLineSync();
    Personne pr= new Personne(userName:line ,passWord:line2 ,numTel:line3 );
    Compte cmpt = new Compte(userName: line,passWord: line2,email: line3);
    if (!_comptes.contains(cmpt))
      {
        _comptes.add(cmpt);
        print ('inscription réussie');
      }
    else
      {
        print('votre compte existe déjà, veuillez vous connecter');
      }


  }

  void DesactiverCompte (Compte c)
  {
    if (_comptes.contains(c))
    {
      _compteDesactif.add(c);
      _comptes.remove(c);
      print('Le compte ${c} a ete desactive !');
    }
    else 
    {
      print('Le compte que vous voulez desactiver est indisponible');
    }
  }

  void ReactiverCompte ( Compte c)
  {
    if (_compteDesactif.contains(c))
    {
      _compteDesactif.remove(c);
      _comptes.add(c);
      print('Le compte ${c} a ete resactive !');
    }
    else 
    {
      print('Le compte que vous voulez resactiver est indisponible');
    }

  }  
  
  void SupprimerCompte(Compte c)
  {
    if (_comptes.contains(c))
    {
      _comptes.remove(c);
      print('Le compte ${c} a ete supprime !');
    }
    else 
    {
      print('Le compte que vous voulez supprimer est indisponible');
    }
  }
  
  void AjouterCompte (Compte c)
  {
    _comptes.add(c);
  }

  void AjouterGroupe ( Groupe g)
  {
    _groupes.add(g);
  }

  void SupprimerGroupe ( Groupe g, Personne p)
  {
    if ( p == g.getAdmin() )
    {
      _groupes.remove(g);
    }
    else 
    {
      print('Il faut etre admin du groupe pour pouvoir le supprimer');
    }
  }

  void afficherCompte ()
  {
    print(_comptes);
  }

  void afficherGroupe ()
  {
    print(_groupes);
  }
}