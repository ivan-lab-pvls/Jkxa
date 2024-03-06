import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smartspend_app/repository/news_repository.dart';
import 'package:smartspend_app/router/router.dart';
import 'package:smartspend_app/screens/news_list/news_info_screen.dart';
import 'package:smartspend_app/theme/colors.dart';
import 'package:smartspend_app/widgets/app_container.dart';

@RoutePage()
class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.headerGrey,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'News',
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
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: newsRepository.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 15),
              itemBuilder: (BuildContext context, int index) {
                final news = newsRepository[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) => NewsInfoScreen(
                              news: news,
                            )));
                  },
                  child: AppContainer(
                    child: Column(
                      children: [
                        Text(
                          news.title,
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
                            news.image,
                            fit: BoxFit.cover,
                            height: 170,
                            width: double.infinity,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
