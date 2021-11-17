import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica/mainMenu.dart';

class CounterStorage{
  Future<String> get _localPath async{
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFileUser (String user) async{
    final path = await _localPath;
    return File('$path/$user.txt');
  }

  Future<File> writeUsuario (String usuario, String Pass) async{
    final file_user = await _localFileUser(usuario);
    print(file_user);
    return file_user.writeAsString('$Pass');
  }

  Future<String> leerPass(String usuario) async {
    try {
      final file = await _localFileUser(usuario);

      // Leer el archivo
      String contents = await file.readAsString();
      print(contents);
      return contents;
    } catch (e) {
      // Si encuentras un error, regresamos 0
      return "Null";
    }
  }
}

class Registro extends StatefulWidget{
  final CounterStorage storage;

  const Registro({Key? key, required this.storage}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<Registro> {
  final usuario = TextEditingController();
  final password = TextEditingController();
  final password_repit = TextEditingController();

  @override
  void _guardarRegistro(){
    if (password.text == password_repit.text){
      widget.storage.writeUsuario(usuario.text, password.text);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> MainPage1()),
      );
    }else{
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Contraseña escrita incorrecta"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Registro'),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'GPSQuest',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Registro',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: TextField(
                  controller: usuario,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de Usuario',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: password_repit,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repetir Contraseña',
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  onPressed: _guardarRegistro,
                  child: const Text('Registrarse'),
                ),
              ),
            ],
          )
      ),
    );
  }
}
