import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        backgroundColor: Colors.purple,
      ),

      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            
          ],
        )
      ),

      //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
      //floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 0,
        //icon: Icon(Icons.add),
        //label: Text('Adicionar'),
        /*shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(3)
        ),*/
        child: Icon(Icons.add,
          //color: Colors.white,
          size: 30,
        ),
        onPressed: (){

        },
      ),

      /*bottomNavigationBar: BottomAppBar(
        //shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: (){

              }
            ),
          ],
        ),
      ),*/

    );
  }
}