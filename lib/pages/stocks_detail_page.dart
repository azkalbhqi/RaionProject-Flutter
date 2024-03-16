// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'package:flutter/material.dart';
import 'package:raionapp/pages/market_page.dart';

class StockDetails extends StatefulWidget {
  final Stock stock;

  const StockDetails({Key? key, required this.stock}) : super(key: key);

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.stock.name, // Display stock name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Price: \$${widget.stock.price.toStringAsFixed(2)}', // Display stock price
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Quantity: ${widget.stock.id}', // Display quantity of stocks
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
