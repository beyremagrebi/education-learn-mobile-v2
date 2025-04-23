import 'package:flutter/material.dart';

import '../api_service.dart';

class ApiLogger {
  static const bool isActive = true;

  static String logRequest({
    required String url,
    required HttpMethod httpMethod,
    required bool isMultipart,
    required int? statusCode,
    required String? requestBody,
    required String? queryParameters,
    required String? responseBody,
  }) {
    if (!isActive) return '';

    final method = httpMethod.description;
    final status = statusCode?.toString() ?? 'Unknown';
    final requestType = isMultipart ? 'MULTIPART' : 'REQUEST';
    final coloredMethod = _getColoredMethod(method);
    final statusColor = _getStatusColor(statusCode);
    final timestamp = DateTime.now().toIso8601String();

    final buffer = StringBuffer()
      ..writeln('╔═════════════════════════════════════════════════════')
      ..writeln(
          '║ 🌐 $requestType $coloredMethod ${statusColor}Status: $status')
      ..writeln('║ 🕒 $timestamp')
      ..writeln('║ 🔗 ${_getColoredUrl(url)}')
      ..writeln('╟─────────────────────────────────────────────────────');

    var hasContent = false;

    if (queryParameters?.isNotEmpty ?? false) {
      buffer
        ..writeln('║ 📋 Query Parameters:')
        ..writeln('║   ${_formatJsonLikeContent(queryParameters!)}')
        ..writeln('║─────────────────────────────────────────────────────');
      hasContent = true;
    }

    if (requestBody?.isNotEmpty ?? false) {
      buffer
        ..writeln('║ 📦 Request Body:')
        ..writeln('║   ${_formatJsonLikeContent(requestBody!)}')
        ..writeln('║─────────────────────────────────────────────────────');
      hasContent = true;
    }

    if (responseBody?.isNotEmpty ?? false) {
      buffer
        ..writeln('║ 📨 Response:')
        ..writeln('║   ${_formatJsonLikeContent(responseBody!)}')
        ..writeln('║─────────────────────────────────────────────────────');
      hasContent = true;
    }

    if (!hasContent) {
      buffer.writeln('║ ℹ️ No additional content');
    }

    buffer.writeln('╚═════════════════════════════════════════════════════');

    final log = buffer.toString();
    debugPrint(log);
    return log;
  }

  static String _formatJsonLikeContent(String content) {
    final indented = content.replaceAllMapped(
      RegExp(r'^(.*)$', multiLine: true),
      (match) => '║   ${match.group(1)}',
    );
    return _syntaxHighlight(indented);
  }

  static String _syntaxHighlight(String jsonString) {
    return jsonString
        .replaceAllMapped(
            RegExp(r'"(.*?)"'), (match) => '\x1B[34m"${match.group(1)}"\x1B[0m')
        .replaceAllMapped(RegExp(r':\s*(.*?)([,}\s])'),
            (match) => ':\x1B[33m${match.group(1)}\x1B[0m${match.group(2)}')
        .replaceAllMapped(RegExp(r'(true|false|null)'),
            (match) => '\x1B[35m${match.group(0)}\x1B[0m');
  }

  static String _getColoredMethod(String method) {
    const reset = '\x1B[0m';

    switch (method) {
      case 'GET':
        return '\x1B[32m$method$reset';
      case 'POST':
        return '\x1B[33m$method$reset';
      case 'PUT':
        return '\x1B[34m$method$reset';
      case 'DELETE':
        return '\x1B[31m$method$reset'; // Red
      case 'PATCH':
        return '\x1B[35m$method$reset'; // Purple
      default:
        return '\x1B[36m$method$reset'; // Cyan
    }
  }

  static String _getColoredUrl(String url) {
    const reset = '\x1B[0m';
    return '\x1B[2m\x1B[3m\x1B[36m$url$reset'; // Light blue, italic, faint
  }

  static String _getStatusColor(int? statusCode) {
    const reset = '\x1B[0m';
    if (statusCode == null) return '';

    if (statusCode >= 200 && statusCode < 300) {
      return '\x1B[32m✔$reset'; // Green check for success
    } else if (statusCode >= 400 && statusCode < 500) {
      return '\x1B[33m⚠$reset'; // Yellow warning for client errors
    } else if (statusCode >= 500) {
      return '\x1B[31m✖$reset'; // Red cross for server errors
    }
    return '\x1B[37m$statusCode$reset'; // White for other codes
  }
}
