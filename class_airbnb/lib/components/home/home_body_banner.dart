import 'package:class_airbnb/size.dart';
import 'package:class_airbnb/styles.dart';
import 'package:flutter/material.dart';

class HomeBodyBanner extends StatelessWidget {
  const HomeBodyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: gap_m),
      child: Stack(
        children: [
          _buildBannerImage(),
          _buildBannerCaption(context),
        ],
      ),
    );
  }

  Widget _buildBannerImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        "assets/banner.jpg",
        fit: BoxFit.cover,
        width: double.infinity,
        height: 320,
      ),
    );
  }

  Widget _buildBannerCaption(BuildContext context) {
    double popularItemWidth = getBodyWidth(context);
    return Positioned(
      top: 40,
      left: popularItemWidth < 520 ? 20 : 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: popularItemWidth < 520 ? 300 : 250,
            ),
            child: Text(
              "이제, 여행은 가까운 곳에서",
              style: popularItemWidth < 520
                  ? subTitle1(mColor: Colors.white)
                  : h4(mColor: Colors.white),
            ),
          ),
          SizedBox(height: gap_m),
          Container(
            constraints: BoxConstraints(
              maxWidth: 250,
            ),
            child: Text(
              "새로운 공간에 머물러 보세요. 살아보기, 출장, 여행 등 다양한 목적에 맞는 숙소를 찾아보세요.",
              style: popularItemWidth < 520
                  ? subTitle2(mColor: Colors.white)
                  : subTitle1(mColor: Colors.white),
            ),
          ),
          SizedBox(height: popularItemWidth < 520 ? gap_xl : gap_m),
          SizedBox(
            height: 35,
            width: 170,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
              onPressed: () {},
              child: Text(
                "가까운 여행지 둘러보기",
                style: subTitle2(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
