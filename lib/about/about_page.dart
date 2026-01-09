import 'package:combat_tracker/custom_icons_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  PackageInfo? packageInfo;

  void setup() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {});
  }

  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 4,
        shadowColor: Theme.of(context).colorScheme.shadow,
        title: const Text("About"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: SvgPicture.asset(
                            'assets/icon/icon.svg',
                            height: 32,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Combat Tracker',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: const Color.fromARGB(255, 229, 229, 229),
                                  ),
                                ),
                                Text(
                                  '© 2026 Jefferey Neuffer',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: const Color.fromARGB(255, 229, 229, 229),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          size: 32,
                          color: Color.fromARGB(255, 127, 127, 127),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'App Version',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: const Color.fromARGB(255, 229, 229, 229),
                                  ),
                                ),
                                Text(
                                  '${packageInfo?.version ?? '-.-.-'} (${packageInfo?.buildNumber ?? ''})',
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: const Color.fromARGB(255, 229, 229, 229),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse('https://j7126.dev/projects/combat-tracker')),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.home_outlined,
                            size: 32,
                            color: Color.fromARGB(255, 127, 127, 127),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Home Page',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                  Text(
                                    'https://jefferey.dev/projects/combat-tracker',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse('https://github.com/j7126/combat-tracker/issues')),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.bug_report,
                            size: 32,
                            color: Color.fromARGB(255, 127, 127, 127),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Report an issue',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                  Text(
                                    'https://github.com/j7126/combat-tracker/issues',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse('https://github.com/j7126/combat-tracker')),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Row(
                        children: [
                          const Icon(
                            CustomIcons.github_circled,
                            size: 32,
                            color: Color.fromARGB(255, 127, 127, 127),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'View on GitHub',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                  Text(
                                    'https://github.com/j7126/combat-tracker',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse('https://github.com/j7126/combat-tracker/blob/main/CREDITS.md')),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.edit_outlined,
                            size: 32,
                            color: Color.fromARGB(255, 127, 127, 127),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Credits',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                  Text(
                                    'https://github.com/j7126/combat-tracker/blob/main/CREDITS.md',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse('https://github.com/j7126/combat-tracker/blob/main/LICENSE.txt')),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.gavel_outlined,
                            size: 32,
                            color: Color.fromARGB(255, 127, 127, 127),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'License',
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                  Text(
                                    'GNU Affero General Public License',
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      color: const Color.fromARGB(255, 229, 229, 229),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Combat Tracker Copyright (C) 2026 Jefferey Neuffer.\nThis program is free software, licensed under GNU AGPL v3 or any later version.",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color.fromARGB(255, 76, 76, 76),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
