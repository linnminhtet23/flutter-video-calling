import 'dart:io';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:ed_screen_recorder/ed_screen_recorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_calling/models/video.dart';
import 'package:path_provider/path_provider.dart';


class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  //screen recorder
  EdScreenRecorder? edScreenRecorder;
  Map<String, dynamic>? _response;
  
  late Future<File> videoFile;
  late Video video;
  late List<Video> videos;
  bool started = false;

  //agora
  final AgoraClient _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
        appId: '288f63cb3d6d4b15915a38c1977bdbbe',
        channelName: 'fluttering',
        tempToken:
            '006249afe5fd0ac4a02b6f492c0c5f6452dIACC2gKge+4FVdefy520CP55Nmxt5qr7GPT2tmjNwB3U/72YShYAAAAAEABGv362eUGKYgEAAQB4QYpi'),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );
  

  @override
  void initState() {
    super.initState();
    _initAgora();
    edScreenRecorder = EdScreenRecorder();
  }



  void _initAgora() async {
    await _client.initialize();
  }

  //Start recording
  Future<void> startRecord({required String fileName}) async {
    Directory? directory = await getExternalStorageDirectory();
    String directoryPath = directory!.path;

    var response = await edScreenRecorder?.startRecordScreen(
      fileName: fileName,
      dirPathToSave: directoryPath,
      audioEnable: true,
    );

    setState(() {
      _response = response;
      started = true;
    });
  }

//Stop Recording
  Future<void> stopRecord() async {
    var response = await edScreenRecorder?.stopRecord();
    setState(() {
      _response = response;
      started = false;
    });
    // print((_response?['file'] as File?)?.path);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Video Call'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                AgoraVideoViewer(
                  client: _client,
                  layoutType: Layout.floating,
                  showNumberOfUsers: true,
                ),
                AgoraVideoButtons(
                  client: _client,
                  enabledButtons: const [
                    BuiltInButtons.switchCamera,
                    BuiltInButtons.callEnd,
                    BuiltInButtons.toggleMic,
                  ],
                ),
                // Text("File: ${(_response?['file'] as File?)?.path}"),
                Align(
                  alignment: Alignment.centerRight,
                  child: RawMaterialButton(
                    onPressed: () {
                      started
                          ? stopRecord()
                          : startRecord(fileName: 'recordings');
                    },
                    elevation: 2.0,
                    fillColor: started ? Colors.red : Colors.white,
                    child: started
                        ? const Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 15.0,
                          )
                        : const Icon(
                            Icons.fiber_manual_record,
                            size: 15.0,
                          ),
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
