import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'constants_app.dart';
import 'constants_text_style.dart';

class HelpStatefulWidget extends StatefulWidget {
  const HelpStatefulWidget({super.key});

  @override
  HelpState createState() => HelpState();
}

class HelpState extends State<HelpStatefulWidget> {
  String _appVersion = '';

  Future<String> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getAppVersion(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _appVersion = snapshot.data!;
            });
          });
        }
        return appInfo();
      },
    );
  }

  Widget appInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ConstantsApp.appName,
            style: ConstantsTextStyle.title,
          ),
          Text(
            _appVersion,
            style: ConstantsTextStyle.contents,
          ),
        ],
      ),
    );
  }
}
