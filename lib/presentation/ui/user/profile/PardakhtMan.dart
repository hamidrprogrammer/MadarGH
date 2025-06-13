// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class PardakhtMan extends StatelessWidget {
//   const PardakhtMan({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F8FC),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF9E3840),
//         elevation: 0,
//         leading: IconButton(
//           icon: Image.asset('assets/huge-icon-arrows-outline-arrow-left.svg'),
//           onPressed: () {}, // Add back button functionality here
//         ),
//         title: const Text(
//           'پرداختی های من',
//           style: TextStyle(
//             fontFamily: 'IRANSansXFaNum',
//             fontWeight: FontWeight.w600,
//             fontSize: 16,
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             Container(
//               height: 199,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/rectangle-39623.svg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildRow('شماره فاکتور', '25639'),
//                     _buildDivider(),
//                     _buildRow('تاریخ تراکنش', '1403/02/15'),
//                     _buildDivider(),
//                     _buildRow('مبلغ', '265,235 تومان'),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 12.0),
//             _buildButton(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildRow(String title, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontFamily: 'IRANSansXFaNum',
//             fontWeight: FontWeight.w500,
//             fontSize: 14,
//             color: const Color(0xFF353842),
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//         Text(
//           title,
//           style: TextStyle(
//             fontFamily: 'IRANSansXFaNum',
//             fontWeight: FontWeight.w500,
//             fontSize: 12,
//             color: const Color(0xFF353842),
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//       ],
//     );
//   }

//   Widget _buildDivider() {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4.0),
//       height: 1,
//       color: Colors.grey[300],
//     );
//   }

//   Widget _buildButton() {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       width: 295,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: const Color(0xFF9E3840)),
//       ),
//       child: Center(
//         child: Text(
//           'مشاهده فاکتور',
//           style: TextStyle(
//             fontFamily: 'IRANSansXFaNum',
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//             color: const Color(0xFF9E3840),
//           ),
//           textDirection: TextDirection.rtl,
//         ),
//       ),
//     );
//   }
// }
