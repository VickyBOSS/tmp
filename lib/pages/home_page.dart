import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiki/pages/local_quizes_page.dart';
import 'package:quiki/pollings/pollings_page.dart';
import 'package:quiki/repos/app_repos.dart';
import 'package:quiki/settings/settings_page.dart';
import 'package:quiki/tabs/publisted_quizes_tab.dart';
import 'package:quiki/utils/nav.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var settingsBox = Hive.box('settings');
  var currentTabIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => AppRepos.checkForUpdate(context: context));
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Quiz Hours"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.sd_card),
                tooltip: "My Quizes",
                onPressed: () {
                  Nav.push(context, LocalQuizesPage());
                }),
            PopupMenuButton<String>(
                tooltip: "More...",
                onSelected: (val) {
                  switch (val) {
                    case "Settings":
                      Nav.push(context, SettingsPage());
                  }
                },
                itemBuilder: (_) => ["Settings"]
                    .map((val) => PopupMenuItem<String>(
                          value: val,
                          child: Text(val),
                        ))
                    .toList())
          ],
          bottom: TabBar(
              // indicatorColor: settingsBox.get('darkMode') ?? false
              //     ? Colors.amber
              //     : Colors.white,
              // onTap: (index) {
              //   setState(() {
              //     currentTabIndex = index;
              //   });
              // },
              tabs: [
                Tab(
                  text: "Tests",
                ),
                Tab(text: "Polls")
              ]),
        ),
        body: SafeArea(
          child: TabBarView(children: [PublishedQuizesTab(), PollingsPage()]),
        ),
      ),
    );
  }
}
