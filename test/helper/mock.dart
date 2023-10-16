import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseAuth>(),
  MockSpec<FirebaseFirestore>(),
  MockSpec<User>(),
  MockSpec<DocumentSnapshot>(),
  MockSpec<DocumentReference>(),
  MockSpec<PhoneAuthCredential>(),
  MockSpec<CollectionReference>(),
  MockSpec<QuerySnapshot>(),
])
void main(List<String> args) {}
