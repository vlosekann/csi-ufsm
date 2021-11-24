import 'dart:convert';
import 'package:http/http.dart' as http;
import 'usuario.dart';

class LoginApi {
  static Future<bool> login (String usuario, String senha) async{
    // tentativa 1
    var url = 'http://200.132.36.170:8080/api/login';
    // tentativa 2
    //var url = Uri.parse('http://200.132.36.170:8080/api/login');
    var header = {"Content-Type" : "application/json"};
    Map params = (
        {
          "usuario": usuario,
          "senha": senha
        }
    );

    var _body = json.encode(params);
    print("json enviado: $_body");
    // documentação dart
    //var response = await http.post(url, body: {'name': 'doodle', 'color': 'blue'});

    //Minha tentativa
    var response = await http.post(url, headers: header, body: _body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //Map mapResponse = json.decode(response.body);

    String mensagem = response.body;
    bool autenticado = false;
    if(mensagem =="true")
      autenticado = true;
    //print("Mensagem em formato String: $mensagem");
    //final usuario = Usuario(autenticado);
    return autenticado;
    //return usuario;
  }
}