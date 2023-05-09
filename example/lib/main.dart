import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skeleton_builder/skeleton_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget? overlay;
  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print(_cardKey?.currentContext?.size);
    // });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                final renderBox = _key.currentContext?.findRenderObject() as RenderSkeletonScanner;
                renderBox.visitAll();
              },
              icon: const Icon(Icons.layers_outlined))
        ],
      ),
      body: Stack(
        children: [
          // if(overlay == null)
          Opacity(
            opacity: overlay == null ? 1 : .2,
            child: SkeletonScanner(
              key: _key,
              onLayout: (layout) {
                setState(() {
                  overlay = layout;
                });
              },
              child: false
                  ? CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Text('Hello'),
                            childCount: 3,
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.all(23),
                          sliver: SliverAppBar(
                            // backgroundColor: Colors.transparent,
                            title: Text("Hello"),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.all(23),
                          sliver: SliverAppBar(
                            // backgroundColor: Colors.transparent,
                            title: Text("Hello"),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        // const Padding(
                        //   padding: EdgeInsets.all(20.0),
                        //   child: Text(
                        //     "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                        //     style: TextStyle(fontSize: 20),
                        //   ),
                        // ),
                        // Card(
                        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        //   child: const Text("Hello"),
                        // ),
                        // if (false)
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: ElevatedButton(onPressed: () {}, child: const Text('Hello')),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: DecoratedBox(
                        //     decoration: BoxDecoration(
                        //       border: Border.all(),
                        //     ),
                        //     child: Row(
                        //       children: const [
                        //         Text('Hello'),
                        //         SizedBox(
                        //           width: 20,
                        //           height: 100,
                        //         ),
                        //         Text("World"),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // if (false)
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(20),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: .5
                            ),
                            itemCount: 20,
                            itemBuilder: (ctx, index) {
                              return Card(
                                margin: const EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 2 / 1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12),
                                            child: Container(
                                              width: 65,
                                              height: 65,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                'Hello there that is kinda long',
                                                textAlign: TextAlign.end,
                                                textDirection: TextDirection.rtl,
                                              ),
                                              SizedBox(height: 8),
                                              Text("Im a subtitle"),
                                            ],
                                          )),
                                          const SizedBox(width: 20)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          if (overlay != null) overlay!,
        ],
      ),
    );
  }
}
