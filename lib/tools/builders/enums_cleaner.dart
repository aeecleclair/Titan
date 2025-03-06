List<T> getEnumValues<T>(List<T> values) {
  // Filter out the swaggerGeneratedUnknown value
  return values.where((element) {
    // Use reflection to check the name of the enum value
    final String enumName = element.toString().split('.').last;
    return enumName != 'swaggerGeneratedUnknown';
  }).toList();
}
