import 'package:flutter/material.dart';

class ContentInfoBar extends StatelessWidget {
  final String username;
  final String memeName;
  final bool isLike;
  final VoidCallback onLikeToggle;
  final VoidCallback onClickHole;

  const ContentInfoBar({
    super.key,
    required this.username,
    required this.memeName,
    required this.isLike,
    required this.onLikeToggle,
    required this.onClickHole,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    memeName,
                    style: TextStyle(fontSize: 24, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    username,
                    style: TextStyle(fontSize: 10, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(),
                  SizedBox(),

                  GestureDetector(
                    onTap: onClickHole,
                    child: Container(
                      width: 120,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff684C48),
                        borderRadius: BorderRadius.circular(500),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 3,
                        children: [
                          Text(
                            '구덩이 보기',
                            style: TextStyle(
                              color: Color(0xffF4E1D4),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Color(0xffF4E1D4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onLikeToggle,
              icon: Icon(isLike ? Icons.favorite : Icons.favorite_border),
              iconSize: 37,
              color: isLike ? Colors.red : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
