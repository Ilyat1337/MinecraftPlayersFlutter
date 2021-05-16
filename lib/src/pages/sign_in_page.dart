import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minecraft_players/src/models/logged_user_model.dart';
import 'package:minecraft_players/src/pages/sign_up_page.dart';
import 'package:minecraft_players/src/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      final authService = GetIt.I.get<AuthService>();
      final userId = await authService.signInWithEmail(_emailController.text,
          _passwordController.text);
      Provider.of<LoggedUserModel>(context, listen: false)
          .setLoggedUserId(userId);
    } catch (e) {
      _handleError(e.toString());
    }
  }

  void _handleError(String errorMessage) {
    Utils.showOkDialog(AppLocalizations.of(context).error, errorMessage, context);
  }

  void _signUp() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SignUpPage())
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Form(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context).signIn,
                      style: TextStyle(fontSize: 30)),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context).email),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText:
                      AppLocalizations.of(context).password),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(onPressed: _signIn,
                      child: Text(AppLocalizations.of(context).signIn)),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: _signUp,
                    child: Text(AppLocalizations.of(context).noAccountMsg),
                  ),
                  SizedBox(height: 20),
                  Text('By Trapashko Ilya, 2021')
                ],
              ),
          )
        ),
      ),
    );
  }
}
