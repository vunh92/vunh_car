import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'file:///D:/HOC%20TAP/Flutter/Project/vunh_car/vunh_car/lib/src/blocs/auth_bloc.dart';
import 'package:vunh_car/src/dialog/loading_dialog.dart';
import 'package:vunh_car/src/msg_dialog.dart';
import 'package:vunh_car/view/home_page.dart';
import 'package:vunh_car/view/other_functions.dart';
import 'package:vunh_car/view/register_page.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  AuthBloc authBloc = new AuthBloc();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40, ),
              Image.asset('hu_hon_001.PNG',height: 150,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  "Welcom to Vunh Car",
                  style: TextStyle(fontSize: 22, color: Colors.deepPurpleAccent),
                ),
              ),
              Text(
                "Login to continue",
                style: TextStyle(fontSize: 16, color: Colors.deepPurpleAccent),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: StreamBuilder(
                  stream: authBloc.emailController,
                  builder: (context, snapshot) => TextField(
                    controller: _emailController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelText: "Email",
                        prefixIcon: Container(
                          width: 50,
                          child: Icon(Icons.email, color: Colors.deepPurpleAccent,),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => _emailController.clear(),
                          icon: Icon(Icons.clear),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: StreamBuilder(
                  stream: authBloc.passController,
                  builder: (context, snapshot) => TextField(
                    controller: _passController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    obscureText: true,
                    decoration: InputDecoration(
                        errorText: snapshot.hasError ? snapshot.error : null,
                        labelText: "Password",
                        prefixIcon: Container(
                          width: 50,
                          child: Icon(Icons.vpn_key, color: Colors.deepPurpleAccent,),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => _passController.clear(),
                          icon: Icon(Icons.clear),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        )
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: RichText(
                    text: TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Fluttertoast.showToast(
                              msg: "Forgot Password..",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1
                          );
                        },
                      text: "Forgot Password?",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _onLoginClicked,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  color: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6))
                  ),
                ),
              ),
              StreamBuilder(
                stream: authBloc.loginController,
                builder: (context, snapshot) => snapshot.data.toString().length > 0 ? Text(
                  snapshot.data.toString(),
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ): new Container(),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: RichText(text: TextSpan(
                    text: "Other Functions? ",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherFunctions(),));
                      },
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageRegister(),));
                          },
                        text: "Sign up ",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      )
                    ]
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
  _onLoginClicked(){
    var isValid = authBloc.isValidLogin(_emailController.text, _passController.text);
    if(isValid){
      //Login
      //Run time sau 5 giây thực hiện lệnh khác
      LoadingDialog.showLoadingDialog(context, "Loading...");
      Timer(Duration(seconds: 5), (){
        LoadingDialog.hideLoadingDialog(context);
        if(authBloc.signIn(_emailController.text, _passController.text)) {
          Fluttertoast.showToast(
              msg: "Login success..",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        }else{
          MsgDialog.showMsgDialog(context, "Thông Báo", "Sai mật khẩu");
        }
      });
    }
  }

}