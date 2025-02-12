import 'package:flutter/material.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/constants/styles.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  const ItemDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: title.text.color(darkFontGrey).fontFamily(semibold).make(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_border,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
