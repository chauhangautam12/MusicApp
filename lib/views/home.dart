import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:juzox/const/color.dart';
import 'package:juzox/const/textstyle.dart';
import 'package:juzox/controller/playercontroller.dart';
import 'package:juzox/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';


class home extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var controller=Get.put(playercontroller());
    return Scaffold(
      backgroundColor: bgdark,
      appBar: AppBar(
        backgroundColor: bgdark,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.sort_rounded,color: white,)),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.search,color: white,)),

      ],
      title: Row(
        children: [
          Text("Juzox",style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold)),
          SizedBox(
            width: 5,
          ),
          Text("Music",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)),
        ],
      ),
      ),
       body:FutureBuilder<List<SongModel>>(
         future: controller.audioquery.querySongs(
           ignoreCase: true,
           orderType: OrderType.ASC_OR_SMALLER,
           sortType: null,
           uriType: UriType.EXTERNAL
         ),
         builder:(context, snapshot) {
           if(snapshot.data==null){
             return Center(
               child: CircularProgressIndicator(),
             );
           }else if(snapshot.data!.isEmpty){
                return Center(child: Text("No Song Found",style: Ourstyle(),));

           }
           else{
             return Padding(
               padding: const EdgeInsets.all(8.0),
               child: ListView.builder(
                 itemCount: snapshot.data!.length,
                 physics: BouncingScrollPhysics(),
                 itemBuilder: (context, index) {
                   return Container(

                     margin: EdgeInsets.only(bottom: 4),
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12)
                     ),
                     child: Obx(
                       () => ListTile(
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(12)
                         ),
                         tileColor: bgcolour,
                         title: Text("${snapshot.data![index].displayNameWOExt}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.white)),
                         subtitle: Text("${snapshot.data![index].artist}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.white)),
                         leading: QueryArtworkWidget(id: snapshot.data![index].id, type:ArtworkType.AUDIO,nullArtworkWidget: Icon(Icons.music_note,color: white,size: 32,)),
                         trailing: controller.playinde.value==index &&
                             controller.isplaying.value?Icon(Icons.play_arrow,color: white,size: 32,):null,
                         onTap: () {
                           Get.to(()=> player(data: snapshot.data!,),
                           // transition: Transition.downToUp,
                           );
                          controller.playsong(snapshot.data![index].uri,index);
                          
                         },
                       ),
                     ),
                   );


                 },),
             );
           }

       },

       )
    );
  }
}
