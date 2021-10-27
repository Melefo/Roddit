import 'package:app/controllers/reddit_client.dart';
import 'package:app/roddit_colors.dart';
import 'package:app/widget/nav_bot_bar_widget.dart';
import 'package:app/widget/nav_drawer_widget.dart';
import 'package:app/widget/nav_fab_button_widget.dart';
import 'package:app/widget/nav_top_bar_widget.dart';
import 'package:app/wrapper/reddit_post.dart';
import 'package:app/wrapper/reddit_wrapper.dart';
import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

//view
class Home extends StatefulWidget {
  final String title;

  const Home({Key? key, required this.title}) : super(key: key);

  @override
  StateMVC<Home> createState() => _Home();
}

//state
class _Home extends StateMVC<Home> {
  @override
  final RedditClient controller = RedditClient();
  List<RedditPost> posts = [];

  void emptyPosts() =>
      setState(() => posts.clear());

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        drawer: const NavigationDrawerWidget(),
        appBar: const NavigationTopBarWidget(title: "Home"),
        bottomNavigationBar: const NavigationBotBarWidget(),
        floatingActionButton: NavigationFabButtonWidget(
            buttonIcon: Icons.cached, onPressed: emptyPosts),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: StreamBuilder<List<RedditPost>>(
          stream: RedditWrapper.getFrontHots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              posts = [...posts, ...snapshot.data!];
            }
            return ListView.separated(padding: const EdgeInsets.all(20.0),
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    trailing: posts[index].thumbnail != null ? Image.network(
                        posts[index].thumbnail!, width: 50,
                        height: 50,
                        fit: BoxFit.cover) : null,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: posts[index].author,
                                  style: TextStyle(color: RodditColors.pink,
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(text: " in "),
                              TextSpan(text: posts[index].subreddit,
                                  style: TextStyle(color: RodditColors.blue,
                                      fontWeight: FontWeight.bold))
                            ]
                        ), style: const TextStyle(fontSize: 14)),
                        Text(posts[index].upvotes.toString(),
                            style: const TextStyle(color: Colors.black45))
                      ],
                    ),
                    subtitle: Text(posts[index].description,
                        style: const TextStyle(color: Colors.black)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    child: Divider(indent: 100, endIndent: 20),
                  );
                },
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: posts.length);
          },
        ),
      );
}