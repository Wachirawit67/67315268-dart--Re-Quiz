enum OrderStatus { pending, paid, cancelled }

void printOrderStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      print('สถานะ: รอชำระเงิน');
      break;
    case OrderStatus.paid:
      print('สถานะ: ชำระเงินแล้ว');
      break;
    case OrderStatus.cancelled:
      print('สถานะ: ยกเลิกคำสั่งซื้อ');
      break;
  }
}

abstract class MenuItem {
  final String name;
  final double basePrice;

  static int itemCount = 0;

  MenuItem(this.name, this.basePrice) {
    itemCount++;
  }

  double price();

  void show() {
    print('$name - ${price()} บาท');
  }
}

class Drink extends MenuItem {
  int toppings;

  Drink(String name, double basePrice, this.toppings) : super(name, basePrice);

  @override
  double price() => basePrice + (10 * toppings);
}

class Food extends MenuItem {
  String size;

  Food(String name, double basePrice, this.size) : super(name, basePrice);

  @override
  double price() {
    double multiplier;
    switch (size) {
      case 'S':
        multiplier = 1.0;
        break;
      case 'M':
        multiplier = 1.2;
        break;
      case 'L':
        multiplier = 1.5;
        break;
      default:
        multiplier = 1.0;
    }
    return basePrice * multiplier;
  }
}

class Wallet {
  double _balance = 0.0;

  double get balance => _balance;

  set balance(double value) {
    if (value < 0) {
      print('ผิดพลาด: ยอดเงินติดลบไม่ได้');
    } else {
      _balance = value;
    }
  }

  bool pay(double amount) {
    if (_balance >= amount) {
      _balance -= amount;
      return true;
    } else {
      print('ยอดเงินไม่พอ');
      return false;
    }
  }
}

void main() {
  List<MenuItem> order = [
    Drink('ลาเต้', 55.0, 1),
    Food('ข้าวผัด', 60.0, 'L'),
    Drink('อเมริกาโน่', 45.0, 0),
  ];

  double totalAmount = 0.0;

  for (MenuItem item in order) {
    item.show();
    totalAmount += item.price();
  }

  print('ยอดรวมทั้งสิ้น: $totalAmount บาท');

  print('---');

  Wallet myWallet = Wallet();

  myWallet.balance = -50.0;
  myWallet.balance = 300.0;

  if (myWallet.pay(200.0)) {
    print('ชำระเงินสำเร็จ');
    printOrderStatus(OrderStatus.paid);
  }
  print('ยอดคงเหลือ: ${myWallet.balance} บาท');

  if (!myWallet.pay(500.0)) {
    printOrderStatus(OrderStatus.pending);
  }
  print('ยอดคงเหลือ: ${myWallet.balance} บาท');

  print('---');

  print('จำนวนรายการเมนูที่ถูกสร้าง: ${MenuItem.itemCount}');
}
