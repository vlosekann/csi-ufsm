import 'dart:convert';
import 'cliente.dart';
import 'package:http/http.dart' as http;
class ClienteApi{

  static Future<List<Cliente>> getClientes() async {

    final clientes = List<Cliente>();
    var url = 'http://200.132.36.170:8080/api/clientes';
    //var header = {"Content-Type" : "application/json; charset=UTF-8; "};
    var response = await http.get(url);
    //var decoded = Utf8Decoder().;
    List listaResponse = json.decode(utf8.decode(response.bodyBytes));

    //clientes.add(Cliente(id: 1, nome: "Tais", latitude: 11, longitude: 12));
    //clientes.add(Cliente(id: 2, nome: "Morga", latitude: 21, longitude: 22));
    //clientes.add(Cliente(id: 3, nome: "Claudia", latitude: 31, longitude: 32));
    //clientes.add(Cliente(id: 4, nome: "Paula", latitude: 41, longitude: 42));

    for(Map map in listaResponse){

      Cliente cliente = Cliente.fromJson(map);
      print(cliente.nome);
      clientes.add(cliente);

    }

    return clientes;

  }

}