class Expense {
  final int? id;
  final String name;
  final double amount;
  final DateTime date;
  final String category;

  const Expense({
    this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
    
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'date': date.toIso8601String(), // yyyy-mm-dd
      'category': category,
    };
  }
}
