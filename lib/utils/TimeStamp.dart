
import 'package:timeago/timeago.dart' as timeago;
import 'package:jiffy/jiffy.dart';

class TimeStamp {

  TimeStamp();

  String getTimeAgo(int postTime){
    final ago = new DateTime.now().subtract(new Duration(minutes: postTime));
    return timeago.format(ago);
  }

}