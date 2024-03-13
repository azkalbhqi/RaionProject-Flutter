// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/styles.dart';
import './widget/buttons.dart';
import 'interface.dart';

class PortofolioPage extends StatefulWidget {
  const PortofolioPage({super.key});

  @override
  State<PortofolioPage> createState() => _PortofolioPageState();
}

class _PortofolioPageState extends State<PortofolioPage> {
  // Example stocks
  List<Stock> stocks = [
    Stock(name: 'Apple', price: 150.0, quantity: 10),
    Stock(name: 'Google', price: 2000.0, quantity: 5),
    Stock(name: 'Amazon', price: 3500.0, quantity: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Portfolio'),
      ),
      body: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          final double currentValue = stock.price * stock.quantity;
          final double totalInvestment = stock.price * stock.quantity;
          final double percentage = ((currentValue - totalInvestment) / totalInvestment) * 100;

          return ListTile(
            title: Text(stock.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current Value: \$${currentValue.toStringAsFixed(2)}'),
                Text('Profit/Loss: ${percentage.toStringAsFixed(2)}%'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Stock {
  final String name;
  final double price;
  final int quantity;

  Stock({required this.name, required this.price, required this.quantity});
}