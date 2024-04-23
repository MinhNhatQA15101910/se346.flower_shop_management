enum OrderStatus {
  pending(value: 'Small'),
  in_delivery(value: 'Medium'),
  received(value: 'Standard');

  const OrderStatus({required this.value});

  final String value;
}
