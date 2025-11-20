class VoceSabiaModel {
  String id;
  String titulo;
  String descricao;
  DateTime timestamp;

  VoceSabiaModel({
    required this.descricao,
    required this.id,
    required this.timestamp,
    required this.titulo,
  });

  Map<String, dynamic> toMap() {
    return {
      "titulo": titulo,
      "descricao": descricao,
      "timestamp": timestamp.toIso8601String(),
    };
  }

  factory VoceSabiaModel.fromMap(Map<String, dynamic> map, String id) {
    return VoceSabiaModel(
      id: id,
      titulo: map["titulo"],
      descricao: map["titulo"],
      timestamp: DateTime.parse(map["timestamp"].toString()),
    );
  }
}
