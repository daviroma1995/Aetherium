import 'dart:io';

import "package:googleapis_auth/auth_io.dart";
import 'package:googleapis/calendar/v3.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GoogleCalendar {
  static const _scopes = const [CalendarApi.calendarScope];
  Event event = Event();

  Future<bool> exportToGoogleCalendar({
    required String identifier,
    required String summary,
    required String description,
    required DateTime startDateTime,
    required String startTimeZone,
    required DateTime endDateTime,
    required String endTimeZone,
  }) async {
    event.summary = summary;
    event.description = description;
    event.start?.dateTime = startDateTime;
    event.end?.dateTime = endDateTime;
    event.start?.timeZone = startTimeZone;
    event.end?.timeZone = endTimeZone;
    var client = Client();
    obtainAccessCredentialsViaUserConsent(
      ClientId(identifier),
      _scopes,
      client,
      (uri) async {
        var canLuanch = await canLaunchUrlString(uri);
        launchUrlString(uri);
      },
    );

    return false;
  }

  launchUrl(url) {
    print(url);
  }
}
