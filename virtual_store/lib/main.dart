import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async{
  runApp(MyApp());

  //.add -> id unico no firebase
  //Firestore.instance.collection('pedidos').add({"preco": 199.99,"user": "Thiago"});

  //.document -> cria um documento de nome estipulado, setdata num mesmo documento nao insere um novo igual, mas sim atualiza o existente.
  //Firestore.instance.collection('pedidos').document('#000001').setData({"preco": 349.99,"user": "ThiagoDantas"});
  
  //updadedata irá somente atualizar o campo q foi alterado. 
  //Firestore.instance.collection('pedidos').document('#000001').updateData({"user": "Thiago Dantas2"});

  //buscando um documento
  //DocumentSnapshot ds = await Firestore.instance.collection('pedidos').document('#000001').get();
  //print(ds.data);
  //print(ds.data['user']);

  //.snapshots().listen -> vai observar a base do firebase, qnd tiver algum dado sendo alterado, e chamada a ação do listen.
  //Firestore.instance.collection('pedidos').document('#000001').snapshots().listen((event) { 
  //  print(event.data);
  //});

  //pegar todos os documentos de uma coleçao
  //QuerySnapshot qs = await Firestore.instance.collection('pedidos').getDocuments();
  //for(DocumentSnapshot document in qs.documents){
  //  print(document.data);
  //}

  //Observar mudança numa coleçao e chamar a ação codificada no listen
  Firestore.instance.collection('pedidos').snapshots().listen((snapshot) { 
    for(DocumentSnapshot document in snapshot.documents){
      print(document.data);
    }
  });
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {

    setState(() {      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
