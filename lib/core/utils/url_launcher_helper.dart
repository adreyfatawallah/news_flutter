import 'package:flutter/material.dart';
import 'package:news/core/utils/ext/context_ext.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  UrlLauncherHelper._();

  static Future<void> openWebPage(
    BuildContext context,
    String urlString,
  ) async {
    final url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        context.showSnackbar(context.getString.msg_url_invalid);
      }
    }
  }
}
