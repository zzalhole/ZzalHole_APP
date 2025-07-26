import 'package:flutter/material.dart';
import 'package:zzal_hole/core/component/zzal_player.dart';

import '../../data/models/zzal_list_model.dart';
import '../../data/repository/zzall_repository.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<ZzalModel> zzalModel = [];

  void fetchApi() async {
    final response = await ZzalRepository().fetchZzalRank();
    print(response[0].username);
    setState(() {
      zzalModel = response;
    });
  }

  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return zzalModel.isEmpty
        ? Center(child: CircularProgressIndicator(color: Color(0xff1F0404)))
        : Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SizedBox(height: 100),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            '오늘의 밈',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            '주간 밈',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            '월간 밈',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 1, color: Color(0xff1F0404)),
                Row(
                  children: [
                    if (zzalModel.length > 0)
                      _RankingItem(rank: 1, model: zzalModel[0]),
                    if (zzalModel.length > 1) const SizedBox(width: 10),
                    if (zzalModel.length > 1)
                      _RankingItem(rank: 2, model: zzalModel[1]),
                    if (zzalModel.length > 2) const SizedBox(width: 10),
                    if (zzalModel.length > 2)
                      _RankingItem(rank: 3, model: zzalModel[2]),
                  ],
                ),
                if (zzalModel.length > 3)
                  Expanded(
                    child: ListView.builder(
                      itemCount: zzalModel.length - 3,
                      itemBuilder: (context, index) {
                        final model = zzalModel[index + 3];
                        return _RankingListItem(rank: index + 4, model: model);
                      },
                    ),
                  ),
              ],
            ),
          );
  }
}

class _RankingItem extends StatelessWidget {
  final int rank;
  final ZzalModel model;

  const _RankingItem({required this.rank, required this.model});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: ZzalPlayer(url: model.video.video, isPaused: true),
          ),
          const SizedBox(height: 10),
          Text('$rank. ${model.name}'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _RankingListItem extends StatelessWidget {
  final int rank;
  final ZzalModel model;

  const _RankingListItem({required this.rank, required this.model});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('$rank'),
      title: Text(model.name, overflow: TextOverflow.ellipsis),
      subtitle: Text(model.username, overflow: TextOverflow.ellipsis),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
