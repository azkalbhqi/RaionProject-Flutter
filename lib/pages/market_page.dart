// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import '../styles/styles.dart';
import './widget/buttons.dart';
import 'interface.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late Future<List<Stock>> _futureStocks;

  @override
  void initState() {
    super.initState();
    _futureStocks = fetchStocks();
  }

  Future<List<Stock>> fetchStocks() async {
    final response = await http.get(Uri.parse('http://localhost:3000/stocks'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Stock.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stocks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market'),
      ),
      body: FutureBuilder<List<Stock>>(
        future: _futureStocks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Stock> stocks = snapshot.data!;
            return ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];
                return ListTile(
                  title: Text(stock.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Price: \$${stock.price.toStringAsFixed(2)}'),
                      Text('Quantity Available: ${stock.id}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Add logic to handle purchasing the stock
                      buyStock(context, stock.id);
                    },
                    child: Text('Buy'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


// Method to handle purchasing the stock
Future<void> buyStock(BuildContext context, int stockId) async {
  final Uri url = Uri.parse('http://localhost:3000/stocks/$stockId');
  try {
    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'bought': true,
      }),
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Stock $stockId bought successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update stock $stockId: ${response.statusCode}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      print('Failed to update stock $stockId: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error buying stock: $error');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('An error occurred while buying stock: $error'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class Stock {
  final String name;
  final double price;
  final int id;
  bool bought; // Add bought property

  Stock({required this.name, required this.price, required this.id, required this.bought});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'],
      price: json['price'].toDouble(),
      id: json['id'],
      bought: json['bought']
    );
  }
}