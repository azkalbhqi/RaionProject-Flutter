// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors, depend_on_referenced_packages, use_build_context_synchronously, avoid_print, use_super_parameters

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:CampVestor/pages/notification_page.dart';
import 'package:CampVestor/pages/stocks_detail_page.dart';
import '../styles/styles.dart';
import './widget/buttons.dart';
import 'interface.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

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
    final response = await http.get(Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/stocks'));
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
                return GestureDetector(
                  onTap: () {
                    // Navigate to stock detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StockDetails(stock: stock,),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(stock.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Price: \$${stock.price.toStringAsFixed(2)}'),
                      ],
                    ),
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
Future<void> buyStock(BuildContext context, Stock stock) async {
  final Uri url = Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/log');

  try {
    // Generate timestamp
    DateTime timestamp = DateTime.now();

    // Create the log data
    Map<String, dynamic> logData = {
      'id': stock.id,
      'name': stock.name,
      'price': stock.price,
      'timestamp': timestamp.toIso8601String(),
      'buy': true,
    };

    // Make POST request to log the purchase
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(logData),
    );

    if (response.statusCode == 200) {
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Stock ${stock.name} bought successfully!'),
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
      // Handle error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to log the purchase: ${response.statusCode}'),
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
      print('Failed to log the purchase: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    // Handle error
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
  final String id;
  bool bought; // Add bought property
  String desc;
  String imgUrl;

  Stock({
    required this.name,
    required this.price,
    required this.id,
    required this.bought,
    required this.desc,
    required this.imgUrl,
    
  });

factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      name: json['name'],
      price: json['price'].toDouble(),
      id: json['id'],
      bought: json['bought'],
      desc: json['description'],
      imgUrl:json['profile']
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'bought': bought,
      'description': desc,
      'profile':imgUrl,
    };
   }
}