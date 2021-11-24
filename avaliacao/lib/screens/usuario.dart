class Usuario {

  String usuario;
  bool autenticado;

  Usuario(bool autenticado) {
    this.autenticado = autenticado;
    //this.usuario = usuario;
  }

  /*  String _autenticado;

  Usuario({String autenticado}) {
    this._autenticado = autenticado;
  }

  String get autenticado => _autenticado;
  set autenticado(String autenticado) => _autenticado = autenticado;

  Usuario.fromJson(Map<String, dynamic> json) {
    _autenticado = json['autenticado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['autenticado'] = this._autenticado;
    return data;
  }
 */
}