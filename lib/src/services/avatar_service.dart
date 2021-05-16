import 'dart:convert';
import 'package:http/http.dart' as http;

class AvatarService {
  static const _defaultAvatarUuid = 'c06f89064c8a49119c29ea1dbd1aab82';

  Future<String> getAvatarUrlForNickname(String nickname) async {
    final requestUrl =
        Uri.parse('https://api.mojang.com/users/profiles/minecraft/$nickname');

    try {
      final response = await http.get(requestUrl);
      final id = jsonDecode(response.body)['id'];
      if (id != null) {
        return _getAvatarUrl(id);
      }
    } catch (_) {}

    return getDefaultAvatarUrl();
  }

  String _getAvatarUrl(String uuid) {
    return 'https://crafatar.com/avatars/$uuid?size=150&overlay';
  }

  String getDefaultAvatarUrl() {
    return _getAvatarUrl(_defaultAvatarUuid);
  }
}
