// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/styles.dart';
import './widget/buttons.dart';
import 'interface.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market'),
      ),
      body: ListView.builder(
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];

          return ListTile(
            title: Text(stock.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Price: \$${stock.price.toStringAsFixed(2)}'),
                Text('Quantity Available: ${stock.quantity}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                // Add logic to handle purchasing the stock
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Purchase Confirmation'),
                    content: Text('Are you sure you want to buy ${stock.name}?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Add logic to confirm purchase
                          Navigator.of(context).pop();
                        },
                        child: Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Buy'),
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

// Example stocks available for purchase
List<Stock> stocks = [
  Stock(name: 'Apple', price: 150.0, quantity: 20),
  Stock(name: 'Google', price: 2000.0, quantity: 10),
  Stock(name: 'Amazon', price: 3500.0, quantity: 5),
];
