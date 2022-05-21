import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_video_calling/chat/views/video_call_screen.dart';
import 'package:flutter_video_calling/chat/widgets/videoplayer.dart';
import 'package:path_provider/path_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  
  @override
  void initState() {
    super.initState();
    _folders = [];
    getDir();
  }

  List<FileSystemEntity>? _folders;
  Future<void> getDir() async {
    final directory = await getExternalStorageDirectory();
    final dir = directory!.path;
    String videoDirectory = '$dir/';
    final myDir = Directory(videoDirectory);
    setState(() {
      _folders = myDir.listSync(recursive: true, followLinks: false);
    });
    // print(_folders);
  }

  Future getFileType(file) {
    return file.stat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat"),
          actions: [
            IconButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const VideoCallScreen())),
              icon: const Icon(Icons.video_camera_front),
            )
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 180,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: _folders!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ViewVideo(videoPath: _folders![index].path.toString());
                }));
              },
              child: Material(
                elevation: 6.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder(
                                builder: (context, snapshot) {
                                  
                                  return const Icon(
                                    Icons.file_copy_outlined,
                                    size: 100,
                                    color: Colors.orange,
                                  );
                                }),
                                Text(
                          _folders![index].path.split('/').last,
                        ),
                          ]),
                          
                    )
                  ],
                ),
              ),
            );
          },
        )

        );
  }
  
}

