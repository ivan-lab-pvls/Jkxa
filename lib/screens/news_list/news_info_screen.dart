import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smartspend_app/models/news_model.dart';
import 'package:smartspend_app/theme/colors.dart';
import 'package:smartspend_app/widgets/app_container.dart';

@RoutePage()
class NewsInfoScreen extends StatefulWidget {
  final NewsModel news;

  const NewsInfoScreen({super.key, required this.news});

  @override
  State<NewsInfoScreen> createState() => _NewsInfoScreenState();
}

class _NewsInfoScreenState extends State<NewsInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.headerGrey,
        centerTitle: true,
        title: Text(
          widget.news.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: [
                AppContainer(
                  child: Column(
                    children: [
                      Text(
                        widget.news.title,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image.asset(
                          widget.news.image,
                          fit: BoxFit.cover,
                          height: 170,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                AppContainer(
                  child: Text(
                    widget.news.article,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
