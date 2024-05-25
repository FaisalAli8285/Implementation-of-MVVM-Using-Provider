import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvm/res/components/round_button.dart';
import 'package:provider_mvm/utils/routes/route_name.dart';
import 'package:provider_mvm/utils/utils.dart';
import 'package:provider_mvm/viewmodel/auth_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            focusNode: _emailFocusNode,
            onFieldSubmitted: (value) {
              Utils.fieldFOcusNode(
                  context, _emailFocusNode, _passwordFocusNode);
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              // hintText: "Email",
              labelText: "Email",
              prefixIcon: Icon(Icons.alternate_email),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: _obsecurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obsecurePassword.value,
                  focusNode: _passwordFocusNode,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    // hintText: "Password",
                    suffixIcon: InkWell(
                        onTap: () {
                          _obsecurePassword.value = !_obsecurePassword.value;
                        },
                        child: Icon(_obsecurePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility)),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                );
              }),
          SizedBox(
            height: height * 0.1,
          ),
          RoundButton(
            title: "LogIn",
            loading: authViewModel.loading,
            onPress: () {
              if (_emailController.text.isEmpty) {
                Utils.flushBarErrorMessage("Please Enter Your Email", context);
              } else if (_passwordController.text.isEmpty) {
                print("Please Enter Your Password");
              } else if (_passwordController.text.length < 6) {
                print("Please Enter a Six digit Password");
              } else {
                Map data = {
                  "email": _emailController.text.toString(),
                  "password": _passwordController.text.toString()
                };
                authViewModel.loginApiModel(data, context);
                print("API hit");
              }
            },
          ),
          SizedBox(
            height: height * 0.025,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RoutesName.signup);
            },
            child: Text("Don't Have an account? Sign Up"),
          )
        ],
      ),
    );
  }
}
