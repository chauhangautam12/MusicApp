import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class playercontroller extends GetxController{

  final audioquery= OnAudioQuery();
  final audioPlayer=AudioPlayer();

  var playinde=0.obs;
  var isplaying=false.obs;
  var duration="".obs;
  var position="".obs;
  var max=0.0.obs;
  var value=0.0.obs;



  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkpermission();
  }
  changeduration(seconds){
    var duration=Duration(seconds:seconds );
    audioPlayer.seek(duration);
  }
  updatePosition(){
    audioPlayer.durationStream.listen((d) {
      duration.value=d.toString().split(".")[0];
      max.value=d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value=p.toString().split(".")[0];
      value.value=p!.inSeconds.toDouble();
    });
  }
  playsong(String? uri,index){
    playinde.value=index;

    try{
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isplaying(true);
      updatePosition();
    }on Exception catch(e){
    print(e.toString());
    }
  }

   checkpermission() async {
    var perm= await Permission.storage.request();
    if(perm.isGranted){
    }
    else{
      checkpermission();
    }
   }

}