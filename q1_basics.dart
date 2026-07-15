void main() {
  final double vatRate = 0.07;
  const String shopName = 'Dart Cafe';
  print('ร้านค้า : $shopName');
  print('อัตราภาษี (vatRate) : $vatRate');
  print('---');

  List<String> categories = ['เครื่องดื่ม', 'ของคาว', 'ของหวาน'];
  print("หมวดเมนู : ${categories}");

  Map<String, int> menu = {
    'ลาเต้': 55,
    'สปาเก็ตตี้': 69,
    'น้ำองุ่น': 39,
    'ข้าวผัด': 60,
  };
  print('จำนวนเมนูทั้งหมด : ${menu.length}');
  print('ราคาลาเต้ : ${menu["ลาเต้"]} บาท');
}
