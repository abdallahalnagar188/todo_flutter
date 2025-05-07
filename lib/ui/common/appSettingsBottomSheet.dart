import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';

class AppSettingsBottomSheet extends StatelessWidget {
  const AppSettingsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currentLang = languageProvider.currentLocale;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                if (currentLang != 'en') {
                  languageProvider.setLanguage('en');
                }
              },
              child: getItem(context, "English", currentLang == 'en'),
            ),
            const Divider(height: 26),
            InkWell(
              onTap: () {
                if (currentLang != 'ar') {
                  languageProvider.setLanguage('ar');
                }
              },
              child: getItem(context, "العربية", currentLang == 'ar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget getItem(BuildContext context, String text, bool selected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: selected ? Colors.blue : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
          ),
        ),
        if (selected) const Icon(Icons.check_rounded),
      ],
    );
  }
}
