// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors, unused_label, unnecessary_null_comparison, depend_on_referenced_packages, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:raionapp/pages/market_page.dart' as market;
import 'package:http/http.dart' as http;
import 'package:raionapp/pages/stocks_detail_page.dart';
import '../styles/styles.dart';
import './widget/buttons.dart';
import 'interface.dart';

class PortofolioPage extends StatefulWidget {
  const PortofolioPage({super.key});

  @override
  State<PortofolioPage> createState() => _PortofolioPageState();
}

class _PortofolioPageState extends State<PortofolioPage> {
  List<market.Stock> stocks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/stocks'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        
        // Filter stocks where bought is true
        final List<market.Stock> boughtStocks = jsonData
            .map((json) => market.Stock.fromJson(json))
            .where((stock) => stock.bought)
            .toList();

        setState(() {
          stocks = boughtStocks;
        });
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Portfolio'),
      ),
      body: stocks.isNotEmpty
          ? ListView.builder(
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                final stock = stocks[index];
                final double currentValue = stock.price;
                final double totalInvestment = stock.price;
                final double percentage = ((currentValue - totalInvestment) / totalInvestment) * 100;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StockDetails(stock: stock)),
                    );
                  },
                  child: ListTile(
                    title: Text(stock.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Current Value: \$${currentValue.toStringAsFixed(2)}'),
                        Text('Profit/Loss: ${percentage.toStringAsFixed(2)}%'),
                      ],
                    ),
                    trailing: ElevatedButton(
                    onPressed: () {
                      // Add logic to handle purchasing the stock
                      sellStock(context, stock.id);
                    },
                    child: Text('Sell'),
                  ),
                  ),
                  
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

Future<void> sellStock(BuildContext context, String stockId) async {
  final Uri url = Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/stocks/$stockId');
  final logUrl = Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/log');
  
  try {
    // Fetch current stock data
    final http.Response fetchResponse = await http.get(url);
    if (fetchResponse.statusCode != 200) {
      throw Exception('Failed to fetch stock data');
    }
    final Map<String, dynamic> currentStockData = jsonDecode(fetchResponse.body);
    
    // Update the bought status to false
    currentStockData['bought'] = false;

    // Make PUT request with updated stock object
    final http.Response response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(currentStockData),
    );

    if (response.statusCode == 200) {
      // Make POST request to update log
      final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final logData = {
        'id': stockId,
        'name': currentStockData['name'],
        'price': currentStockData['price'],
        'timestamp': formattedDate,
        'buy': false,
      };
      
      await http.post(
        logUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(logData),
      );

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Success'),
          content: Text('Stock $stockId sold successfully!'),
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
    print('Error selling stock: $error');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('An error occurred while selling stock: $error'),
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