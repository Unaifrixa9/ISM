import 'package:flutter/material.dart';
import 'package:practica/login.dart';

void main() => runApp(
  const MaterialApp(
    title: 'Flutter Tutorial',
    home: PaginaInicio(),
  ),
);


class PaginaInicio extends StatelessWidget {
  const PaginaInicio({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Pagina Principal'),
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
                      fontSize: 30
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                      'assets/GPSQuest1.png',
                      scale: 2
                  )
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child:
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>login(storage: Storage())),
                    );
                  },
                  child: const Text('Continuar'),
                ),
              ),
            ],
          )
      ),
    );
  }
}
