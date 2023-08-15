class PasswordSettings {
  final bool useNumbers;
  final bool useSpecialCharacters;
  final int passwordLength;

  PasswordSettings({
    required this.useNumbers,
    required this.useSpecialCharacters,
    required this.passwordLength,
  });
}
