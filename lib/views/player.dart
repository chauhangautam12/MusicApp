import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:juzox/const/color.dart';
import 'package:juzox/const/textstyle.dart';
import 'package:juzox/controller/playercontroller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class player extends StatelessWidget {
final List <SongModel> data;

  const player({super.key, required this.data});


  @override
  Widget build(BuildContext context) {
    var controller= Get.find<playercontroller>();
    return Scaffold(
      backgroundColor: bgcolour,
    appBar: AppBar(

    ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Obx(() => Expanded(child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 350,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                alignment: Alignment.center,
                child: QueryArtworkWidget(id: data[controller.playinde.value].id, type: ArtworkType.AUDIO,artworkHeight: double.infinity,
                  artworkWidth: double.infinity,
                nullArtworkWidget: Icon(Icons.music_note,size: 48,color: white,),
                )
              ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Expanded(child: Container(
            height: 300,
            width: 350,
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
          child: Obx(
            () =>  Column(
              children: [
                Text(data[controller.playinde.value].displayNameWOExt,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(color: bgdark,fontWeight: FontWeight.bold,fontSize:20),),
                SizedBox(height: 10,),
                Text(data[controller.playinde.value].artist.toString(),style: TextStyle(color: bgdark,fontSize: 15),),
                SizedBox(height: 10,),
                Obx(() => Row(
                    children: [
                      Text(controller.position.value,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: bgdark,fontSize: 10),),
                      Expanded(child: Slider(
                        thumbColor: slider,
                        activeColor:slider,
                         value: controller.value.value,
                        inactiveColor:bgcolour,
                        min: Duration(seconds: 0).inSeconds.toDouble(),
                        max: controller.max.value,
                        onChanged: (newvalue) {
                          controller.changeduration(newvalue.toInt());
                        newvalue=newvalue;
                      },)),
                      Text(controller.duration.value,style: TextStyle(color: bgdark,fontSize: 10),),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(onPressed: (){
                        controller.playsong(data[controller.playinde.value-1].uri, controller.playinde.value-1);
                      }, icon: Icon(Icons.skip_previous_rounded,size: 40,color: bgdark,)),

                         Obx(
                           () => CircleAvatar(
                            radius: 35,
                              backgroundColor: bgdark,
                              child: Transform.scale(
                                  scale: 2.5,
                                  child: IconButton(onPressed: (){
                                    if(controller.isplaying.value){
                                      controller.audioPlayer.pause();
                                      controller.isplaying(false);
                                    }else{
                                      controller.audioPlayer.play();
                                      controller.isplaying(true);
                                    }
                                  }, icon:controller.isplaying.value? Icon(Icons.pause,color: white,):Icon(Icons.play_arrow_rounded,color: white,)))),
                         ),

                      IconButton(onPressed: (){
                        controller.playsong(data[controller.playinde.value+1].uri, controller.playinde.value+1);
                      }, icon: Icon(Icons.skip_next_rounded,color: bgdark,size: 40,))
                    ],
                  ),

              ],
            ),
          ),
          ),
          ),
        ],
      ),
    );
  }
}
