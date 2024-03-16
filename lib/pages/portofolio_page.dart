// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors, unused_label, unnecessary_null_comparison, depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      final response = await http.get(Uri.parse('http://localhost:3000/stocks'));
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