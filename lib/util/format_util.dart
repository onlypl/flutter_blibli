///数字转万
String countFormat(int count){
   String countStr = "";
   if(count > 9999){
      countStr = "${(count/10000).toStringAsFixed(2)}W";
   }else{
    countStr = count.toString();
   }
   return countStr;
}


///时间转换将秒转换为小时:分钟:秒

String durationTransForm(int seconds,bool isShowHour){
  String hourStr = ''; //小时
  String minuteStr = '';  //分钟  
  String secondsStr = ''; //秒
  String payTime = ''; //播放时长
    minuteStr = formatNumberWithLeadingZero(((seconds ~/ 60)% 60));
    secondsStr = formatNumberWithLeadingZero(seconds% 60);
      payTime  =  '$minuteStr:$secondsStr';
     if(seconds >= 3600 || isShowHour){
        hourStr = formatNumberWithLeadingZero(seconds~/3600);
         payTime = '$hourStr:$payTime';
    }

    return payTime;
}

///小于10则前面补0
String formatNumberWithLeadingZero(int number) {
  return number.toString().padLeft(2, '0');
}