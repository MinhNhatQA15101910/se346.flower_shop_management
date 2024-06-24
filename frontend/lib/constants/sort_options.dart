enum SortOption {
  popular(value: 'Popular'),
  topSelling(value: 'Top selling'),
  nameAtoZ(value: 'Name: A to Z'),
  nameZtoA(value: 'Name: Z to A'),
  priceLowToHigh(value: 'Price: Low to High'),
  priceHighToLow(value: 'Price: High to Low');

  const SortOption({required this.value});

  final String value;
}
