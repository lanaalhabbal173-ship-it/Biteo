import 'package:app_links/app_links.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();

  static Uri? resetUri;

  Future<void> init() async {
    // لما التطبيق يفتح من رابط وهو مسكر
    final uri = await _appLinks.getInitialLink();

    if (uri != null) {
      _saveUri(uri);
    }

    // لما التطبيق يكون مفتوح
    _appLinks.uriLinkStream.listen((uri) {
      _saveUri(uri);
    });
  }

  void _saveUri(Uri uri) {
    print("DEEPLINK RECEIVED: $uri");
    print("QUERY : ${uri.query}");
    print("params : ${uri.queryParameters}");

    if (uri.path.contains("reset-password")) {
      resetUri = uri;

      print("EMAIL: ${uri.queryParameters['email']}");

      print("TOKEN: ${uri.queryParameters['token']}");
    }
  }

  static bool get hasResetLink {
    return resetUri != null;
  }

  static void clear() {
    resetUri = null;
  }
}
