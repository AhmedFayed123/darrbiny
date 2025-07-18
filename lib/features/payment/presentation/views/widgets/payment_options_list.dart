import 'package:flutter/material.dart';
import 'visa_card_item.dart';

class VisaCardList extends StatefulWidget {
  const VisaCardList({super.key});

  @override
  State<VisaCardList> createState() => _VisaCardListState();
}

class _VisaCardListState extends State<VisaCardList> {
  int selectedIndex = 0;

  final List<String> cardNames = ['فيزا', 'ماستر كارد', 'بطاقة آخرى'];
  final List<String> logos = [
    'https://upload.wikimedia.org/wikipedia/commons/4/41/Visa_Logo.svg',
    'https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg',
    'https://upload.wikimedia.org/wikipedia/commons/5/5e/Generic_credit_card_icon.svg',
  ];


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: cardNames.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => setState(() {
              selectedIndex = index;
            }),
            child: VisaCardItem(
              title: cardNames[index],
              logoUrl: logos[index],
              isSelected: selectedIndex == index,
            ),
          );
        },
      ),
    );
  }
}
