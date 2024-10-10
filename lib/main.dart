// main.dart
import 'package:flutter/material.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Barrado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _atividades = [];

  void _addAtividade(
      String tipo, String descricao, String data, String imagem) {
    setState(() {
      _atividades.add({
        'tipo': tipo,
        'descricao': descricao,
        'data': data,
        'imagem': imagem,
      });
    });
  }

  void _editAtividade(
      int index, String tipo, String descricao, String data, String imagem) {
    setState(() {
      _atividades[index] = {
        'tipo': tipo,
        'descricao': descricao,
        'data': data,
        'imagem': imagem,
      };
    });
  }

  void _showFormDialog(BuildContext context) {
    final TextEditingController tipoController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    final TextEditingController dataController = TextEditingController();
    final TextEditingController imagemController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Cadastrar Atividade',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: tipoController,
                    decoration: InputDecoration(
                      labelText: 'Tipo de Tarefa',
                    ),
                  ),
                  TextField(
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                  ),
                  TextField(
                    controller: dataController,
                    decoration: InputDecoration(
                      labelText: 'Data',
                    ),
                  ),
                  TextField(
                    controller: imagemController,
                    decoration: InputDecoration(
                      labelText: 'URL da Imagem',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _addAtividade(
                        tipoController.text,
                        descricaoController.text,
                        dataController.text,
                        imagemController.text,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('Cadastrar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    final TextEditingController tipoController =
        TextEditingController(text: _atividades[index]['tipo']);
    final TextEditingController descricaoController =
        TextEditingController(text: _atividades[index]['descricao']);
    final TextEditingController dataController =
        TextEditingController(text: _atividades[index]['data']);
    final TextEditingController imagemController =
        TextEditingController(text: _atividades[index]['imagem']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Editar Atividade',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  TextField(
                    controller: tipoController,
                    decoration: InputDecoration(
                      labelText: 'Tipo de Tarefa',
                    ),
                  ),
                  TextField(
                    controller: descricaoController,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                    ),
                  ),
                  TextField(
                    controller: dataController,
                    decoration: InputDecoration(
                      labelText: 'Data',
                    ),
                  ),
                  TextField(
                    controller: imagemController,
                    decoration: InputDecoration(
                      labelText: 'URL da Imagem',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _editAtividade(
                        index,
                        tipoController.text,
                        descricaoController.text,
                        dataController.text,
                        imagemController.text,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text('Salvar'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Agenda DS 2024',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Verdana', fontSize: 20.0),
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        itemCount: _atividades.length,
        itemBuilder: (context, index) {
          return Atividades(
            _atividades[index]['tipo']!,
            _atividades[index]['imagem']!,
            () => _showEditDialog(context, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Atividades extends StatelessWidget {
  final String tipo;
  final String imagem_atv;
  final VoidCallback onEdit;

  const Atividades(this.tipo, this.imagem_atv, this.onEdit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Stack(
          children: [
            Container(
              color: Color.fromARGB(255, 115, 211, 214),
              height: 140,
            ),
            Container(
              color: Colors.white,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: Image.network(imagem_atv, fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Text(tipo, overflow: TextOverflow.ellipsis),
                  ),
                  ElevatedButton(
                    onPressed: onEdit,
                    child: Icon(Icons.edit),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
