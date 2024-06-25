enum SortOption {
  id(value: 'Default', type: 'id', order: 'asc'),
  topSelling(value: 'Top selling', type: 'sold', order: 'desc'),
  nameAtoZ(value: 'Name: A to Z', type: 'name', order: 'asc'),
  nameZtoA(value: 'Name: Z to A', type: 'name', order: 'desc'),
  priceLowToHigh(value: 'Price: Low to High', type: 'price', order: 'asc'),
  priceHighToLow(value: 'Price: High to Low', type: 'price', order: 'desc');

  const SortOption(
      {required this.value, required this.type, required this.order});

  final String value;
  final String type;
  final String order;
}
