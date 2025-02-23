import 'package:flutter/material.dart';

class InvestmentTopic {
  final String title;
  final String imageUrl;
  final Widget page; // Add page property

  InvestmentTopic({
    required this.title,
    required this.imageUrl,
    required this.page,
  });
}

class HomePage extends StatelessWidget {
  final List<InvestmentTopic> topics = [
    InvestmentTopic(
      title: "Stock Market Basics",
      imageUrl: "https://placeholder.com/150",
      page: StockBasicsPage(), // Create these pages separately
    ),
    InvestmentTopic(
      title: "Mutual Funds",
      imageUrl: "https://placeholder.com/150",
      page: MutualFundsPage(), //link to mutual funds page
    ),
    // ... other topics ...
  ];

  @override
  Widget build(BuildContext context) {
    // Previous build method remains same until _buildTopicCard
    return Scaffold(
      appBar: AppBar(
        title: Text("SmartInvest."),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "What do you want to learn?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: topics
                    .map((topic) => _buildTopicCard(context, topic))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, InvestmentTopic topic) {
    return InkWell(
      // Makes the card clickable
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => topic.page),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 40,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                topic.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StockBasicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Market Basics'),
      ),
      body: Center(
        child: Text('Stock Market Basics Content'),
      ),
    );
  }
}

class MutualFundsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutual Funds Basics'),
      ),
      body: Center(
        child: Text('Mutual Funds Basics Content'),
      ),
    );
  }
}
