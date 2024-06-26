enum FilterOptions {
  under29(minValue: 0, maxValue: 29.99, title: 'Under \$29.99'),
  between30_50(minValue: 30, maxValue: 49.99, title: '\$30 - \$49.99'),
  between50_70(minValue: 50, maxValue: 69.99, title: '\$50 - \$69.99'),
  over70(minValue: 70, maxValue: double.infinity, title: 'Over \$70');

  const FilterOptions(
      {required this.minValue, required this.maxValue, required this.title});

  final double minValue;
  final double maxValue;
  final String title;
}
