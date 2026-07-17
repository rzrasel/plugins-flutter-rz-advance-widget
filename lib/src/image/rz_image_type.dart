enum RzImageType {
  network('network'),
  file('file'),
  memory('memory'),
  asset('asset');

  final String type;

  const RzImageType(this.type);

  static RzImageType? find(String? value) {
    for (final item in RzImageType.values) {
      if (item.type.toLowerCase() == (value ?? '').toLowerCase()) {
        return item;
      }
    }
    return null;
  }
}