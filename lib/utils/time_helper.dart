import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;


class TimeHelper {

  static String getTime(Timestamp? timestamp) {

    if (timestamp == null) {
      return "Just now";
    }


    DateTime date =
    timestamp.toDate();


    DateTime now =
    DateTime.now();


    Duration difference =
    now.difference(date);



    if (difference.inMinutes < 1) {

      return "Just now";

    }


    if (difference.inHours < 24) {

      return timeago.format(date);

    }


    if (difference.inDays == 1) {

      return "Yesterday • ${DateFormat('hh:mm a').format(date)}";

    }


    return DateFormat(
      'dd MMM yyyy • hh:mm a',
    ).format(date);

  }

}