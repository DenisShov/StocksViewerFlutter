/// The data-layer function deriving the next pagination cursor from a
/// `next_url` value returned by the Polygon.io API.
///
/// This file is pure Dart: it has no Flutter import.
library;

/// Extracts the pagination cursor from [nextUrl].
///
/// Returns every character after the **first** `cursor=` occurrence through
/// the last character of [nextUrl], with no truncation at a later `&`.
///
/// Returns `null` when [nextUrl] is `null`, when [nextUrl] contains no
/// `cursor=` occurrence, or when zero characters follow the first
/// `cursor=` (never the empty string).
String? extractCursor(String? nextUrl) {
  if (nextUrl == null) return null;
  const marker = 'cursor=';
  final index = nextUrl.indexOf(marker);
  if (index < 0) return null;
  final cursor = nextUrl.substring(index + marker.length);
  return cursor.isEmpty ? null : cursor;
}
