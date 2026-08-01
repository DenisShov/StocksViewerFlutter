library;

String? extractCursor(String? nextUrl) {
  if (nextUrl == null) return null;
  const marker = 'cursor=';
  final index = nextUrl.indexOf(marker);
  if (index < 0) return null;
  final cursor = nextUrl.substring(index + marker.length);
  return cursor.isEmpty ? null : cursor;
}
