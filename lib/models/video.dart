class Video {
 late int id;
  late String videoName;

  Video({
    required this.id,
    required this.videoName,
  });

  Map<String,dynamic> toMap(){
   var map =<String, dynamic>{
     'id': id,
     'videoName':videoName
   } ;
   return map;
  }

  Video.fromMap(Map<String, dynamic> map){
    id =map['id'];
    videoName=map['videoName'];  
  }
}
