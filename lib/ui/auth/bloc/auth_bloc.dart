import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fruitshopweb/data/model/request/auth_request.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data/repository/repository.dart';

class AuthBloc  {
  final _repo = Repository();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();


  final _showProgressSubject = BehaviorSubject<bool>();
  Stream<bool> get progressStatusStream => _showProgressSubject.stream;
  Function(bool) get showProgressBar => _showProgressSubject.sink.add;

  final _authSubject = PublishSubject<String>();
  Stream<dynamic> get authStream => _authSubject.stream;


  signUp() async {
    String _email = emailController.text;
    String _password = passwordController.text;
    String _confirmPassword = confirmPasswordController.text;

    if (_email.isEmpty ||
        !RegExp(r'\S+@\S+\.\S+').hasMatch(_email)) {
      _authSubject.sink.addError("Please enter a valid email");
      return;
    }

    if (_password == '' || _password.isEmpty) {
      _authSubject.sink.addError("Please enter password");
    }
    if (_password != _confirmPassword) {
      _authSubject.sink.addError("Passwords do not match");
      return;
    }

    final request = AuthRequest(email: _email, password: _password);

    _showProgressSubject.sink.add(true);
    _repo.register(request).then((response) async {
      _showProgressSubject.sink.add(false);
      _authSubject.sink.add("Registration is successful");

    }, onError: (e) {
      _authSubject.sink.addError(e);
      _showProgressSubject.sink.add(false);
    });
  }

  login() async {
    String _email = emailController.text;
    String _password = passwordController.text;

    if (!_email.contains("@")) {
      _authSubject.sink.addError("Please input a valid email");
      return;
    }
    if (_password.isEmpty || _password.length < 5) {
      _authSubject.sink.addError("Password must be at least 6 characters");
      return;
    }

    final request = AuthRequest(email: _email, password: _password);

    _showProgressSubject.sink.add(true);
    _repo.login(request).then((response) async {
      _showProgressSubject.sink.add(false);
      _authSubject.sink.add("Login is successful");
    }, onError: (e) {
      _authSubject.sink.addError(e);
      _showProgressSubject.sink.add(false);
    });
  }



  void dispose() async {
    _showProgressSubject.drain();
    await _showProgressSubject.close();
    _authSubject.drain();
    await _authSubject.close();
  }
}
