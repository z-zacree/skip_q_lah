import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skip_q_lah/models/constants.dart';
import 'package:skip_q_lah/models/firestore/collections/news.dart';
import 'package:skip_q_lah/models/firestore/main.dart';
import 'package:skip_q_lah/screens/main/profile/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withAlpha(50), width: 0.5),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    splashRadius: 24,
                    iconSize: 20,
                    icon: const FaIcon(FontAwesomeIcons.bars),
                    onPressed: () {},
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withAlpha(50), width: 0.5),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    splashRadius: 24,
                    iconSize: 20,
                    icon: const FaIcon(FontAwesomeIcons.userLarge),
                    onPressed: () => showCustomModalBottomSheet(
                      expand: true,
                      context: context,
                      builder: (context) => const ProfilePage(),
                      containerWidget: (
                        BuildContext context,
                        Animation<double> animation,
                        Widget child,
                      ) {
                        return SafeArea(
                          minimum: const EdgeInsets.only(top: 90),
                          child: Material(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            color: Theme.of(context).backgroundColor,
                            child: child,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: StreamBuilder<QuerySnapshot<JsonResponse>>(
              stream: FirestoreService().getNews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  List<QueryDocumentSnapshot<JsonResponse>> qShotList =
                      snapshot.data!.docs;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      News news = News.fromFire(qShotList[index].data());
                      return NewsCard(news: news);
                    },
                    itemCount: qShotList.length,
                  );
                }
                return SpinKitDualRing(
                  color: Theme.of(context).primaryColorDark,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({Key? key, required this.news}) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).primaryColorLight,
      ),
      child: Text(
        news.title,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
    );
  }
}
