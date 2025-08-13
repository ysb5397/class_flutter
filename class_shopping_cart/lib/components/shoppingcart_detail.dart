import 'package:class_shopping_cart/components/shoppingcart_header.dart';
import 'package:class_shopping_cart/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShoppingcartDetail extends StatefulWidget {
  const ShoppingcartDetail({super.key});

  @override
  State<ShoppingcartDetail> createState() => _ShoppingcartDetailState();
}

class _ShoppingcartDetailState extends State<ShoppingcartDetail> {
  int id = ShoppingcartHeader.selectedId;
  List<String> vehicles = [
    "Urban Cycle AL 2.0",
    "Urban Bike AL 50.0",
    "Urban Soft AL 10.0",
    "Urban Jet AL 300.0",
  ];

  List<String> costs = [
    "\$149",
    "\$499",
    "\$699",
    "\$120,000",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          )),
      child: Column(
        children: [
          _buildDetailNameAndPrice(),
          _buildDetailRatingAndReviewCount(),
          _buildDetailColorOptions(),
          _buildDetailButton(context)
        ],
      ),
    );
  }

  Widget _buildDetailButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  "정말로 담으시겠습니까?",
                  style: TextStyle(color: Colors.red),
                ),
                content: Text("담은 아이템은 장바구니에 추가됩니다."),
                actions: [
                  CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "취소",
                        style: TextStyle(color: Colors.black),
                      )),
                  CupertinoDialogAction(
                      onPressed: () {},
                      child: Text(
                        "확인",
                        style: TextStyle(color: Colors.blueAccent),
                      ))
                ],
              );
            });
      },
      style: TextButton.styleFrom(
          backgroundColor: kAccentColor,
          minimumSize: Size(300, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(
        "Add to Cart",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDetailColorOptions() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Color Options"),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              _buildDetailIcon(Colors.black),
              _buildDetailIcon(Colors.green),
              _buildDetailIcon(Colors.orange),
              _buildDetailIcon(Colors.grey),
              _buildDetailIcon(Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailIcon(Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, border: Border.all()),
          ),
          Positioned(
            left: 5,
            top: 5,
            child: ClipOval(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildDetailRatingAndReviewCount() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          Spacer(),
          Text("review "),
          Text(
            "(26)",
            style: TextStyle(color: Colors.blue),
          )
        ],
      ),
    );
  }

  Padding _buildDetailNameAndPrice() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            vehicles[id],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            costs[id],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
