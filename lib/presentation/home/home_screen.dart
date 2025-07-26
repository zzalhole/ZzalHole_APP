import 'package:flutter/material.dart';
import 'package:zzal_hole/core/component/content_info_bar.dart';
import 'package:zzal_hole/core/component/zzal_player.dart';
import 'package:zzal_hole/data/models/zzal_list_model.dart';
import 'package:zzal_hole/data/repository/zzall_repository.dart';
import 'package:zzal_hole/presentation/meme_info/meme_info_screen.dart';
import '../../core/component/config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ZzalModel> zzalModel = [];

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  void fetchApi() async {
    final response = await ZzalRepository().fetchZzalList();
    setState(() {
      zzalModel = response;
    });
  }

  Future<bool> fetchLike(int id, String username) async {
    return await ZzalRepository().fetchLike(id, username);
  }

  Future<bool> likeZzal(int id, String username) async {
    await ZzalRepository().likeZzal(id, username);
    return await fetchLike(id, username);
  }

  @override
  Widget build(BuildContext context) {
    return zzalModel.isEmpty
        ? const Center(
            child: CircularProgressIndicator(color: Color(0xff1F0404)),
          )
        : PageView.builder(
            itemCount: zzalModel.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return FutureBuilder<bool>(
                future: fetchLike(zzalModel[index].id, username),
                builder: (context, snapshot) {
                  bool isLiked = snapshot.data ?? false;
                  return Stack(
                    children: [
                      Hero(
                        tag: 'video',
                        child: ZzalPlayer(url: zzalModel[index].video.video),
                      ),
                      Positioned(
                        bottom: 130,
                        child: ContentInfoBar(
                          username: zzalModel[index].username,
                          isLike: isLiked,
                          onLikeToggle: () async {
                            final result = await likeZzal(
                              zzalModel[index].id,
                              username,
                            );
                            setState(() {
                              isLiked = result;
                            });
                          },
                          onClickHole: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MemeInfoScreen(
                                memeAuthor: zzalModel[index].username,
                                memeName: zzalModel[index].name,
                                memeContent: zzalModel[index].description,
                                videoUrl: zzalModel[index].video.video,
                              ),
                            ),
                          ),
                          memeName: zzalModel[index].name,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
  }
}
