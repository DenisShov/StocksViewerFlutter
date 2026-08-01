class BrandingUrlResolver {
  const BrandingUrlResolver({required this.apiKey});

  final String apiKey;

  String? resolve(String? source) {
    if (source == null || source.isEmpty) return null;
    final uri = Uri.tryParse(source);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) return null;
    if (apiKey.isEmpty) return uri.toString();

    return uri
        .replace(queryParameters: {...uri.queryParameters, 'apiKey': apiKey})
        .toString();
  }
}
