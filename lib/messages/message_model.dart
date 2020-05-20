import '../noyau/Groupe.dart';
import '../noyau/Personne.dart';

 class Message {
   final Personne auteur;
   final String username;
   final String dateEnvoi;
   final String text;
    bool unread;

   Message({
     this.auteur,
     this.username,
     this.dateEnvoi,
     this.text,
     this.unread
   });
   setRead(){
     this.unread = false;
   }
 }
Groupe actifSaly = new Groupe(code: 'Groupe1');
Groupe actifYas = new Groupe(code: 'Groupe2');

final Personne currentUser = Personne (
      userName:"user",passWord:"123456",email:"newUser@gmail.com",
  );
  final Personne salima = new Personne (userName:"Salima",passWord:"123456",email:"new@gmail.com",
  );
  final Personne yasmine = new Personne (userName:"Yasmine",passWord:"123456",email:"yas@gmail.com",
  );
final Personne lina = new Personne (userName:"Lina",passWord:"123456",email:"lina@gmail.com",
);
final Personne sofia = new Personne (userName:"Sofia",passWord:"123456",email:"sofia@gmail.com",
);
final Personne lilya = new Personne (userName:"Lilya",passWord:"123456",email:"lilya@gmail.com",
);
final Personne abir = new Personne (userName:"Abir",passWord:"123456",email:"yas@gmail.com",
);

///Membres du groupe
  List<Personne> membres = [yasmine,salima,lina,sofia,lilya,abir];
  ///Example chat homeScreen
///récuperer la liste des messages du groupe

 List<Message> chats = [
   Message(
     auteur: salima,
     username: 'salima',
     dateEnvoi: '5:20 PM',
     text:'salut',
     unread: true,
   ),
   Message(
     auteur: yasmine,
     username: 'yasmine',
     dateEnvoi: '5:20 PM',
     text:'salut',
     unread: true,
   ),

   Message(
     auteur: currentUser,
     username: 'yasmine',

     dateEnvoi: '5:20 PM',
     text:'coucou al',
     unread: true,
   ),
   Message(
     auteur: lilya,
     username: 'lil',

     dateEnvoi: '5:20 PM',
     text:'salut',
     unread: false,
   ),
   Message(
     auteur: abir,
     username: 'yasmine',

     dateEnvoi: '3:20 PM',
     text:'coucou c\'est abir',
     unread: false,
   ),
   Message(
     auteur: currentUser,
     username: 'yasmine',

     dateEnvoi: '3:20 PM',
     text:'coucou c\'est abir',
     unread: false,
   ),
   Message(
     auteur: abir,
     username: 'yasmine',

     dateEnvoi: '3:20 PM',
     text:'coucou c\'est abir',
     unread: false,
   ),


 ];

