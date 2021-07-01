import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _taskList = [];
  Map <String, dynamic> _lastRemovedTask = {};
  TextEditingController _controllerAddTask = TextEditingController();

  Future<File> _getFile() async {

    //Acessando diretório
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');

  }

  _saveTask(){

    final String _typedText = _controllerAddTask.text;

    //Criando os arquivos
    final Map <String, dynamic> task = {};
    task['title'] = _typedText;
    task['status'] = false;

    setState(() {
      _taskList.add(task);    
    });

    _saveFile();

    _controllerAddTask.text = '';

  }

  _saveFile() async {

    final file = await _getFile();

    //Salvando os arquivos criados
    final String data = json.encode(_taskList);
    file.writeAsString(data);

    //print('Caminho:' + directory.path );

  }

  _readFile() async {

    try{

      final file = await _getFile();
      return file.readAsString();

    } catch (error){

      return null;

    }

  }

  Widget _generateList(context, index){

    //final taskListItem = _taskList[index]['title'];

    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      //direction: DismissDirection.endToStart,

      /*onDismissed: (startToEnd){
        print('Assalamu alaikum');
      },*/

      confirmDismiss: (DismissDirection endToStart) async {
        return await showDialog(
          context: context, 
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Confirmar exclusão'),
              content: Text('Deseja realmente excluir este item?'),
              actions: <Widget>[
                TextButton(
                  onPressed: (){

                    _lastRemovedTask = _taskList[index];

                    setState(() {
                      _taskList.removeAt(index);                 
                    });

                    _saveFile();

                    Navigator.pop(context);

                    final snackbar  = SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text('Item removido'),
                      action: SnackBarAction(
                        label: 'Desfazer', 
                        onPressed: (){
                          setState(() {               
                            _taskList.insert(index, _lastRemovedTask);
                          });

                          _saveFile();
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  },
                  child: Text('Sim'),
                ),

                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Não'),
                ),
              ],
            );
          }
        );
      },

      background: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.edit,
              color: Colors.white
            )
          ],
        )
      ),

      secondaryBackground: Container(
        color: Colors.red,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
        ),
      ),

      child: CheckboxListTile(
        title: Text(_taskList[index]['title']),
        value: _taskList[index]['status'], 
          onChanged: (alterCheckboxValue){
            setState(() {
              _taskList[index]['status'] = alterCheckboxValue;                      
            });

            _saveFile();

          /*
            return ListTile(
              title: Text(_taskList[index]['title']),
            );
          */

        }
      )
    );
  }

  @override
    void initState() {
      super.initState();
      _readFile().then( (data){
        setState(() {
          _taskList = json.decode(data);       
        });
      });
    }

//------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        backgroundColor: Colors.purple,
      ),

      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _taskList.length,
              itemBuilder: _generateList
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
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: Text('Adicionar tarefa'),
                content: TextField(
                  controller: _controllerAddTask,
                  decoration: InputDecoration(
                    labelText: 'Nova tarefa'
                  ),
                  onChanged: (addTaskTextField){

                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: (){
                      _saveTask();
                      Navigator.pop(context);
                    }, 
                    child: Text('Salvar'),
                  ),

                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar'),
                  ),

                ],
              );
            }
          );
        },
        //icon: Icon(Icons.add),
        //label: Text('Adicionar'),
        /*shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(3)
        ),*/
        child: Icon(Icons.add,
          //color: Colors.white,
          size: 30,
        ),
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