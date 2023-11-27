import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  MockSpec<FirebaseStorage>(),
  MockSpec<User>(),
  MockSpec<DocumentSnapshot>(),
  MockSpec<DocumentReference>(),
  MockSpec<PhoneAuthCredential>(),
  MockSpec<CollectionReference>(),
  MockSpec<QuerySnapshot>(),
  MockSpec<Reference>(),

  /*-------------------> CORE <-------------------*/
  MockSpec<AppSettings>(),

  /*-------------------> Data <-------------------*/
  MockSpec<AuthenticationProvider>(),
  MockSpec<SettingProvider>(),
  MockSpec<UserProvider>(),
  MockSpec<StorageProvider>(),

  /*-------------------> REPOSITORY <-------------------*/
  MockSpec<AuthRepository>(),
  MockSpec<UserRepository>(),
  MockSpec<SettingRepository>(),
  MockSpec<StorageRepository>(),

  /*-------------------> USECASE <-------------------*/
  MockSpec<GetCachedUserUsecase>(),
  MockSpec<GetCurrentIdUsecase>(),
  MockSpec<GetCurrentUserUsecase>(),
  MockSpec<GetUserByIdUsecase>(),
  MockSpec<ResendOtpUsecase>(),
  MockSpec<SaveToDatabaseUsecase>(),
  MockSpec<SignInUsecase>(),
  MockSpec<SignOutUsecase>(),
  MockSpec<VerifyOtpUsecase>(),
  MockSpec<AppSettingsUsecase>(),
  MockSpec<GetLocalThemeModeUsecase>(),
  MockSpec<GetDefaultProfilePicUsecase>(),

  /*-------------------> ENTITY <-------------------*/
  MockSpec<UserEntity>(),
])
void main(List<String> args) {}
