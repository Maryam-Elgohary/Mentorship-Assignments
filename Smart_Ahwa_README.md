# Smart Ahwa Manager App

## Overview
The **Smart Ahwa Manager App** is a simple Flutter application designed to help coffee shop (Ahwa) owners in Cairo streamline daily operations.  
It allows the owner to add new orders with customer names, drink types, and special requests, track pending orders, and generate sales reports showing the most popular drinks.

---

## Features
- Add new orders (customer name + drink type + special request).
- Track pending orders and mark them as completed.
- Generate a sales report with top-selling drinks.
- Simple, user-friendly UI built with Flutter.

---

## Tech Stack
- **Language**: Dart  
- **Framework**: Flutter  
- **Concepts**: OOP (Inheritance, Encapsulation, Abstraction) + SOLID Principles  

---

## OOP & SOLID in Action
- **Inheritance**: Drinks (`Shai`, `TurkishCoffee`, `Hibiscus`) inherit from the `Drink` base class.  
- **Encapsulation**: The order state (`completed` or not) is protected inside the `Order` class.  
- **Abstraction**: `Drink` is used as a base class to ensure flexibility and modularity.  
- **SRP (Single Responsibility Principle)**: `OrderManager` is only responsible for handling orders.  
- **OCP (Open/Closed Principle)**: You can add new drink types without changing existing code.  
- **LSP**: all drinks (Shai, TurkishCoffee, Hibiscus) can replace each other as Drink objects without breaking the app.
---

## Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/your-username/smart-ahwa-manager.git
cd smart-ahwa-manager
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the app
```bash
flutter run
```
