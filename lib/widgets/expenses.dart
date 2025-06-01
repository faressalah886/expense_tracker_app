import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expences_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  void _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? expensesString = prefs.getString('expenses');
    if (expensesString != null) {
      final List<dynamic> expensesJson = jsonDecode(expensesString);
      setState(() {
        _registeredExpenses.addAll(
            expensesJson.map((json) => Expense.fromJson(json)).toList());
      });
    }
  }

  void _saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final String expensesString = jsonEncode(
        _registeredExpenses.map((expense) => expense.toJson()).toList());
    prefs.setString('expenses', expensesString);
  }

  void openAddExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
    _saveExpenses();
  }

  void _deleteExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    _saveExpenses();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
            _saveExpenses();
          },
        ),
      ),
    );
  }

  double get totalAmount {
    return _registeredExpenses.fold(0.0, (sum, item) => sum + item.amount);
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text('No Expenses found, start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent =
          ExpensesList(expenses: _registeredExpenses, onDelete: _deleteExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Expenses Tracker - Total: \$${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: openAddExpense)],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
