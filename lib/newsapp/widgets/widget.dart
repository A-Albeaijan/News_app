import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../models/webview/webviewScreen.dart';

class ReWidget {
  static Widget ArticleCard(var art, context) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(
                url: '${art['url']}',
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: art['urlToImage'] != null
                        ? NetworkImage('${art['urlToImage']}')
                        : const NetworkImage(
                            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${art['title']}',
                          style: Theme.of(context).textTheme.bodyText1,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '${art['publishedAt']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  static Widget artBuilder(list, {isSearch = false}) => ConditionalBuilder(
        condition: list.length > 0,
        builder: (context) => ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              ReWidget.ArticleCard(list[index], context),
          itemCount: 10,
        ),
        fallback: (context) => isSearch == true
            ? Container()
            : const Center(child: CircularProgressIndicator()),
      );
}
