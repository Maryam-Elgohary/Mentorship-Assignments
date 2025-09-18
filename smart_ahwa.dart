import 'package:flutter/material.dart';

// Base class for a Drink (Abstraction + Encapsulation)
class Drink {
  final String name;
  final double price;

  Drink(this.name, this.price);

  String getDescription() => "$name - $price EGP";
}

// Inheritance: Different drink types extend Drink
class Shai extends Drink {
  Shai() : super("Shai", 10);
}

class TurkishCoffee extends Drink {
  TurkishCoffee() : super("Turkish Coffee", 15);
}

class Hibiscus extends Drink {
  Hibiscus() : super("Hibiscus Tea", 12);
}

// Order class with Encapsulation
class Order {
  final String customerName;
  final Drink drink;
  final String specialRequest;
  bool _isCompleted = false;

  Order(this.customerName, this.drink, {this.specialRequest = ""});

  void markCompleted() {
    _isCompleted = true;
  }

  bool get isCompleted => _isCompleted;
}

// OrderManager applies SRP
class OrderManager {
  final List<Order> _orders = [];

  void addOrder(Order order) {
    _orders.add(order);
  }

  List<Order> getPendingOrders() =>
      _orders.where((order) => !order.isCompleted).toList();

  Map<String, int> generateReport() {
    final report = <String, int>{};
    for (var order in _orders) {
      report[order.drink.name] = (report[order.drink.name] ?? 0) + 1;
    }
    return report;
  }

  List<Order> get allOrders => _orders;
}

void main() {
  runApp(SmartAhwaApp());
}

class SmartAhwaApp extends StatelessWidget {
  final OrderManager manager = OrderManager();

  SmartAhwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Ahwa Manager',
      theme: ThemeData(primarySwatch: Colors.green),
      home: OrderScreen(manager: manager),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final OrderManager manager;
  const OrderScreen({super.key, required this.manager});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _customerController = TextEditingController();
  String? _selectedDrink;
  final _specialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Smart Ahwa Manager",
            style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.brown[50],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 20,
          children: [
            // Customer input
            TextField(
              controller: _customerController,
              cursorColor: Colors.brown,
              decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.brown),
                  labelText: "Customer Name",
                  border: OutlineInputBorder(),
                  hoverColor: Colors.brown,
                  focusColor: Colors.brown),
            ),
            // Drink dropdown
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(5)),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                  isExpanded: true,
                  dropdownColor: Colors.brown[50],
                  icon: Icon(Icons.arrow_drop_down, color: Colors.brown),
                  underline: Container(),
                  menuWidth: MediaQuery.of(context).size.width,
                  hint: const Text("Select Drink",
                      style: TextStyle(color: Colors.brown)),
                  value: _selectedDrink,
                  items: ["Shai", "Turkish Coffee", "Hibiscus Tea"]
                      .map((drink) => DropdownMenuItem(
                            value: drink,
                            child: Text(drink,
                                style: TextStyle(color: Colors.brown)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDrink = value;
                    });
                  },
                ),
              ),
            ),
            // Special request
            TextField(
              controller: _specialController,
              cursorColor: Colors.brown,
              decoration: const InputDecoration(
                  labelText: "Special Request",
                  labelStyle: TextStyle(color: Colors.brown),
                  border: OutlineInputBorder(),
                  hoverColor: Colors.brown,
                  focusColor: Colors.brown),
            ),
            //  const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[50], elevation: 5),
                onPressed: () {
                  if (_customerController.text.isNotEmpty &&
                      _selectedDrink != null) {
                    Drink drink;
                    switch (_selectedDrink) {
                      case "Shai":
                        drink = Shai();
                        break;
                      case "Turkish Coffee":
                        drink = TurkishCoffee();
                        break;
                      case "Hibiscus Tea":
                        drink = Hibiscus();
                        break;
                      default:
                        drink = Shai();
                    }
                    widget.manager.addOrder(Order(
                      _customerController.text,
                      drink,
                      specialRequest: _specialController.text,
                    ));
                    _customerController.clear();
                    _specialController.clear();
                    setState(() {
                      _selectedDrink = null;
                    });
                  }
                },
                child: const Text("Add Order",
                    style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
              ),
            ),
            //  const SizedBox(height: 20),
            const Text("Pending Orders:",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.manager.getPendingOrders().length,
                itemBuilder: (context, index) {
                  final order = widget.manager.getPendingOrders()[index];
                  return ListTile(
                    title: Text("${order.customerName} - ${order.drink.name}"),
                    subtitle: Text(order.specialRequest),
                    trailing: IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          order.markCompleted();
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown[50],
        child: const Icon(Icons.analytics, color: Colors.brown),
        onPressed: () {
          final report = widget.manager.generateReport();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              backgroundColor: Colors.brown[50],
              title: const Text("Sales Report",
                  style: TextStyle(
                      color: Colors.brown, fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                //  mainAxisAlignment: MainAxisAlignment.start,
                children: report.entries
                    .map((e) => Text(
                          "${e.key}:  ${e.value} orders",
                          style: TextStyle(color: Colors.brown, fontSize: 18),
                        ))
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
