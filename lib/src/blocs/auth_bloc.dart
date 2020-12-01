import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:vunh_car/firebase/fire_base_auth.dart';

class AuthBloc {
  // var _firAuth = FirAuth();

  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _loginController = new StreamController();

  Stream get nameController => _nameController.stream;
  Stream get emailController => _emailController.stream;
  Stream get phoneController => _phoneController.stream;
  Stream get passController => _passController.stream;
  Stream get loginController => _loginController.stream;

  bool isValidSignUp(String name, String email, String pass, String phone, ){
    bool required = true;
    if(name == null || name.length == 0){
      _nameController.sink.addError("Nhập tên");
      required = false;
    }else _nameController.sink.add("");
    if(email == null || email.length == 0){
      _emailController.sink.addError("Nhập email");
      required = false;
    }else _emailController.sink.add("");
    if(phone == null || phone.length == 0){
      _phoneController.sink.addError("Nhập sđt");
      required = false;
    }else _phoneController.sink.add("");
    if(pass == null || pass.length < 6){
      _passController.sink.addError("Mật khẩu ít nhất 6 ký tự");
      required = false;
    }else _passController.sink.add("");
    return required;
  }

  bool isValidLogin(String email, String pass){
    bool required = true;
    if(email == null || email.length == 0){
      _emailController.sink.addError("Nhập email");
      required = false;
    }else _emailController.sink.add("");
    if(pass == null || pass.length < 6){
      _passController.sink.addError("Mật khẩu ít nhất 6 ký tự");
      required = false;
    }else _passController.sink.add("");
    return required;
  }

  bool signUp(String email, String password, String name, String phone){
    // _firAuth.signUp(email, password, name, phone, onSuccess);
    Fluttertoast.showToast( msg: "email: " + email + "\npass: " + password + "\nPhone: " + phone,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1
    );
    return true;
  }

  bool signIn(String email, String password){
    bool required = false;
    _loginController.sink.add("");
    if(email.trim().compareTo("vunh") == 0 && password.compareTo("123456") == 0){
      _loginController.sink.add("");
      required = true;
    }else
      _loginController.sink.add("sai MK hoặc TK");
    return required;
  }

  void dispose(){
    _nameController.close();
    _emailController.close();
    _phoneController.close();
    _passController.close();
    _loginController.close();
  }
}