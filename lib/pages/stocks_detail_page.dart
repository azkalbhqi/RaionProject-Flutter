import 'package:CampVestor/pages/widget/buttons.dart';
import 'package:CampVestor/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:CampVestor/pages/market_page.dart';

class StockDetails extends StatefulWidget {
  final Stock stock;

  const StockDetails({required this.stock});

  @override
  _StockDetailsState createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  late bool bought;

  @override
  void initState() {
    super.initState();
    bought = widget.stock.bought;
  }

  Future<void> buyStock() async {
    try {
      // Update the bought status
      final updatedStock = Stock(
        id: widget.stock.id,
        name: widget.stock.name,
        price: widget.stock.price,
        desc: widget.stock.desc,
        bought: true,
        imgUrl: widget.stock.imgUrl,
      );

      // Make PUT request to update bought status
      await http.put(
        Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/stocks/${widget.stock.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(updatedStock.toJson()),
      );

      // Log the transaction to Log API with formatted date
      final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      final logData = {
        'id': widget.stock.id,
        'name': widget.stock.name,
        'price': widget.stock.price,
        'timestamp': formattedDate,
        'buy': true,
      };

      await http.post(
        Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/log'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(logData),
      );

      // Handle success response
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: Text('Stock ${widget.stock.id} bought successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      // Handle error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error buying stock: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: widget.stock.id,
              child: Image.network(
                widget.stock.imgUrl,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.stock.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Price: Rp${NumberFormat.currency(locale: 'id', symbol: '').format(widget.stock.price)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: ${widget.stock.desc}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Buttons(
              onClicked: buyStock,
              text: 'Buy',
              width: MediaQuery.of(context).size.width, 
              backgroundColor: ColorStyles.primary, 
              fontColor: ColorStyles.white
              
            ),
          ],
        ),
      ),
    );
  }
}
