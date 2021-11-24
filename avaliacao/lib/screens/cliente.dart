// Classe Cliente com coordenadas String
class Cliente {
  int _id;
  String _nome;
  String _latitude;
  String _longitude;

  Cliente({int id, String nome, String latitude, String longitude}) {
    this._id = id;
    this._nome = nome;
    this._latitude = latitude;
    this._longitude = longitude;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get latitude => _latitude;
  set latitude(String latitude) => _latitude = latitude;
  String get longitude => _longitude;
  set longitude(String longitude) => _longitude = longitude;

  Cliente.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nome = json['nome'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['nome'] = this._nome;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    return data;
  }
}
