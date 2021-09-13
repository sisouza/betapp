class Iten {
  String title;
  bool done;

  Iten({this.title, this.done});

  //converter o objeto de string pra json
  Iten.fromJson(Map<String, dynamic> json) {
    //pegando as props de dentro do json e passando pro que esta acima
    title = json['title'];
    done = json['done'];
  }

  //dps de converter pra json volta para o formato map string que pois é o formato original
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['done'] = this.done;
    return data;
  }
}
