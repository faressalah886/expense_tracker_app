import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category {
  general,
  food,
  transportation,
  entertainment,
  shopping,
  health,
  work,
  others,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.entertainment: Icons.movie,
  Category.health: Icons.health_and_safety,
  Category.shopping: Icons.shopping_bag,
  Category.transportation: Icons.directions_car,
  Category.work: Icons.work,
  Category.general: Icons.category,
  Category.others: Icons.more_horiz,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate => DateFormat.yMMMd().format(date);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.index,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: Category.values[json['category']],
    );
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenses,
  });
  ExpenseBucket.forCategory(this.category, List<Expense> allExpenses)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
