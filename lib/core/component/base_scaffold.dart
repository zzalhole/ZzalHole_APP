import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zzal_hole/core/component/base_bottom_navigation_bar.dart';

abstract class BaseScaffold extends ConsumerWidget {
  const BaseScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: useSafeArea
          ? SafeArea(child: _buildBaseBody(context, ref))
          : _buildBaseBody(context, ref),
    );
  }

  Widget _buildBaseBody(BuildContext context, WidgetRef ref) => Stack(
    children: [
      SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: buildBody(context, ref),
      ),
      Positioned(
        top: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: isBackButton
                ? Row(
                    spacing: 8,
                    children: [
                      Icon(Icons.arrow_back_ios, size: 24, color: Colors.black),
                      Text(
                        appBarText,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                : Text(
                    appBarText,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
          ),
        ),
      ),
      Positioned(
        bottom: 24,
        child: Column(
          children: [buildBottomNavigationBar(context) ?? SizedBox()],
        ),
      ),
    ],
  );

  @protected
  Color get backgroundColor => Colors.white;

  @protected
  bool get useSafeArea => false;

  @protected
  String get appBarText;

  @protected
  bool get isBackButton => false;

  @protected
  Widget buildBody(BuildContext context, WidgetRef ref);

  @protected
  Widget? buildBottomNavigationBar(BuildContext context) =>
      BaseBottomNavigationBar();
}
