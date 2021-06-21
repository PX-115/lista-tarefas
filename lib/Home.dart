import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _tasks = [];

  void _loadListItems(){

    _tasks = [];

    for (int i=0; i<=2;i++){
      Map<String, dynamic> item = Map();
      item['title'] = 'Nova tarefa';

      _tasks.add(item);
    }

  }

  @override
  Widget build(BuildContext context) {

    _loadListItems();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        backgroundColor: Colors.purple,
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(_tasks[index]['title']),
                );
              },
            ),
          )
        ],
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
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Adicionar tarefa'),
                content: TextField(
                  decoration: InputDecoration(
                    labelText: 'Digite sua'
                  ),
                  onChanged: (addTaskTextField){

                  },
                ),
                actions: <Widget>[
                  TextButton( 
                    child: Text('Salvar'),
                    onPressed: (){
                      // Função: WIP
                      Navigator.pop(context);
                    },
                  ),

                  TextButton(
                    child: Text('Cancelar'),
                    onPressed: () => Navigator.pop(context),
                  ),

                ],
              );
            }
          );
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