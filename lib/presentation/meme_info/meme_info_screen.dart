import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zzal_hole/core/component/base_scaffold.dart';

import '../../core/component/zzal_player.dart';

class MemeInfoScreen extends BaseScaffold {
  const MemeInfoScreen({
    super.key,
    required this.memeName,
    required this.memeAuthor,
    required this.memeContent,
    required this.videoUrl,
  });

  final String memeName;
  final String memeAuthor;
  final String memeContent;
  final String videoUrl;

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) => Padding(
    padding: const EdgeInsets.all(30),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(memeName, style: TextStyle(fontSize: 24))),
              Text(memeAuthor, style: TextStyle(fontSize: 16)),
            ],
          ),
          Divider(thickness: 1, color: Color(0xff1F0404)),
          Text(memeContent, style: TextStyle(fontSize: 14)),
          SizedBox(height: 20),
          ZzalPlayer(url: videoUrl),
          SizedBox(height: 20),
        ],
      ),
    ),
  );

  @override
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  @override
  bool get isBackButton => true;

  @override
  String get appBarText => "짤구덩이";

  @override
  // TODO: implement backgroundColor
  Color get backgroundColor => Color(0xffFFF7F2);
}
