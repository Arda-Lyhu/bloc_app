class OrderEntity {
  final String orderNumber;
  final String date;
  final int quantity;
  final double totalAmount;
  final String status; // Delivered, Processing, Cancelled

  const OrderEntity({
    required this.orderNumber,
    required this.date,
    required this.quantity,
    required this.totalAmount,
    required this.status,
  });
}
