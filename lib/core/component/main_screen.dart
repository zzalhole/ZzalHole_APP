import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zzal_hole/core/component/base_scaffold.dart';
import 'package:zzal_hole/presentation/create/create_screen.dart';
import 'package:zzal_hole/presentation/home/home_screen.dart';
import 'package:zzal_hole/presentation/ranking/ranking_screen.dart';
import 'base_bottom_navigation_bar.dart';

class MainScreen extends BaseScaffold {
  const MainScreen({super.key});

  @override
  Widget buildBody(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    List<Widget> widgets = [HomeScreen(), RankingScreen(), CreateScreen()];
    return widgets[currentIndex];
  }

  @override
  String get appBarText => '짤구덩이';
}
