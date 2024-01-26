import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class FeedPage extends StatelessWidget {
  FeedPage({Key? key}) : super(key: key);

  final images = [
    'https://4.bp.blogspot.com/-PxqHqglQYu8/XBC4PaO2UXI/AAAAAAABQ1E/gDQvO91Z0qIj5QuIQXlOc4cUJ3E-2Ho_QCLcBGAs/s400/smartphone_sns_jidori_mucha.png',
    'https://play-lh.googleusercontent.com/VRMWkE5p3CkWhJs6nv-9ZsLAs1QOg5ob1_3qg-rckwYW7yp1fMrYZqnEFpk0IoVP4LM',
    // 'https://appliv-domestic.akamaized.net/v1/760x/r/articles/129815/13877626_1604328764_041813000_0_1500_1500.jpeg',
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('フィード')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image.network(
                  'https://appliv-domestic.akamaized.net/v1/760x/r/articles/129815/13877626_1604328764_041813000_0_1500_1500.jpeg',
                  width: 40,
                  height: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'instagram',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'サンディエゴ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: 400,
                initialPage: 0,
                viewportFraction: 1,
              ),
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return InstagramPostItem(imageUrl: images[index]);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.favorite_border),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(CupertinoIcons.chat_bubble),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.send_sharp),
                    ],
                  ),
                ),
                Icon(Icons.bookmark_border),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10, left: 24),
            child: Column(
              children: [
                Text(
                  '「いいね！」704,899件',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 10, left: 24, right: 24),
            child: Column(
              children: [
                Text(
                  'instagram "Style and sustainability don’t have to be two separate things. They can be one and the same, and sustainable living itself should be....',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InstagramPostItem extends StatelessWidget {
  const InstagramPostItem({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: BoxFit.cover,
    );
  }
}
