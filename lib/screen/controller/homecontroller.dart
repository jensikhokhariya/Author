import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
class Authorcontroller extends GetxController{
  void addData(
      {String? name,
        String? img,
        String? authname,
        String? abauth,
        String? abbook,
        String? rating,
        String? pbyear,
        String? key}) {
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbRef = firebaseDatabase.ref();
    if(key == null){
      dbRef.child("AuthorBook").push().set(
          {"name":name,"img": img, "authname": authname, "abauth": abauth, "abbook": abbook, "rating": rating,"pbyear":pbyear});
    }
    else{
      dbRef.child("AuthorBook").child(key).set(
          {"name":name,"img": img, "authname": authname, "abauth": abauth, "abbook": abbook, "rating": rating,"pbyear":pbyear});
    }
  }

  Stream<DatabaseEvent> readData(){
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbRef = firebaseDatabase.ref();
    return dbRef.child("AuthorBook").onValue;
  }
  Future<void> delete(String key){
    var firebaseDatabase = FirebaseDatabase.instance;
    var dbRef = firebaseDatabase.ref();
    return dbRef.child("AuthorBook").child(key).remove();
  }
}
class BookModel{
  String? name, img, authname, abauth, abbook, rating, pbyear, key;

  BookModel(
      {this.name,
      this.img,
      this.authname,
      this.abauth,
      this.abbook,
      this.rating,
      this.pbyear,
      this.key});
}