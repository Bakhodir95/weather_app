import 'package:easy_localization/easy_localization.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_bloc.dart';
import 'package:exchange_app/src/blocs/exchange/exchange_event.dart';
import 'package:exchange_app/src/blocs/theme/theme_block.dart';
import 'package:exchange_app/src/blocs/theme/theme_event.dart';
import 'package:exchange_app/src/blocs/theme/theme_state.dart';
import 'package:exchange_app/src/extentions/mediaquery.dart';
import 'package:exchange_app/src/ui/screens/about_app_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreenAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius:
                      context.screenWidth / 10, // Responsive size for avatar
                  backgroundImage: const AssetImage('assets/images/splash.png'),
                ),
                SizedBox(
                  height: context.screenHeight / 100,
                ),
                Text(
                  context.tr("settings"),
                  style: TextStyle(
                    fontSize: context.responsiveFontSize(24),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              context.tr("languages"),
              style: TextStyle(
                  fontSize:
                      context.responsiveFontSize(18)), // Responsive font size
            ),
            leading: const Icon(
              Icons.language,
              color: Color.fromARGB(255, 53, 175, 57),
            ),
            trailing: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),
              dropdownColor: const Color.fromARGB(255, 84, 245, 89),
              value: context.locale.languageCode,
              items: const [
                DropdownMenuItem(
                  value: "uz",
                  child: Text("Uz"),
                ),
                DropdownMenuItem(
                  value: "en",
                  child: Text("En"),
                ),
                DropdownMenuItem(
                  value: "ru",
                  child: Text("Ru"),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  context.setLocale(Locale(value));
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.mode_night_outlined,
              color: Colors.amber,
            ),
            title: Text(
              context.tr("night_mode"),
              style: TextStyle(
                  fontSize:
                      context.responsiveFontSize(18)), // Responsive font size
            ),
            trailing: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                final isDarkMode =
                    (state as ThemeInitial).themeMode == ThemeMode.dark;
                return Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    context
                        .read<ThemeBloc>()
                        .add(ToggleTheme(isDarkMode: value));
                  },
                );
              },
            ),
          ),
          ListTile(
            onTap: () async {
              context.read<ExchangeRateBloc>().add(LaunchTelegram());
            },
            leading: const Icon(
              Icons.telegram,
              color: Colors.blue,
            ),
            title: Text(
              "complains_and_suggestions".tr(),
              style: TextStyle(
                  fontSize:
                      context.responsiveFontSize(18)), // Responsive font size
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            onTap: () {
              context
                  .read<ExchangeRateBloc>()
                  .add(CallNumber(callNumber: "+998900144173"));
            },
            leading: const Icon(
              Icons.phone,
              color: Colors.blue,
            ),
            title: Text(
              "call_us".tr(),
              style: TextStyle(
                  fontSize:
                      context.responsiveFontSize(18)), 
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.share),
            title: Text(
              "share_with_friends".tr(),
              style: TextStyle(
                  fontSize:
                      context.responsiveFontSize(18)), 
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppScreen()),
              );
            },
            leading: const Icon(
              Icons.info_outline,
              color: Colors.yellow,
            ),
            title: Text(
              "about_the_app".tr(),
              style: TextStyle(
                  fontSize:
                      context.responsiveFontSize(18)),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      ),
    );
  }
}
