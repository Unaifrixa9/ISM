import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practica/registro.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica/mainMenu.dart';

class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFileUser(String user) async {
    final path = await _localPath;
    return File('$path/$user.txt');
  }

  Future<bool> leerPass(String usuario, String pass) async {
    try {
      final file = await _localFileUser(usuario);

      // Leer el archivo
      String contents = await file.readAsString();
      if (contents == pass){
        return true;
      }
      return false;
    } catch (e) {
      // Si encuentras un error, regresamos 0
      return false;
    }
  }
}

class login extends StatefulWidget {
  final Storage storage;
  const login({Key? key, required this.storage}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<login> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Future<void> _comprobarPass() async {
    if (nameController.text != "" && passwordController.text != ""){
        final control = await widget.storage.leerPass(nameController.text, passwordController.text);
        if (control == true){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> MainPage1()),
          );
        }else{
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Contraseña o Usuario incorrecto"),
              );
            },
          );
        }
    }else{
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Uno de los campos no ha sido introducido"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GPSQuest app'),
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
                      'Iniciar sesión',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
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
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                TextButton(
                    onPressed: (){
                      //forgot password screen
                    },
                    child: Text('¿Olvidaste la contraseña?'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:

                    ElevatedButton(
                      onPressed: _comprobarPass,
                      child: const Text('Acceder'),
                    ),

                ),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('¿No tienes cuenta?'),
                        TextButton(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=>Registro(storage: CounterStorage())),
                            );
                          },
                          child: Text('Regístrate'),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}