import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import '../../controllers/providers/connectivity_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Url = "https://www.google.com/";
  String SelectedOption = "Option 1";
  List bookMark = [];
  List urlBookmark1 = [];
  String urlBookmark = "";

  TextEditingController searchController = TextEditingController();

  InAppWebViewController? inAppWebViewController;
  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(
          color: Colors.blue,
        ),
        onRefresh: () async {
          await inAppWebViewController?.reload();
        });
    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkInternetConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Browser"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Option 1",
                child: Row(
                  children: [
                    const Icon(Icons.bookmark_add_outlined,
                        color: Colors.black),
                    const Text("All BookMark"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: "Option 2",
                child: Row(
                  children: [
                    const Icon(Icons.laptop, color: Colors.black),
                    const Text("Search Engine"),
                  ],
                ),
              ),
            ],
            onSelected: (selectedOption) {
              setState(() {
                SelectedOption = selectedOption;
              });
              if (selectedOption == "Option 1") {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: 600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: Icon(
                                          Icons.close,
                                        ),
                                      ),
                                      Text(
                                        "Dismiss",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 10,
                            child: Container(
                              child: ListView.builder(
                                itemCount: bookMark.length,
                                itemBuilder: (context, i) => ListTile(
                                  title: Text("${urlBookmark1[i]}"),
                                  subtitle: Text("${bookMark[i]}"),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        bookMark.remove(bookMark[i]);
                                        urlBookmark1.remove(urlBookmark1[i]);
                                        Navigator.of(context).pop();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (selectedOption == "Option 2") {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Search Engine"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile(
                            title: Text("Google"),
                            value: "https://www.google.com/",
                            groupValue: Url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                Url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(Url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Yahoo"),
                            value: "https://in.search.yahoo.com/?fr2=inr",
                            groupValue: Url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                Url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(Url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Bing"),
                            value: "https://www.bing.com/",
                            groupValue: Url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                Url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(Url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                          RadioListTile(
                            title: Text("Duck Duck Go"),
                            value: "https://duckduckgo.com/",
                            groupValue: Url,
                            onChanged: (val) {
                              setState(() {
                                searchController.clear();
                                Url = val!;
                              });
                              inAppWebViewController!.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(Url),
                                ),
                              );
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }
            },
          ),
        ],
      ),
      body: (Provider.of<ConnectivityProvider>(context)
          .connectivityModal
          .connectivityStatus ==
          "waiting")
          ? Center(
        child: Column(
          children: [
            SizedBox(
              height: 250,
            ),
            CircularProgressIndicator(),
            SizedBox(
              height: 50,
            ),
            Text(
              "Check Internet Connection",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 18,
              child: InAppWebView(
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: (controller) {
                  inAppWebViewController = controller;
                },
                onLoadStart: (controller, url) {
                  setState(() {
                    inAppWebViewController = controller;
                    urlBookmark = url.toString();
                  });
                },
                onLoadStop: (controller, url) async {
                  await pullToRefreshController.endRefreshing();
                },
                initialUrlRequest: URLRequest(
                  url: Uri.parse(Url),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      String newLink = searchController.text;
                      inAppWebViewController?.loadUrl(
                        urlRequest: URLRequest(
                          url: Uri.parse("${Url}search?q=$newLink"),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async {
                      await inAppWebViewController?.loadUrl(
                        urlRequest: URLRequest(
                          url: Uri.parse(Url),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.home,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // BookMark.add(urlBookmark);
                      urlBookmark1.add(
                        await inAppWebViewController?.getTitle(),
                      );
                      bookMark.add(
                        await inAppWebViewController?.getUrl(),
                      );
                      print("-------------");
                      print(await inAppWebViewController?.getUrl());
                      print("-------------");
                    },
                    icon: Icon(
                      Icons.bookmark_add_outlined,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (await inAppWebViewController!.canGoBack()) {
                        await inAppWebViewController?.goBack();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await inAppWebViewController?.reload();
                    },
                    icon: Icon(
                      Icons.refresh,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (await inAppWebViewController!.canGoForward()) {
                        await inAppWebViewController?.goForward();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}