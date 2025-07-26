import 'package:flutter/material.dart';

abstract class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: useSafeArea
          ? SafeArea(
              child: Stack(
                children: [
                  Row(children: [Text(appBarText)]),
                  buildBody(context),
                  buildBottomNavigationBar(context) ?? SizedBox(),
                ],
              ),
            )
          : Stack(
              children: [
                Row(children: [Text(appBarText)]),
                buildBody(context),
                buildBottomNavigationBar(context) ?? SizedBox(),
              ],
            ),
    );
  }

  @protected
  bool get useSafeArea => true;

  @protected
  String get appBarText => '';

  @protected
  bool get isBackButton => false;

  @protected
  Widget buildBody(BuildContext context);

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;
}
