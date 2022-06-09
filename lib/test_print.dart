import 'package:esc_pos_utils_plus/esc_pos_utils.dart';

class TestPrint {
  static Future<List<int>> getTicket() async {
    List<int> bytes = [];
    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    bytes += generator.setGlobalFont(PosFontType.fontA);
    bytes += generator.text("Ferns IT Solutions",
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    bytes += generator.text(
        "330a Ipswich Rd, Colchester CO4 0ET",
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text(
        "United Kingdom",
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Tel: +91 123457890',
        styles: const PosStyles(align: PosAlign.center));

    bytes += generator.hr();
    bytes += generator.row([
     
      PosColumn(
          text: 'Item',
          width: 4,
          styles: const PosStyles(align: PosAlign.left, bold: true)),
      PosColumn(
          text: 'Price',
          width: 4,
          styles: const PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Qty',
          width: 2,
          styles: const PosStyles(align: PosAlign.center, bold: true)),
      PosColumn(
          text: 'Total',
          width: 2,
          styles: const PosStyles(align: PosAlign.right, bold: true)),
    ]);

    bytes += generator.row([
      
      PosColumn(
          text: "HP Laptop 15s",
          width: 4,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "£ 399.00",
          width: 4,
          styles: const PosStyles(
            align: PosAlign.center,
            codeTable: 'CP1252'
          )),
      PosColumn(
          text: "1", width: 2, styles: const PosStyles(align: PosAlign.center)),
      PosColumn(
          text: "£ 399.00", width: 2, styles: const PosStyles(align: PosAlign.right, codeTable: 'CP1252')),
    ]);

    bytes += generator.row([
      
      PosColumn(
          text: "Lenovo 300 Mouse",
          width: 4,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "£ 3000.00",
          width: 4,
          styles: const PosStyles(
            align: PosAlign.center,
            codeTable: 'CP1252'
          )),
      PosColumn(
          text: "2", width: 2, styles: const PosStyles(align: PosAlign.center)),
      PosColumn(
          text: "£ 60.00", width: 2, styles: const PosStyles(align: PosAlign.right, codeTable: 'CP1252')),
    ]);

    bytes += generator.row([
      PosColumn(
          text: "Lenovo Keyboard",
          width: 4,
          styles: const PosStyles(
            align: PosAlign.left,
          )),
      PosColumn(
          text: "£ 50.00",
          width: 4,
          styles: const PosStyles(
            align: PosAlign.center,
            codeTable: 'CP1252'
          )),
      PosColumn(
          text: "2", width: 2, styles: const PosStyles(align: PosAlign.center)),
      PosColumn(
          text: "£ 100.00", width: 2, styles: const PosStyles(align: PosAlign.right, codeTable: 'CP1252')),
    ]);

    bytes += generator.hr();

    bytes += generator.row([
      PosColumn(
          text: 'TOTAL',
          width: 6,
          styles: const PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text: "£ 559.00",
          width: 6,
          styles: const PosStyles(
            align: PosAlign.center,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
            codeTable: 'CP1252'
          )),
    ]);

    bytes += generator.hr(ch: '=', linesAfter: 1);

    // ticket.feed(2);
    bytes += generator.text('Thank you!',
        styles: const PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.text("09-06-2022 15:22:45",
        styles: const PosStyles(align: PosAlign.center), linesAfter: 1);

    bytes += generator.text(
        'SAVE PAPER SAVE TREE',
        styles: const PosStyles(align: PosAlign.center, bold: false));
    bytes += generator.cut();
    return bytes;
  }
}
