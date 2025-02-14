import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

import '../../providers/privacypolicyprovider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.privacypolicy),
        ),
        body: RefreshIndicator(
          onRefresh: () => context.read<PrivacyPolicyProvider>().refresh(),
          child: context.watch<PrivacyPolicyProvider>().isFetching
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Markdown(
                  data: context
                      .watch<PrivacyPolicyProvider>()
                      .privacypolicyContent!,
                  styleSheet: MarkdownStyleSheet(
                    h1: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    h2: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      // color: Colors.green,
                    ),
                    h3: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    listBullet: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    a: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    p: TextStyle(
                      fontSize: 16,
                      // color: Colors.amber,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
