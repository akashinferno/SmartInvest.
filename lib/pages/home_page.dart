import 'package:flutter/material.dart';
import 'package:smart_invest_1/pages/stock_basics.dart';

class InvestmentTopic {
  final String title;
  final String imageUrl;
  final Widget page;

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
      page: StockBasicsPage(),
    ),
    InvestmentTopic(
      title: "Mutual Funds",
      imageUrl: "https://placeholder.com/150",
      page: MutualFundsPage(),
    ),
    InvestmentTopic(
      title: "Bonds & Fixed Income Investments",
      imageUrl: "https://placeholder.com/150",
      page: BondsFixedIncomePage(),
    ),
    InvestmentTopic(
      title: "Real Estate Investments",
      imageUrl: "https://placeholder.com/150",
      page: RealEstateInvestmentsPage(),
    ),
    InvestmentTopic(
      title: "Gold & Commodities",
      imageUrl: "https://placeholder.com/150",
      page: GoldCommoditiesPage(),
    ),
    InvestmentTopic(
      title: "Exchange-Traded Funds (ETFs)",
      imageUrl: "https://placeholder.com/150",
      page: ETFsPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SmartInvest."),
        centerTitle: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                // No action needed
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                side: BorderSide(color: Colors.white, width: 1), // Added border
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Optional: Rounded corners
                ),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    "English",
                  ),
                  SizedBox(width: 4),
                  Text(
                    "🇬🇧", // "En" symbol (using the UK flag emoji as a common representation)
                  ),
                ],
              ),
            ),
          ),
        ],
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
              // Container with fixed height to prevent overflow
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
                ),
                child: SizedBox(
                  // Set height based on expected content size
                  height: 3 * 200.0 + 2 * 16.0, // Example: 3 rows and spacing
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: topics.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.8, // Adjusted for more vertical space
                    ),
                    itemBuilder: (context, index) {
                      return _buildTopicCard(context, topics[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, InvestmentTopic topic) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => topic.page),
        );
      },
      child: Container(
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

// Dummy pages
class StockBasicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stock Market Basics')),
      body: Center(child: Text('Stock Market Basics Content')),
    );
  }
}

class MutualFundsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mutual Funds Basics')),
      body: Center(child: Text('Mutual Funds Basics Content')),
    );
  }
}

class BondsFixedIncomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bonds & Fixed Income Investments')),
      body: Center(child: Text('Content for Bonds & Fixed Income Investments')),
    );
  }
}

class RealEstateInvestmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Real Estate Investments')),
      body: Center(child: Text('Content for Real Estate Investments')),
    );
  }
}

class GoldCommoditiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gold & Commodities')),
      body: Center(child: Text('Content for Gold & Commodities')),
    );
  }
}

class ETFsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exchange-Traded Funds (ETFs)')),
      body: Center(child: Text('Content for Exchange-Traded Funds (ETFs)')),
    );
  }
}
