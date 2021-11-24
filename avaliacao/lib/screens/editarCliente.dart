import 'package:avaliacao/screens/editarCliente_api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'alert.dart';
import 'cliente.dart';
import 'home.dart';

class EditarCliente extends StatefulWidget {
  //const EditarCliente({Key? key}) : super(key: key);
  int index;
  Cliente cliente;
  //GlobalKey<Cliente> cliente = GlobalKey<Cliente>();

  EditarCliente({int index, Cliente Cliente}){
    this.index = index;
    this.cliente = Cliente;

    if(this.index == null){
      this.index = -1;
    }
  }

  @override
  _EditarClienteState createState() => _EditarClienteState(cliente : this.cliente);

}

class _EditarClienteState extends State<EditarCliente> {

  Cliente cliente;
  _EditarClienteState({this.cliente});

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();

  String latitude;
  String longitude;


  getPosicaoAtual() async{
    Position posicao = await Geolocator.getCurrentPosition();
    print(posicao);
    //setState(() async {
      _longitudeController.text = posicao.longitude.toString();
      _latitudeController.text = posicao.latitude.toString();
    //});

  }
  _acessaHome(BuildContext context){
    Navigator.push(
      context, MaterialPageRoute(
        builder: (context)=> Home()),
    );
  }

  buildTextFormId() {
    //Inicializa os controllers com os dados do objeto cliente recebidos de Home:
    //int idCliente = widget.cliente.id;
    _idController.text = widget.cliente.id.toString();
    //int idCliente = cliente.id;

    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Id",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)
          ),
      style: TextStyle (fontSize: 30.0),
      controller: _idController,
      validator: (value) {
        if (value.isEmpty) {
          return "Informe um Id";
        }
        return null;
      },

      enabled: false
    );
  }

  buildTextFormNome() {
    _nomeController.text = widget.cliente.nome;
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Nome",
            labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        style: TextStyle (fontSize: 30.0),
        //obscureText: true,
        controller: _nomeController,
        validator: (value) {
          if (value.isEmpty) {
            return "Informe um nome";
          }
          return null;
        },
        enabled: false
        );
  }
  buildTextFormLatitude() {
    _latitudeController.text = widget.cliente.latitude.toString();
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Latitude",
            labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        style: TextStyle (fontSize: 30.0),
        //obscureText: true,
        controller: _latitudeController,
        validator: (value) {
          if (value.isEmpty) {
            return "Informe uma coordenada";
          }
          return null;
        },
        enabled: false
        );
  }

  buildTextFormLongitude() {
    _longitudeController.text = widget.cliente.longitude.toString();
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Longitude",
            labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        style: TextStyle (fontSize: 30.0),
        //obscureText: true,
        controller: _longitudeController,
        validator: (value) {
          if (value.isEmpty) {
            return "Informe uma coordenada";
          }
          return null;
        },
        enabled: false
        );
  }

  buildContainerSalvarButton(BuildContext context) {
    return Container(
        height: 50.0,
        child: RaisedButton(
          onPressed: () async {
            if (_formkey.currentState.validate()) {

              FocusScope.of(context).requestFocus(new FocusNode());
              String id = _idController.text;
              String nome = _nomeController.text;
              String latitude = _latitudeController.text;
              String longitude = _longitudeController.text;
              // Editar ação botão
              var response = await EditarClienteApi.salvarCliente(id,nome, latitude, longitude);

              if(response) {
                _acessaHome(context);
              }
              else{
                alert(context,"Não salvou");
              }

            }
          },
          child: Text("Salvar",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          color: Colors.blue,
        ));
    //);
  }

  buildContainerLocalizacaoButton(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
        height: 80.0,
        child: RaisedButton(
          onPressed: () async {
            //if (_formkey.currentState.validate()) {
              //calcula();
              FocusScope.of(context).requestFocus(new FocusNode());
              getPosicaoAtual();
          },
          child: Text("Obter Localização",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          color: Colors.blue,
        ));
    //);
  }

  _resetaValores(){
    setState(() {
      //_idController.text = "";
      //_nomeController.text = "";
      _latitudeController.text = "";
      _longitudeController.text = "";
    });
  }




  @override
  Widget build(BuildContext context) {
    //return Container();
    //print(latitude);
    //print(longitude);
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Cliente"),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: () {
              //Reseta Valores
              _resetaValores();
            })
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.account_circle, size: 60.0),
                buildTextFormId(),
                buildTextFormNome(),
                buildTextFormLatitude(),
                buildTextFormLongitude(),
                buildContainerLocalizacaoButton(context),
                buildContainerSalvarButton(context)
              ],
            ),
          ),
        )
    );
  }
}
