abstract class MenuItem {
  final String name;
  final double basePrice;

  MenuItem(this.name, this.basePrice);

  double price() => 0.0;

  void show() {
    print('ชื่อ $name - $basePrice บาท');
  }
}

class Drink extends MenuItem {
  int toppings;

  Drink(String name, double basePrice, this.toppings) : super(name, basePrice);

  @override
  double price() => basePrice + (10 * toppings);
}

class Food extends MenuItem {
  double S = 1.0;
  double M = 1.2;
  double L = 1.5;

  Food(String name, double basePrice, this.S) : super(name, basePrice);

  @override
  double price() => basePrice * S;
}

void main() {
  List<MenuItem> order = [
    Drink('ลาเต้', 50.0, 10),
    Food('ข้าวผัด', 50.0, 10.0),
    Drink('อเมริกาโน่', 50.0, 10),
  ];
  Drink.show();
}
