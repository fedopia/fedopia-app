class Instance {
  final String name;
  final String domain;

  const Instance({
    required this.name,
    required this.domain,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Instance &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          domain == other.domain;

  @override
  int get hashCode => name.hashCode ^ domain.hashCode;
}
