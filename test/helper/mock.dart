import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:patungan_id/app/core/core.dart';
import 'package:patungan_id/app/data/data.dart';
import 'package:patungan_id/app/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(),

  /*-------------------> Firebase <-------------------*/
  MockSpec<FirebaseAuth>(),
  MockSpec<FirebaseFirestore>(),
  MockSpec<User>(),
  MockSpec<DocumentSnapshot>(),
  MockSpec<DocumentReference>(),
  MockSpec<PhoneAuthCredential>(),
  MockSpec<CollectionReference>(),
  MockSpec<QuerySnapshot>(),

  /*-------------------> CORE <-------------------*/
  MockSpec<ChangeThemeMode>(),
  /*-------------------> Data <-------------------*/
  MockSpec<AuthProvider>(),
  MockSpec<SettingProvider>(),

  /*-------------------> Repository <-------------------*/
  MockSpec<AuthRepository>(),
  MockSpec<UserRepository>(),
  MockSpec<SettingRepository>(),
])
void main(List<String> args) {}
