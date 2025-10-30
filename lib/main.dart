import 'package:flutter/material.dart';

void main() {
  runApp(CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Coffee Shop',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.brown[50],
      ),
      home: HomePage(),
    );
  }
}

class Coffee {
  final String name;
  final String image;
  final double price;

  Coffee({required this.name, required this.image, required this.price});
}

class HomePage extends StatelessWidget {
  final List<Coffee> coffeeList = [
    Coffee(
      name: 'Cappuccino',
      image:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=400&q=80',
      price: 4.0,
    ),
    Coffee(
      name: 'Latte',
      image:
          'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?auto=format&fit=crop&w=400&q=80',
      price: 4.5,
    ),
    Coffee(
      name: 'Espresso',
      image:
          'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?auto=format&fit=crop&w=400&q=80',
      price: 3.0,
    ),
    Coffee(
      name: 'Americano',
      image:
          'https://images.unsplash.com/photo-1511920170033-f8396924c348?auto=format&fit=crop&w=400&q=80',
      price: 3.5,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Coffee Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: coffeeList.length,
          itemBuilder: (context, index) {
            final coffee = coffeeList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CoffeeDetailPage(coffee: coffee),
                  ),
                );
              },
              child: Card(
                color: Colors.brown[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        coffee.image,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      coffee.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('\$${coffee.price.toStringAsFixed(2)}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CoffeeDetailPage extends StatelessWidget {
  final Coffee coffee;

  CoffeeDetailPage({required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coffee.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              coffee.image,
              height: 300,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
            ),
            SizedBox(height: 16),
            Text(
              coffee.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${coffee.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, color: Colors.brown[700]),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add to cart functionality
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}