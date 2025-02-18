import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter_ecommerce_app/constants.dart';
import 'package:flutter_ecommerce_app/data/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  var client = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      await client.auth.signInWithPassword(
        password: password,
        email: email,
      );
      await fetchUserData();
      emit(AuthSucess());
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    emit(AuthLoading());

    try {
      await client.auth.signUp(
        password: password,
        email: email,
      );

      await addUserData(
        name: name,
        email: email,
      );

      await fetchUserData();
      emit(AuthSucess());
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(
        AuthFailure(e.toString()),
      );
    }
  }

  GoogleSignInAccount? googleUser;

  Future<AuthResponse> nativeGoogleSignIn() async {
    emit(AuthLoading());

    const webClientId = baseWebClientId;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return AuthResponse();
    }
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(
        AuthFailure('Google sign-in failed'),
      );
      return AuthResponse();
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    await addUserData(name: googleUser!.displayName!, email: googleUser!.email);
    await fetchUserData();
    emit(AuthSucess());
    return response;
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await client.auth.signOut();
      emit(AuthSucess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(AuthSucess());
    } catch (e) {
      log(e.toString());
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> addUserData(
      {required String name, required String email}) async {
    emit(UserDataLoading());
    try {
      await client.from('users').upsert(
        {
          'user_id': client.auth.currentUser!.id,
          'name': name,
          'email': email,
        },
      );
      emit(UserDataSucess());
    } catch (e) {
      log(e.toString());
      emit(UserDataFailure(e.toString()));
    }
  }

  UserDataModel? userDataModel;

  Future<void> fetchUserData() async {
    emit(FetchUserDataLoading());
    try {
      final data = await client.from('users').select().eq(
            'user_id',
            client.auth.currentUser!.id,
          );
      userDataModel = UserDataModel(
          userId: data[0]['user_id'],
          name: data[0]['name'],
          email: data[0]['email']);
      log(data.toString());
      emit(FetchUserDataSucess());
    } catch (e) {
      log(e.toString());
      emit(FetchUserDataFailure(e.toString()));
    }
  }
}
