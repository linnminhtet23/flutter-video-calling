import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_video_calling/chat/views/video_call_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

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
      body: ListView(
        children: [
          Container()
          // ScreenRecorder(
          //     height: MediaQuery.of(context).size.height,
          //     width: MediaQuery.of(context).size.width,
          //     controller: controller,
          //     child: Container(
          //       width: MediaQuery.of(context).size.width,
          //       height: MediaQuery.of(context).size.height,
          //       decoration: const BoxDecoration(color: Colors.blue),
          //     )),
          // ElevatedButton(
          //   onPressed: () {
          //     controller.start();
          //   },
          //   child: const Text('Start'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     controller.stop();
          //   },
          //   child: const Text('Stop'),
          // ),
          // ElevatedButton(
          //     onPressed: () async {
          //       var gif = await controller.export();
          //       showDialog(
          //         context: context,
          //         builder: (context) {
          //           return AlertDialog(
          //             content: Image.memory(Uint8List.fromList(gif!)),
          //           );
          //         },
          //       );
          //     },
          //     child: Text('show recoded video'),
          //   ),
        ],
      ),
    );
  }
}
