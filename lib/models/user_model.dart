import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';


const USER_COLLECTION = "users";

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();


  bool isLoading = false;

@override
  void addListener(listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {

    _processing(true);

    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      this.firebaseUser = user;
      await _saveUserData(userData);

      onSuccess();
      _processing(false);
    }).catchError((e) {
      onFail();
      _processing(false);
    });
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    _processing(true);
    
    await _auth.signInWithEmailAndPassword(email: email, password: pass)
      .then((user) async{
        firebaseUser = user;
        
        await _loadCurrentUser();

        onSuccess();
        _processing(false);
      }).catchError((e){
          onFail();
          _processing(false);
      });
  }

  void signOut() async {

    _processing(true);

    await _auth.signOut();
    firebaseUser = null;
    userData = Map();

    _processing(false);
  }

  void recoverPass() {}

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection(USER_COLLECTION)
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<void> _loadCurrentUser() async {
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();
    
    if(firebaseUser != null){
      if(userData["name"] == null){

        var docUser = await Firestore.instance.collection(USER_COLLECTION).document(firebaseUser.uid).get();
        userData = docUser.data;

      }
    }

    notifyListeners();
  }

  void _processing(bool process) {
    isLoading = process;
    notifyListeners();
  }
}
