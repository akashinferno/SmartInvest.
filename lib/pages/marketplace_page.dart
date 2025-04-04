import 'package:flutter/material.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

  final List<ProductItem> products = const [
    ProductItem(name: 'Real Estate', icon: Icons.home),
    ProductItem(name: 'Gold', icon: Icons.monetization_on),
    ProductItem(name: 'Mutual Funds', icon: Icons.pie_chart),
    ProductItem(name: 'FD', icon: Icons.savings),
    ProductItem(name: 'Stocks', icon: Icons.trending_up),
    ProductItem(name: 'Bonds', icon: Icons.attach_money),
    ProductItem(name: 'Insurance', icon: Icons.security),
    ProductItem(name: 'Loans', icon: Icons.credit_card),
    // Add more product categories as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Browse by Products',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            GridView.count(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // To disable GridView's scrolling
              crossAxisCount: 2, // Display products in 2 columns
              childAspectRatio: 1.5, // Adjust as needed for box proportions
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              children: products.map((product) {
                return _buildProductBox(context, product);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductBox(BuildContext context, ProductItem product) {
    return InkWell(
      onTap: () {
        // Add navigation or action for when a product is tapped
        print('${product.name} tapped!');
        // You can navigate to a specific page for each product here
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                product.icon,
                size: 36.0,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8.0),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final IconData icon;

  const ProductItem({required this.name, required this.icon});
}
