import 'dart:convert';
import 'package:http/http.dart' as http;

class EditarClienteApi {
  static Future<bool> salvarCliente (String id, String nome, String latitude, String longitude) async{
    // tentativa 1
    var url = 'http://200.132.36.170:8080/api/salvar';
    var header = {"Content-Type" : "application/json"};

    var _latitude = double.parse(latitude);
    var _longitude = double.parse(longitude);

    Map params = (
        {
          "id": id,
          "nome": nome,
          "latitude": latitude,
          "longitude": longitude
        }
    );

    var _body = json.encode(params);
    print("json enviado: $_body");

    //Minha tentativa
    var response = await http.post(url, headers: header, body: _body);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    String mensagem = response.body;
    bool autenticado = false;
    if(mensagem =="true")
      autenticado = true;

    return autenticado;

  }
}