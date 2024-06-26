enum PriceOptions {
  under29(value: 'Under \$29.99'),
  medium(value: 'Medium'),
  standard(value: 'Standard'),
  large(value: 'Large'),
  extra_large(value: 'Extra Large'),
  jumbo(value: 'Jumbo');

  const PriceOptions({required this.value});

  final String value;
}
