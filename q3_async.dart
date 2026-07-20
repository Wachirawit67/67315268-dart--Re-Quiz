// ข้อ 3.1: งานที่ให้ผลลัพธ์ในอนาคต (Future)
Future<Map<String, dynamic>> fetchOrder(int orderId) async {
  // จำลองการหน่วงเวลา 2 วินาที
  await Future.delayed(Duration(seconds: 2));

  // ตรวจสอบเงื่อนไขการโยนข้อผิดพลาด
  if (orderId <= 0) {
    throw Exception('รหัสคำสั่งซื้อไม่ถูกต้อง');
  }

  // คืนค่าข้อมูลออร์เดอร์ (คีย์เป็นข้อความ ค่าเป็นแบบไดนามิก)
  return {'id': orderId, 'menu': 'ลาเต้', 'total': 65.0};
}

// ข้อ 3.3: ลำดับข้อมูลที่ทยอยส่งเข้ามา (Stream)
Stream<String> trackOrder() async* {
  // เว้น 1 วินาที แล้วทยอยปล่อย (yield) ทีละสถานะ
  await Future.delayed(Duration(seconds: 1));
  yield 'รับออร์เดอร์แล้ว';

  await Future.delayed(Duration(seconds: 1));
  yield 'กำลังจัดทำ';

  await Future.delayed(Duration(seconds: 1));
  yield 'จัดส่งเรียบร้อย';
}

// ข้อ 3.2: main แบบอะซิงโครนัส
void main() async {
  print('เริ่มโหลดข้อมูล...');

  // --- กรณีที่ 1: รหัสถูกต้อง ---
  try {
    // ต้องรอผลลัพธ์ด้วย await
    var order = await fetchOrder(7);
    print('ได้ข้อมูลออร์เดอร์: $order');
  } catch (e) {
    print('เกิดข้อผิดพลาด: $e');
  } finally {
    // บล็อกนี้จะถูกเรียกเสมอ
    print('จบรายการ');
  }

  // --- กรณีที่ 2: รหัสไม่ถูกต้อง ---
  try {
    var order = await fetchOrder(0);
    print('ได้ข้อมูลออร์เดอร์: $order');
  } catch (e) {
    // ดักจับเพื่อให้โปรแกรมทำงานต่อได้ ไม่ให้ค้างหรือแครช
    print('เกิดข้อผิดพลาด: $e');
  } finally {
    print('จบรายการ');
  }

  // --- เรียกใช้งาน Stream (จากข้อ 3.3) ---
  // ใช้ await for ในการวนรับค่าทีละตัวจาก Stream
  await for (var status in trackOrder()) {
    print('สถานะ: $status');
  }

  print('ติดตามสถานะเสร็จสิ้น');
}
