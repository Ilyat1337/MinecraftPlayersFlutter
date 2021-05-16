import 'package:flutter/material.dart';
import 'package:minecraft_players/src/models/users_model.dart';
import 'package:minecraft_players/src/pages/details_page.dart';
import 'package:minecraft_players/src/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ListPage extends StatefulWidget {
  const ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UsersModel>(
      builder: (context, userModel, child) {
        return SafeArea(
          child: ListView.separated(
            itemBuilder: (context, index) {
              final user = userModel.users[index];
              return ListTile(
                leading: Image.network(user.avatarUrl),
                title: Text(user.nickname),
                subtitle: Text(
                  '${Utils.translateEnum(context, user.occupation)} ${user.age} '
                      + AppLocalizations.of(context).yearsOld
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => DetailsPage(user: user))
                  );
                },
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: userModel.users.length,
          ),
        );
      },
    );
  }
}
