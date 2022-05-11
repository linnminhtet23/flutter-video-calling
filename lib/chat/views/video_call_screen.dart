import 'dart:io';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:ed_screen_recorder/ed_screen_recorder.dart';
import 'package:flutter/material.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  //screen recorder
  EdScreenRecorder? edScreenRecorder;
  Map<String, dynamic>? _response;
  bool started =false;

  //agora
  final AgoraClient _client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
        appId: '288f63cb3d6d4b15915a38c1977bdbbe',
        channelName: 'fluttering',
        tempToken:
            '006288f63cb3d6d4b15915a38c1977bdbbeIABQDyGOY4u3Cf9QzlrXDTSx9C91S79BT388mLCK+AHNq72YShYAAAAAEACgcVr/e1B9YgEAAQB7UH1i'),
    enabledPermission: [
      Permission.camera,
      Permission.microphone,
    ],
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initAgora();
    edScreenRecorder = EdScreenRecorder();
  }

  void _initAgora() async {
    await _client.initialize();
  }

  //Start recording
  Future<void> startRecord({required String fileName}) async {
    var response = await edScreenRecorder?.startRecordScreen(
      fileName: fileName,
      audioEnable: false,
    );

    setState(() {
      _response = response;
      started=true;
    });

  }

//Stop Recording
  Future<void> stopRecord() async {
    var response = await edScreenRecorder?.stopRecord();
    setState(() {
      _response = response;
      started =false;
    });
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
                            Text("File: ${(_response?['file'] as File?)?.path}"),

                Align(
                  alignment: Alignment.centerRight,
                  child: RawMaterialButton(
                    onPressed: () {
                     started? stopRecord():startRecord(fileName: 'recordings');
                    },
                    elevation: 2.0,
                    fillColor: started? Colors.red: Colors.white ,
                    child: started ?const Icon(
                      Icons.stop,
                      color: Colors.white,
                      size: 15.0,
                    ):const Icon(
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
