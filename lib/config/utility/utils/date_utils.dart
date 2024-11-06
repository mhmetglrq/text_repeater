import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:text_repeater/config/extensions/context_extensions.dart';

class INTLDateUtils {
  static String getTimeDifference(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return '${difference.inSeconds}s ago';
    }
  }

  static String getFormattedDate(DateTime dateTime, BuildContext context) {
    final formattedDate = DateFormat.yMMMd(
      context.locale?.localeName,
    ).format(dateTime);

    return formattedDate;
  }
}
