import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:video_call/const/key.dart';

class CamScreen extends StatefulWidget {
  const CamScreen({super.key});

  @override
  State<CamScreen> createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;
  int uid = 0;
  int? remoteUid;

  Future<void> init() async {
    final resp = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = resp[Permission.camera];
    final microphonePermission = resp[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        microphonePermission != PermissionStatus.granted) {
      throw '카메라 또는 마이크 권한 없음';
    }

    if (engine == null) {
      engine = createAgoraRtcEngine();
      await engine!.initialize(RtcEngineContext(appId: appId));

      engine!.registerEventHandler(
        RtcEngineEventHandler(

          onJoinChannelSuccess: (connection, elapsed){

          },

          onLeaveChannel: (connection, stats) {

          },

          onUserJoined: (RtcConnection connection,
          int remoteUid, int elapsed ){
            print('-----uerJOined-----');
            setState(() {
              this.remoteUid = remoteUid;
            });
          },
          onUserOffline: (RtcConnection connection,
          int remoteUid, UserOfflineReasonType reaseon){
            setState(() {
              this.remoteUid=null;
              
            });
          }
        )
      );

      await engine!.enableAudio();
      await engine!.startPreview();
      await engine!.enableVideo();

      ChannelMediaOptions option = ChannelMediaOptions();

      await engine!.joinChannel(
        token: token,
        channelId: channelName,
        uid: uid,
        options: option,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live')),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return Stack(
            children: [
              Container(
                child: renderMainView(),
              ),
              Container(
                width: 120,
                height: 160,
                child: AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: engine!,
                    canvas: VideoCanvas(uid: uid),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: ElevatedButton(onPressed: () {
                  engine!.leaveChannel();
                  engine!.release();
                  Navigator.of(context).pop();
                }, child: Text('나가기')),
              ),
            ],
          );
        },
      ),
    );
  }

  renderMainView(){
    if(remoteUid==null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return AgoraVideoView(
                controller: VideoViewController.remote(
                rtcEngine: engine!,
                canvas: VideoCanvas(
                uid: remoteUid,
                ),
               connection: RtcConnection(
                  channelId: channelName,
                  ),
                  ),
               );
  }
}
