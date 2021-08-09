import 'package:flutter/material.dart';
import 'package:flutter_news_app/provider/news_provider.dart';
import 'package:flutter_news_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => NewsProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<NewsProvider>().getNewsApi();
  }

  @override
  Widget build(BuildContext context) {
    var list = context.watch<NewsProvider>().news;
    return MaterialApp(
      title: 'News Apps',
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemeProvider>().theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('News Apps'),
          actions: [
            Icon(context.watch<ThemeProvider>().isLight
                ? Icons.light_mode
                : Icons.dark_mode),
            Switch(
                value: context.watch<ThemeProvider>().isLight,
                activeColor: Colors.amber,
                onChanged: (i) {
                  context.read<ThemeProvider>().changeTheme();
                }),
          ],
        ),
        body: !context.watch<NewsProvider>().isLoading
            ? list.length != 0
                ? Center(
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var item = list[index];
                        return Container(
                          margin: EdgeInsets.only(
                              top: 10,
                              bottom: index == list.length - 1 ? 20 : 0),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Image.network(item.urlToImage,
                                        fit: BoxFit.cover),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      item.description,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 5,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Upps, something when wrong. Please try again later',
                        ),
                      ],
                    ),
                  )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
