import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:minecraft_players/src/models/logged_user_model.dart';
import 'package:minecraft_players/src/models/user.dart';
import 'package:minecraft_players/src/services/auth_service.dart';
import 'package:minecraft_players/src/services/avatar_service.dart';
import 'package:minecraft_players/src/services/media_service.dart';
import 'package:minecraft_players/src/services/storage_service.dart';
import 'package:minecraft_players/src/utils.dart';
import 'package:minecraft_players/src/widgets/enum_dropdown.dart';
import 'package:minecraft_players/src/widgets/section.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _serverController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final avatarService = GetIt.I.get<AvatarService>();
  String _avatarUrl = GetIt.I.get<AvatarService>().getDefaultAvatarUrl();
  OccupationType _occupation = OccupationType.building;
  MobType _favouriteMob = MobType.creeper;
  PrivilegeType _privilege = PrivilegeType.player;
  bool isSigningUp = false;

  Future<void> _signUp() async {
    try {
      setState(() => isSigningUp = true);

      final authService = GetIt.I.get<AuthService>();
      final userId = await authService.signUpWithEmail(_emailController.text,
          _passwordController.text);

      final mediaService = GetIt.I.get<MediaService>();
      final avatarUrl = await mediaService.uploadAvatar(userId,
          await Utils.fetchImageData(_avatarUrl));

      final user = User(
        userId,
        _emailController.text,
        _passwordController.text,
        _nicknameController.text,
        _occupation,
        _favouriteMob,
        _serverController.text,
        _privilege,
        _nameController.text,
        _countryController.text,
        _cityController.text,
        int.tryParse(_ageController.text) ?? 0,
        avatarUrl
      );
      final storageService = GetIt.I.get<StorageService>();
      await storageService.addUser(user);

      Provider.of<LoggedUserModel>(context, listen: false)
          .setLoggedUserId(userId);
      Navigator.pop(context);
    } catch (e) {
      _handleError(e.toString());
    } finally {
      setState(() => isSigningUp = false);
    }
  }

  void _handleError(String errorMessage) {
    Utils.showOkDialog(AppLocalizations.of(context).error, errorMessage, context);
  }

  void _onNicknameChanged(String nickname) async {
    _avatarUrl = await avatarService.getAvatarUrlForNickname(nickname);
    setState(() { });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    _serverController.dispose();
    _nameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child:Image.network(_avatarUrl, width: 150, height: 150)
              ),
              Divider(thickness: 2, height: 30),
              Section(sectionTitle: AppLocalizations.of(context).credentials, children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).email),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).password),
                ),
              ]),
              Section(sectionTitle: AppLocalizations.of(context).ingame, children: [
                TextField(
                  controller: _nicknameController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).nickname),
                  onSubmitted: _onNicknameChanged,
                ),
                EnumDropdown(value: _occupation, values: OccupationType.values,
                    onChanged: (occupation) {
                    setState(() {
                      _occupation = occupation;
                    });
                }),
                EnumDropdown(value: _favouriteMob, values: MobType.values,
                    onChanged: (mob) {
                      setState(() {
                        _favouriteMob = mob;
                      });
                    }),
              ]),
              Section(sectionTitle: AppLocalizations.of(context).favouriteServer, children: [
                TextField(
                  controller: _serverController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).serverAddress),
                ),
                EnumDropdown(value: _privilege, values: PrivilegeType.values,
                    onChanged: (privilege) {
                      setState(() {
                        _privilege = privilege;
                      });
                    }),
              ]),
              Section(sectionTitle: AppLocalizations.of(context).realWorld, children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).name),
                ),
                TextField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).country),
                ),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).city),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText:
                    AppLocalizations.of(context).age),
                ),
              ]),
              SizedBox(height: 10),
              isSigningUp ?
                CircularProgressIndicator() :
                ElevatedButton(onPressed: _signUp,
                    child: Text(AppLocalizations.of(context).signUp)),
              SizedBox(height: 10),
          ]),
        )
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).signIn),
      ),
    );
  }
}
