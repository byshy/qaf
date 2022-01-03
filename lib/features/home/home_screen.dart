import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qaf/features/Auth/auth_provider.dart';
import 'package:qaf/utils_and_services/app_translations/app_translations.dart';

import '../../di.dart';
import 'home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('appBG'),
          fit: BoxFit.fill,
        ),
      ),
      child: Consumer<HomeProvider>(
        builder: (_, instance, child) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              toolbarHeight: 48,
              title: Text(
                AppTranslations.of(context: context)!.text('home'),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () => sl<AuthProvider>().logOut(),
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
            body: Container(),
          );
        },
      ),
    );
  }
}
