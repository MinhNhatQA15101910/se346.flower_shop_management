enum OrderStatus {
  pending(value: 'Pending'),
  in_delivery(value: 'In Delivery'),
  received(value: 'Received');

  const OrderStatus({required this.value});

  final String value;
}
