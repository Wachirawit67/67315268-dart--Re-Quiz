const double vatRate = 0.07;

double calcTotal({required int price, required int qty, double discount = 0}) =>
    (price * qty - discount) * (1 + vatRate);
void main() {
  final String shopName = 'Dart Cafe';
  print('ร้านค้า : $shopName');
  print('อัตราภาษี (vatRate) : $vatRate');
  print('---');

  List<String> categories = ['เครื่องดื่ม', 'ของคาว', 'ของหวาน'];
  print("หมวดเมนู : ${categories}");

  Map<String, int> menu = {
    'ลาเต้': 55,
    'สปาเก็ตตี้': 49,
    'น้ำองุ่น': 39,
    'ข้าวผัด': 60,
  };
  print('จำนวนเมนูทั้งหมด : ${menu.length} รายการ');
  print('ราคาลาเต้ : ${menu["ลาเต้"]} บาท');

  print('---');
  print('เมนูราคาตั้งแต่ 50 บาทขึ้นไป');
  for (var entry in menu.entries) {
    if (entry.value >= 50) {
      print('${entry.value} : ${entry.key}');
    }
  }
  print('---');
  print('ยอดสุทธิ (ไม่มีส่วนลด): ${calcTotal(price: 55, qty: 2)} บาท');
  print(
    'ยอดสุทธิ (ไม่มีส่วนลด): ${calcTotal(price: 55, qty: 2, discount: 10)} บาท',
  );
  print('---');

  String? coupon;
  print('ความยาวคูปอง: ${coupon?.length ?? 0}');

  coupon ??= 'NO-COUPON';
  print('คูปองหลังกำหนดการค่า: $coupon');
}
