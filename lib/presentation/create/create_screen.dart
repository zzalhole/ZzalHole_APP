import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:zzal_hole/data/repository/zzall_repository.dart';

import '../../core/component/base_bottom_navigation_bar.dart';

class CreateScreen extends ConsumerStatefulWidget {
  const CreateScreen({super.key});

  @override
  ConsumerState<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends ConsumerState<CreateScreen> {
  final TextEditingController _memeNameController = TextEditingController();
  final TextEditingController _memeDescriptionController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool canPass = false;

  @override
  void initState() {
    _memeNameController.addListener(_updateCanPass);
    _memeDescriptionController.addListener(_updateCanPass);
    super.initState();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _memeNameController.dispose();
    _memeDescriptionController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _updateCanPass() {
    final shouldPass =
        _memeNameController.text.isNotEmpty &&
        _memeDescriptionController.text.isNotEmpty &&
        _videoFile != null;
    if (canPass != shouldPass) {
      setState(() {
        canPass = shouldPass;
      });
    }
  }

  void showNameDialog(WidgetRef ref) {
    final notifier = ref.read(currentIndexProvider.notifier);

    showModalBottomSheet(
      context: context,
      builder: (builder) => StatefulBuilder(
        builder: (context, setState) {
          nameController.addListener(() {
            setState(() {});
          });

          return Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: double.infinity,
                color: Color(0xffD3BBB7),
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  spacing: 10,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('이름을 알려주세요'),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: Color(0xffF4E1D4),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextField(
                        controller: nameController,
                        cursorColor: Color(0xff1F0404),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '이름을 입력해주세요',
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
              nameController.text.isNotEmpty
                  ? Positioned(
                      bottom: 70,
                      right: 30,
                      child: GestureDetector(
                        onTap: () async {
                          await ZzalRepository().postZzal(
                            username: nameController.text,
                            name: _memeNameController.text,
                            description: _memeDescriptionController.text,
                            videoFile: _videoFile!,
                          );
                          Navigator.pop(context);
                          notifier.setCurrentIndex(0);
                        },
                        child: Container(
                          width: 200,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xff684C48),
                            borderRadius: BorderRadius.circular(500),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '구덩이 업로드 하기',
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
                    )
                  : SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }

  // 클래스 내 변수 추가
  File? _videoFile;
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoController;

  // pickVideo 수정
  Future<void> pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _videoController?.dispose(); // 이전 컨트롤러 해제
      _videoController = VideoPlayerController.file(File(pickedFile.path));
      await _videoController!.initialize();
      _videoController!.setLooping(true);
      _videoController!.play();

      setState(() {
        _videoFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 100),
                    TextField(
                      controller: _memeNameController,
                      style: TextStyle(fontSize: 24, color: Color(0xff1F0404)),
                      cursorColor: Color(0xff1F0404),
                      decoration: InputDecoration(
                        hintText: '밈 이름을 작성해주세요',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1F0404)),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1F0404)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1F0404)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1F0404)),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff1F0404)),
                        ),
                      ),
                    ),
                    TextField(
                      controller: _memeDescriptionController,
                      style: TextStyle(fontSize: 16, color: Color(0xff1F0404)),
                      cursorColor: Color(0xff1F0404),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '밈에 대한 설명과 따라하는 방법을 소개해주세요.',
                      ),
                    ),
                    SizedBox(height: 40),
                    if (_videoController != null &&
                        _videoController!.value.isInitialized)
                      AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: GestureDetector(
                          onTap: () {
                            if (_videoController!.value.isPlaying) {
                              _videoController!.pause();
                            } else {
                              _videoController!.play();
                            }
                            setState(() {}); // UI 갱신
                          },
                          child: VideoPlayer(_videoController!),
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                bottom: 100,
                child: (canPass)
                    ? GestureDetector(
                        onTap: () => showNameDialog(ref),
                        child: Container(
                          width: 120,
                          height: 40,
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
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        ),
        Positioned(
          top: 60,
          right: 20,
          child: Row(
            children: [
              TextButton(
                onPressed: () => pickVideo(),
                child: Text('동영상 업로드'),
                style: TextButton.styleFrom(foregroundColor: Color(0xff1F0404)),
              ),
              TextButton(
        onPressed: () {
          if (_videoFile == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('먼저 동영상을 업로드해주세요.'),
                duration: Duration(seconds: 2),
              ),
            );
            return;
          }
          _simulateTypingToDescription(
            '이 밈은 AI가 자동으로 설명을 생성한 예시입니다. 설명을 바꿔도 괜찮아요!',
          );
        },
                child: Text('AI로 설명하기'),
                style: TextButton.styleFrom(foregroundColor: Color(0xff1F0404)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 설명 TextField에 디바운스 효과로 한 글자씩 넣기
  Future<void> _simulateTypingToDescription(String text) async {
    _memeDescriptionController.clear();
    for (int i = 0; i < text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 50));
      _memeDescriptionController.text += text[i];
      _memeDescriptionController.selection = TextSelection.fromPosition(
        TextPosition(offset: _memeDescriptionController.text.length),
      );
    }
  }
}
