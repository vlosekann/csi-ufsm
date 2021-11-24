import 'package:avaliacao/screens/login_api.dart';
import 'package:flutter/material.dart';
import 'package:avaliacao/screens/inicial.dart';
import 'alert.dart';
import 'home.dart';

class Login extends StatefulWidget {
  //const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //final _ctrlUsuario = TextEditingController();
  //final _ctrlSenha = TextEditingController();

  // Key global do formulário, permite acessar próxima página caso os dados estejam validados
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextEditingController usuarioController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  _acessaHome(BuildContext context){
    Navigator.pushReplacement(
        context, MaterialPageRoute(
        builder: (context)=> Home()),
    );
  }

  buildTextFormUsuario() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: "Usuário",
          labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
      style: TextStyle (fontSize: 30.0),
      controller: usuarioController,
      validator: (value) {
        if (value.isEmpty) {
          return "Informe um usuário";
        }
        return null;
      },
    );
  }

  buildTextFormSenha() {
    return TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        style: TextStyle (fontSize: 30.0),
        obscureText: true,
        controller: senhaController,
        validator: (value) {
          if (value.isEmpty) {
            return "Informe uma senha";
          }
          return null;
        });
  }

  buildContainerButton(BuildContext context) {
    return Container(
        height: 50.0,
        child: RaisedButton(
          onPressed: () async {
            if (_formkey.currentState.validate()) {
              FocusScope.of(context).requestFocus(new FocusNode());
              String usuario = usuarioController.text;
              String senha = senhaController.text;

              print("usuario:$usuario - senha: $senha");

              var response = await LoginApi.login(usuario,senha);

              if(response) {
                _acessaHome(context);
              }
              else{
                alert(context,"Login Invalido");
              }

            }
          },
          child: Text("Acessar",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
          color: Colors.blue,
        ));
    //);
  }
  _resetaValores(){
    setState(() {
      usuarioController.text = "";
      senhaController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
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
                buildTextFormUsuario(),
                buildTextFormSenha(),
                buildContainerButton(context)
              ],
            ),
          ),
        )
    );
  } // Widget
}
