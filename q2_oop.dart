// ข้อ 2.5: การแจงนับ (Enum) สำหรับเก็บสถานะ
enum OrderStatus { pending, paid, cancelled }

// ฟังก์ชันแยกสำหรับพิมพ์สถานะตามเงื่อนไขข้อ 2.5
void printStatus(OrderStatus status) {
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

// ข้อ 2.1: คลาสนามธรรม (Abstraction)
abstract class MenuItem {
  final String name;
  final double basePrice;

  // ข้อ 2.5: สมาชิกแบบสถิต (Static) นับจำนวนอ็อบเจกต์
  static int itemCount = 0;

  MenuItem(this.name, this.basePrice) {
    // บวกค่าเมื่อมีการสร้างอ็อบเจกต์ใหม่ทุกครั้ง
    itemCount++;
  }

  // ข้อ 2.1: เมธอตนามธรรม (แก้ไขเอาเนื้อหาเดิมออก)
  double price();

  // ข้อ 2.1: เมธอด show เรียกใช้ price() ที่จะถูกลูกสืบทอดไป
  void show() {
    print('$name ${price()} บาท');
  }
}

// ข้อ 2.2: การสืบทอด (Inheritance) - เครื่องดื่ม
class Drink extends MenuItem {
  int toppings;

  Drink(String name, double basePrice, this.toppings) : super(name, basePrice);

  @override
  double price() => basePrice + (10 * toppings);
}

// ข้อ 2.2: การสืบทอด (Inheritance) - อาหาร
class Food extends MenuItem {
  String size;

  Food(String name, double basePrice, this.size) : super(name, basePrice);

  @override
  double price() {
    double multiplier = 1.0;
    // ใช้คำสั่งเลือกทำแบบเทียบค่าคงที่ (switch) ตามที่โจทย์กำหนด
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
    }
    return basePrice * multiplier;
  }
}

// ข้อ 2.4: การห่อหุ้ม (Encapsulation)
class Wallet {
  double _balance = 0; // ฟิลด์ส่วนตัวซ่อนไว้

  // getter เปิดให้อ่าน
  double get balance => _balance;

  // setter เปิดให้เขียนและตรวจสอบเงื่อนไข
  set balance(double value) {
    if (value < 0) {
      print('ผิดพลาด: ยอดเงินติดลบไม่ได้');
    } else {
      _balance = value;
    }
  }

  // เมธอดรับชำระเงิน
  bool pay(double amount) {
    if (_balance >= amount) {
      _balance -= amount; // หักเงิน
      return true;
    } else {
      print('ยอดเงินไม่พอ');
      return false; // ไม่หักเงิน
    }
  }
}

void main() {
  // ข้อ 2.3: พหุสัณฐาน (Polymorphism) ใช้ List ที่เป็นคลาสแม่บรรจุคลาสลูก
  List<MenuItem> order = [
    Drink('ลาเต้', 55.0, 1),
    Food('ข้าวผัด', 60.0, 'L'),
    Drink('อเมริกาโน่', 45.0, 0),
  ];

  double total = 0;
  // วนลูปโดยไม่ต้องเช็คชนิดด้วย if/is
  for (var item in order) {
    item.show();
    total += item.price();
  }
  print('ยอดรวมทั้งสิ้น: $total บาท');
  print('---');

  // ข้อ 2.4: การจำลองระบบ Wallet
  Wallet myWallet = Wallet();

  // ทดสอบ 1: ป้อนค่าติดลบ
  myWallet.balance = -50;

  // กำหนดเงินตั้งต้น
  myWallet.balance = 300;

  // ทดสอบ 2: จ่ายเงินสำเร็จ
  if (myWallet.pay(total)) {
    print('ชำระเงินสำเร็จ');
    printStatus(OrderStatus.paid);
  } else {
    printStatus(OrderStatus.pending);
  }
  print('ยอดคงเหลือ : ${myWallet.balance} บาท');
  print('---');

  // ทดสอบ 3: ยอดเงินไม่พอ (จำลองจ่ายอีก 500)
  if (myWallet.pay(500)) {
    print('ชำระเงินสำเร็จ');
  } else {
    printStatus(OrderStatus.pending);
  }
  print('ยอดคงเหลือ : ${myWallet.balance} บาท');
  print('---');

  // ข้อ 2.5: เรียกดูค่า Static จากชื่อคลาส
  print('จำนวนรายการเมนูที่ถูกสร้าง: ${MenuItem.itemCount}');
}
