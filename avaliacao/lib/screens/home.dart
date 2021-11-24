import 'package:avaliacao/screens/cliente.dart';
import 'package:avaliacao/screens/editarCliente.dart';
import 'package:flutter/material.dart';
import 'cliente_api.dart';
import 'login.dart';
import 'inicial.dart';
class Home extends StatelessWidget {
  //const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Clientes", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () {
              // Navigator.of(context).pushReplacement nao exibe o backbutton
              // Navigator.of(context).push exibe o backbutton
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //builder: (context) => Login()
                  builder: (context) => Inicial()
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    Future<List<Cliente>> clientes = ClienteApi.getClientes();
    //return _listView(clientes);
    return FutureBuilder(
      future: clientes,
      builder: (context, snapshot){
        //print(snapshot.data.toString());
        if(snapshot.hasError){
          print(snapshot.error);
          return Text("Erro ao acessar dados");
        }
        List<Cliente> clientes = snapshot.data;
        return _listView(clientes);
      }
    );
  }

  _listView(clientes) {
    //print("Tamanho: ${clientes.length}");
    return ListView.builder(
        itemCount: clientes!=null ? clientes.length : 0,
        itemBuilder: (context, index) {
          Cliente cliente = clientes[index];
          return Card(
              child: Padding(
              padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: Icon(Icons.account_circle, size: 60.0)),
                Text(" "),
                Text("Id: ${cliente.id.toString()}",
                    style: TextStyle(fontSize: 20)),
                Text("Nome: ${cliente.nome}", style: TextStyle(fontSize: 20)),
                Text("Latitude: ${cliente.latitude}",
                    style: TextStyle(fontSize: 20)),
                Text("Longitude: ${cliente.longitude}",
                    style: TextStyle(fontSize: 20)),
                Text(" "),
                Container(
                  alignment: Alignment.bottomRight,
                  //padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context)=> EditarCliente(index: index, Cliente: cliente)));
                    },
                    child: const Text('Editar', style: TextStyle(fontSize: 20)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    //elevation: 5,
                  ),
                )
                ],
            ),),
          );
        }, //ItemBuilder
    );
  }//Listview
} // Stateless Widget

