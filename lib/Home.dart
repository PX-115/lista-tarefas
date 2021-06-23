import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _taskList = [];
  TextEditingController _controllerAddTask = TextEditingController();

  Future<File> _getFile() async {

    //Acessando diretório
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/data.json');

  }

  _saveTask(){

    String _typedText = _controllerAddTask.text;

    //Criando os arquivos
    Map <String, dynamic> task = Map();
    task['title'] = _typedText;
    task['status'] = false;

    setState(() {
      _taskList.add(task);    
    });

    _saveFile();

    _controllerAddTask.text = '';

  }

  _saveFile() async {

    var file = await _getFile();

    //Salvando os arquivos criados
    String data = json.encode(_taskList);
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

  @override
    void initState() {
      super.initState();
      _readFile().then( (data){
        setState(() {
          _taskList = json.decode(data);       
        });
      });
    }

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
              itemBuilder: (context, index){

                return CheckboxListTile(
                  title: Text(_taskList[index]['title']),
                  value: _taskList[index]['status'], 
                  onChanged: (alterCheckboxValue){
                    setState(() {
                      _taskList[index]['status'] = alterCheckboxValue;                      
                    });

                    _saveFile();

                  }
                );

                /*
                return ListTile(
                  title: Text(_taskList[index]['title']),
                );
                */

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
                  controller: _controllerAddTask,
                  decoration: InputDecoration(
                    labelText: 'Nova tarefa'
                  ),
                  onChanged: (addTaskTextField){

                  },
                ),
                actions: <Widget>[
                  TextButton( 
                    child: Text('Salvar'),
                    onPressed: (){
                      _saveTask();
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