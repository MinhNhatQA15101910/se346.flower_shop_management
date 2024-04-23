enum Weight {
  small(value: 'Small'),
  medium(value: 'Medium'),
  standard(value: 'Standard'),
  large(value: 'Large'),
  extra_large(value: 'Extra Large'),
  jumbo(value: 'Jumbo');

  const Weight({required this.value});

  final String value;
}
