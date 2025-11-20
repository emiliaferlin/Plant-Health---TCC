import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plant_health/src/models/voce_sabia_model.dart';

class VoceSabiaDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> add(VoceSabiaModel voceSabiaModel) async {
    try {
      await _firestore.collection("vocesabia").add(voceSabiaModel.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> update(VoceSabiaModel voceSabiaModel) async {
    try {
      final snapshot = _firestore
          .collection("vocesabia")
          .doc(voceSabiaModel.id);
      await snapshot.update(voceSabiaModel.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> delete(String id) async {
    try {
      final snapshot = _firestore.collection("vocesabia").doc(id);
      await snapshot.delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<VoceSabiaModel>?> getList() async {
    List<VoceSabiaModel> lista = [];
    try {
      final snapshot = await _firestore.collection("vocesabia").get();
      for (var doc in snapshot.docs) {
        print(doc.toString());
        lista.add(VoceSabiaModel.fromMap(doc.data(), doc.id));
      }
      return lista;
    } catch (e) {
      print(e.toString());
      return lista;
    }
  }
}
