import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/languageprovider.dart';
import '../../providers/nav_bar_provider.dart';
import '../../providers/themeprovider.dart';
import '../../utils/utils.dart';
import '../../widget/selectionbuttonwidget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
        ),
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildListtile(
              tiletitle: AppLocalizations.of(context)!.theme,
              iconData: context.watch<ThemeProvider>().themeMode ==
                      ThemeMode.system
                  ? Icons.phonelink_setup_outlined
                  : context.watch<ThemeProvider>().themeMode == ThemeMode.light
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
              onTap: () => Utils(context).showCustomDialog(
                child: _themetileWidget(
                  context: context,
                ),
              ),
            ),
            _buildListtile(
              tiletitle: AppLocalizations.of(context)!.language,
              iconData: Icons.language_outlined,
              onTap: () => Utils(context).showCustomDialog(
                child: _languagetileWidget(),
              ),
            ),
            _buildListtile(
              iconData: LineIcons.code,
              tiletitle: AppLocalizations.of(context)!.credits,
              // onTap: () => _credits(context),
              onTap: () => Utils(context).showCustomDialog(
                child: _creditWidget(context: context),
              ),
            ),
            // _buildListtile(
            //   iconData: LineIcons.envelope,
            //   tiletitle: 'Contact Us',
            //   onTap: () {},
            // ),
            const Spacer(),
            _logo(context: context, size: size),
          ],
        ),
      ),
    );
  }

  _logo({
    required BuildContext context,
    required Size size,
  }) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: size.height * 0.3,
              // color: Theme.of(context).primaryColor,
              child: Image.asset(
                color: Theme.of(context).primaryColor,
                Consts.LOGO,
              ),
            ),
            Positioned(
              // bottom: 20,
              child: Text(
                Consts.APP_NAME,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Text(
          context.read<NavBarProvider>().appVersion,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        // const SizedBox(
        //   height: 10,
        // ),
        // const Text(
        //   'You are using latest version of this application ',
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //       // fontWeight: FontWeight.bold,
        //       ),
        // ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _creditWidget({
    required BuildContext context,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.creditBody,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            // fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // Text(
        //   AppLocalizations.of(context)!.creditdeveloper,
        //   style: const TextStyle(
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // _submittedBy(
        //   context: context,
        //   name: AppLocalizations.of(context)!.creditdevelopername1,
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // _submittedBy(
        //   context: context,
        //   name: AppLocalizations.of(context)!.creditdevelopername2,
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // Text(
        //   AppLocalizations.of(context)!.and,
        //   style: const TextStyle(
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // const SizedBox(
        //   height: 10,
        // ),
        // _submittedBy(
        //   context: context,
        //   name: AppLocalizations.of(context)!.creditdevelopername3,
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }

  // _submittedBy({
  //   required String name,
  //   required BuildContext context,
  // }) {
  //   return Column(
  //     children: [
  //       Text(name),
  //       Text(AppLocalizations.of(context)!.creditdeveloperdepartment),
  //       Text(AppLocalizations.of(context)!.creditdeveloperuniversity),
  //     ],
  //   );
  // }

  _buildListtile({
    required IconData iconData,
    required String tiletitle,
    required Function onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: ListTile(
          title: Text(tiletitle),
          trailing: Icon(iconData),
        ),
      ),
    );
  }

  _themetileWidget({required BuildContext context}) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.selectTheme,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SelectionButtonWidget(
                    buttontitle: AppLocalizations.of(context)!.systemTheme,
                    iconCondition: provider.themeMode == ThemeMode.system,
                    ontap: () {
                      provider.themeMode = ThemeMode.system;
                    },
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    height: 0,
                  ),
                  SelectionButtonWidget(
                    iconCondition: provider.themeMode == ThemeMode.light,
                    buttontitle: AppLocalizations.of(context)!.lightTheme,
                    ontap: () {
                      provider.themeMode = ThemeMode.light;
                    },
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    height: 0,
                  ),
                  SelectionButtonWidget(
                    iconCondition: provider.themeMode == ThemeMode.dark,
                    buttontitle: AppLocalizations.of(context)!.darkTheme,
                    ontap: () {
                      provider.themeMode = ThemeMode.dark;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  _languagetileWidget() {
    return Consumer<LanguageProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SelectionButtonWidget(
                    buttontitle: 'English',
                    iconCondition: provider.languageCode == 'en',
                    ontap: () {
                      provider.languageCode = 'en';
                    },
                  ),
                  Divider(
                    color: Theme.of(context).primaryColor,
                    height: 0,
                  ),
                  SelectionButtonWidget(
                    iconCondition: provider.languageCode == 'bn',
                    buttontitle: 'বাংলা',
                    ontap: () {
                      provider.languageCode = 'bn';
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
