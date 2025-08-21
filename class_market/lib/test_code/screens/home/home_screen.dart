import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text("부산진구"), Icon(Icons.keyboard_arrow_down)],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.list)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              indent: 16,
              endIndent: 16,
              thickness: 1,
            )),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        separatorBuilder: (context, index) {
          return Divider(
            indent: 16,
            endIndent: 16,
            thickness: 1,
          );
        },
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          return Container(
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  product.urlToImage,
                  height: 115,
                  width: 115,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.title),
                    Text("${product.address} * ${product.publishedAt}"),
                    Text("${product.price}원"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                            visible: product.commentsCount > 0,
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.chat_bubble),
                                SizedBox(width: 4),
                                Text("${product.commentsCount}")
                              ],
                            )),
                        SizedBox(width: 8),
                        Visibility(
                            visible: product.heartCount > 0,
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.heart),
                                SizedBox(width: 4),
                                Text("${product.heartCount}")
                              ],
                            )),
                      ],
                    )
                  ],
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
