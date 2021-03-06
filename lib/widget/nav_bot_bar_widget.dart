import 'package:app/controllers/reddit_client.dart';
import 'package:app/extensions/subroddit.dart';
import 'package:app/roddit_colors.dart';
import 'package:app/views/home.dart';
import 'package:app/views/profile.dart';
import 'package:app/views/settings.dart';
import 'package:app/views/subreddit.dart';
import 'package:app/widget/info_sheet_widget.dart';
import 'package:draw/draw.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';
import 'nav_filter_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationBotBarWidget extends StatefulWidget {
  final Function(PostType)? callback;
  final Subreddit? sub;

  const NavigationBotBarWidget({Key? key, this.callback, this.sub}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigationBotBarWidget();
}

class _NavigationBotBarWidget extends State<NavigationBotBarWidget> {
  RedditClient client = RedditClient();

  String get currentRoute =>
      ModalRoute
          .of(context)!
          .settings
          .name!;

  bool get contextIsSub => currentRoute == SubredditView.routeName;

  bool get contextIsHome => currentRoute == HomeView.routeName;

  bool get contextIsProfile => currentRoute == ProfileView.routeName;

  bool get contextIsSettings => currentRoute == SettingsView.routeName;

  @override
  Widget build(BuildContext context) =>
      BottomAppBar(
        child: Row(
          children: [
            if (contextIsProfile)
              IconButton(
                  icon: const Icon(MdiIcons.accountOff),
                  color: Colors.white,
                  onPressed: () {
                    client.disconnect();
                    Navigator.pushReplacementNamed(context, HomeView.routeName);
                  }
              ),
            if (contextIsHome || contextIsSub)
              NavigationFilterWidget(callback: widget.callback),
            if (contextIsSub)
              IconButton(icon: const Icon(Icons.info), color: Colors.white,
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        builder: (_) => InfoSheetWidget(sub: widget.sub!),
                        context: context,
                        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25)
                            )
                        )
                    );
                  }),
            const Spacer(),
            if (contextIsSub && client.isConnected && widget.sub!.isSubscribed)
              IconButton(
                  icon: const Icon(MdiIcons.heartOff), color: Colors.white,
                  onPressed: () async {
                    await widget.sub!.unsubscribe();
                    setState(() {
                      widget.sub!.isSubscribed = false;
                    });
                  })
            else
              if (contextIsSub && client.isConnected)
                IconButton(
                    icon: const Icon(Icons.favorite), color: Colors.white,
                    onPressed: () async {
                      await widget.sub!.subscribe();
                      setState(() {
                        widget.sub!.isSubscribed = true;
                      });
                    }),
            if (client.isConnected)
              IconButton(icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    if (!contextIsSettings) {
                      Navigator.pushReplacementNamed(context, SettingsView.routeName);
                    }
                  }),
          ],
        ),
        shape: const CircularNotchedRectangle(),
        color: RodditColors.pink,
      );
}