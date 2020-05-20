import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Contacts_phone extends StatefulWidget {

  @override

  _Contacts_phoneState createState() => _Contacts_phoneState();
}

class _Contacts_phoneState extends State<Contacts_phone> {
  Iterable<Contact> _contacts;
  void initState(){
    getContacts();
    super.initState();
  }
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
    if (permission!=PermissionStatus.granted )
      {
        final Map<PermissionGroup , PermissionStatus> permissionStatus = await PermissionHandler().requestPermissions([PermissionGroup.contacts]) ;
        return permissionStatus[PermissionGroup.contacts] ?? PermissionStatus.unknown ;
      }
    else {
      return permission ;
    }
  }
  Future <void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:RaisedButton(onPressed: () async{
        final PermissionStatus permissionStatus = await _getPermission();
      if (permissionStatus == PermissionStatus.granted ) {

      }
      else {
        showDialog(context: context , builder: (BuildContext)=> CupertinoAlertDialog(
          title:Text('Permission refusée') ,
        content: Text('Veuillez accepter l''accés aux contacts'),
        actions: <Widget>[
          CupertinoDialogAction(
              child: Text('ok'),
               onPressed: () => Navigator.of(context).pop(),
          )
        ],),);
      }

      },
      child: Container(child:  Text('See Contacts'),),) ,
    );
  }
}
