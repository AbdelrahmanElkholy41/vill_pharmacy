import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class pharmacyResponsible extends StatelessWidget {
  const pharmacyResponsible({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBBF7D0)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('🧑‍⚕️',
                  style: TextStyle(fontSize: 28)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('صيدلية النور',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827))),
                  SizedBox(height: 4),
                  Row(children: [
                    Text('⭐',
                        style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Text('4.5',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280))),
                    SizedBox(width: 6),
                    Text('•',
                        style: TextStyle(
                            color: Color(0xFF9CA3AF))),
                    SizedBox(width: 6),
                    Text('١٢٠+ طلب',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280))),
                  ]),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Divider(color: Color(0xFFDCFCE7)),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('شارع الجمهورية - وسط البلد',
                  style: TextStyle(
                      fontSize: 13, color: Color(0xFF374151))),
              SizedBox(width: 6),
              Text('📍', style: TextStyle(fontSize: 13)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('010 1234 5678',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF22C55E),
                      fontWeight: FontWeight.w600)),
              SizedBox(width: 6),
              Text('📞', style: TextStyle(fontSize: 13)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('وقت التوصيل المتوقع: ٢٠ دقيقة',
                  style: TextStyle(
                      fontSize: 13, color: Color(0xFF374151))),
              SizedBox(width: 6),
              Text('🕐', style: TextStyle(fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}
