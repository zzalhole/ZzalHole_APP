import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateNotifierProvider<CurrentIndexNotifier, int>((
  ref,
) {
  return CurrentIndexNotifier();
});

class CurrentIndexNotifier extends StateNotifier<int> {
  CurrentIndexNotifier() : super(0);

  void setCurrentIndex(int index) => state = index;
}

class BaseBottomNavigationBar extends ConsumerWidget {
  const BaseBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final notifier = ref.read(currentIndexProvider.notifier);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 21),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Color(0xff684C48),
          borderRadius: BorderRadius.circular(38),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home,
              label: "홈",
              index: 0,
              currentIndex: currentIndex,
              onTap: () => notifier.setCurrentIndex(0),
            ),
            _NavItem(
              icon: Icons.leaderboard,
              label: "랭킹",
              index: 1,
              currentIndex: currentIndex,
              onTap: () => notifier.setCurrentIndex(1),
            ),
            _NavItem(
              icon: Icons.square,
              label: "구덩이생성",
              index: 2,
              currentIndex: currentIndex,
              onTap: () => notifier.setCurrentIndex(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    final color = isSelected
        ? Color(0xffF4E1D4)
        : Color(0xffF4E1D4).withOpacity(0.5);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            child: Icon(icon, size: isSelected ? 26 : 22, color: color),
          ),
          AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 200),
            style: TextStyle(fontSize: isSelected ? 13 : 11, color: color),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
