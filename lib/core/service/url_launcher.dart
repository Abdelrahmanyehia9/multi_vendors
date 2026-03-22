import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

/// A service class to handle various URL launching operations
final class UrlLauncherService {
  const UrlLauncherService._();
  static final instance = const UrlLauncherService._();
  /// Launches a URL with error handling
  Future<void> launchUrlString(String url, {LaunchMode? mode}) async {
    final Uri uri = Uri.parse(url);
    await _launchUrl(uri, mode: mode);
  }

  /// Launches a URI with error handling
  Future<void> _launchUrl(Uri uri, {LaunchMode? mode}) async {
    try {
      final bool canLaunch = await canLaunchUrl(uri);

      if (!canLaunch) {
        throw Exception('Could not launch $uri');
      }

      await launchUrl(uri, mode: mode ?? LaunchMode.platformDefault);
    } catch (e) {
      debugPrint('Error launching URL: $e');
      rethrow;
    }
  }

  /// Launches an email client with optional subject and body
  Future<void> launchEmail(
    String email, {
    String subject = '',
    String body = '',
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject.isNotEmpty) 'subject': subject,
        if (body.isNotEmpty) 'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw Exception('Could not launch $emailUri');
    }
  }

  /// Launches the phone dialer with the provided phone number
  Future<void> launchPhoneCall(String phoneNumber) async {
    final String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    final Uri telUri = Uri(scheme: 'tel', path: cleanedNumber);

    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      throw Exception('Could not launch $telUri');
    }
  }

  /// Launches SMS with the provided phone number and optional message
  Future<void> launchSms(String phoneNumber, {String message = ''}) async {
    final String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: cleanedNumber,
      queryParameters: <String, String>{
        if (message.isNotEmpty) 'body': message,
      },
    );

    await _launchUrl(smsUri);
  }

  /// Opens the maps application with the specified location

  Future<void> launchLocation({
    required double latitude,
    required double longitude,
    String? label,
    MapLaunchMode mapMode = MapLaunchMode.navigation,
  }) async {
    String mapsUrl;
    if (Platform.isIOS) {
      // For iOS, use Apple Maps format
      mapsUrl = 'https://maps.apple.com/?ll=$latitude,$longitude';
      if (label != null) {
        mapsUrl += '&q=${Uri.encodeComponent(label)}';
      }

      if (mapMode == MapLaunchMode.navigation) {
        mapsUrl += '&dirflg=d';
      }
    } else {
      // For Android and others, use Google Maps format
      mapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      if (mapMode == MapLaunchMode.navigation) {
        mapsUrl =
            'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
      }
    }

    await launchUrlString(mapsUrl);
  }

  /// Opens a location by address string
  Future<void> launchLocationByAddress(String address) async {
    final String encodedAddress = Uri.encodeComponent(address);
    final String url =
        'https://www.google.com/maps/search/?api=1&query=$encodedAddress';

    await launchUrlString(url);
  }

  /// Opens WhatsApp with the specified phone number
  Future<void> launchWhatsApp(String phoneNumber, {String message = ''}) async {
    final String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
    String whatsappUrl = 'https://wa.me/$cleanedNumber';

    if (message.isNotEmpty) {
      whatsappUrl += '?text=${Uri.encodeComponent(message)}';
    }

    await launchUrlString(whatsappUrl);
  }

  /// Opens a social media profile
  Future<void> launchSocialMedia(
    SocialMediaPlatform platform,
    String username,
  ) async {
    final String url = platform.getProfileUrl(username);
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
}

/// Navigator key to be used in MaterialApp for context access

/// Enum representing map opening modes
enum MapLaunchMode { view, navigation }

/// Enum representing social media platforms
enum SocialMediaPlatform {
  facebook,
  twitter,
  instagram,
  linkedin,
  tiktok,
  discord,
  youtube;

  String getProfileUrl(String username) {
    switch (this) {
      case SocialMediaPlatform.facebook:
        return 'https://www.facebook.com/$username';
      case SocialMediaPlatform.twitter:
        return 'https://twitter.com/$username';
      case SocialMediaPlatform.tiktok:
        return 'https://tiktok.com/$username';
      case SocialMediaPlatform.instagram:
        return 'https://www.instagram.com/$username';
      case SocialMediaPlatform.linkedin:
        return 'https://www.linkedin.com/in/$username';
      case SocialMediaPlatform.discord:
        return 'https://www.discord.com/$username';
      case SocialMediaPlatform.youtube:
        return 'https://www.youtube.com/$username';
    }
  }
}
