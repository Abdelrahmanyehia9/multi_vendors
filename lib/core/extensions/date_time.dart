extension DateTimeX on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.isNegative || difference.inSeconds < 60) return DateTimeStrings.justNow;
    if (difference.inMinutes < 60) return _pastFormat(difference.inMinutes, DateTimeStrings.minuteSingular, DateTimeStrings.minutePlural);
    if (difference.inHours < 24)   return _pastFormat(difference.inHours,   DateTimeStrings.hourSingular,   DateTimeStrings.hourPlural);
    if (difference.inDays == 1)    return DateTimeStrings.yesterday;
    if (difference.inDays < 7)     return _pastFormat(difference.inDays,    DateTimeStrings.daySingular,    DateTimeStrings.dayPlural);
    if (difference.inDays < 30)    return _pastFormat((difference.inDays / 7).floor(),  DateTimeStrings.weekSingular,  DateTimeStrings.weekPlural);
    if (difference.inDays < 365)   return _pastFormat((difference.inDays / 30).floor(), DateTimeStrings.monthSingular, DateTimeStrings.monthPlural);

    return _pastFormat((difference.inDays / 365).floor(), DateTimeStrings.yearSingular, DateTimeStrings.yearPlural);
  }
  String get timeAfter {
    final now = DateTime.now();
    final difference = this.difference(now);

    if (difference.isNegative)     return DateTimeStrings.unknown;
    if (difference.inSeconds < 60) return DateTimeStrings.justNow;
    if (difference.inMinutes < 60) return _futureFormat(difference.inMinutes, DateTimeStrings.minuteSingular, DateTimeStrings.minutePlural);
    if (difference.inHours < 24)   return _futureFormat(difference.inHours,   DateTimeStrings.hourSingular,   DateTimeStrings.hourPlural);
    if (difference.inDays == 1)    return DateTimeStrings.tomorrow;
    if (difference.inDays < 7)     return _futureFormat(difference.inDays,    DateTimeStrings.daySingular,    DateTimeStrings.dayPlural);
    if (difference.inDays < 30)    return _futureFormat((difference.inDays / 7).floor(),  DateTimeStrings.weekSingular,  DateTimeStrings.weekPlural);
    if (difference.inDays < 365)   return _futureFormat((difference.inDays / 30).floor(), DateTimeStrings.monthSingular, DateTimeStrings.monthPlural);

    return _futureFormat((difference.inDays / 365).floor(), DateTimeStrings.yearSingular, DateTimeStrings.yearPlural);
  }
  String get relativeTime => isBefore(DateTime.now()) ? timeAgo : timeAfter;

  String _pastFormat(int value, String singular, String plural) {
    final unit = value == 1 ? singular : plural;
    return '$value $unit ${DateTimeStrings.ago}';
  }
  String _futureFormat(int value, String singular, String plural) {
    final unit = value == 1 ? singular : plural;
    return '${DateTimeStrings.inPrefix} $value $unit';
  }

  String get formattedDate {
    return '${DateTimeStrings.months[month - 1]} $day, $year';
  }

  String get formattedTime {
    final period = hour >= 12 ? DateTimeStrings.pm : DateTimeStrings.am;
    final h = hour % 12 == 0 ? 12 : hour % 12;
    final m = minute.toString().padLeft(2, '0');
    final s = second.toString().padLeft(2, '0');
    return '$h:$m:$s $period';
  }
}

class DateTimeStrings {
  const DateTimeStrings._();

  static const String justNow   = 'Just now';
  static const String yesterday = 'Yesterday';
  static const String tomorrow  = 'Tomorrow';
  static const String unknown   = 'Unknown';

  static const String ago = 'ago';
  static const String inPrefix = 'In';

  static const String minuteSingular = 'minute';
  static const String minutePlural   = 'minutes';
  static const String hourSingular   = 'hour';
  static const String hourPlural     = 'hours';
  static const String daySingular    = 'day';
  static const String dayPlural      = 'days';
  static const String weekSingular   = 'week';
  static const String weekPlural     = 'weeks';
  static const String monthSingular  = 'month';
  static const String monthPlural    = 'months';
  static const String yearSingular   = 'year';
  static const String yearPlural     = 'years';

  static const String am = 'AM';
  static const String pm = 'PM';

  static const List<String> months = [
    'January', 'February', 'March',     'April',   'May',      'June',
    'July',    'August',   'September', 'October', 'November', 'December',
  ];
}