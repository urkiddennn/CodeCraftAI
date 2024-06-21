import 'package:app_detect/views/home/controller/home_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xff212121),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Codecraft AI',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.openSans().fontFamily),
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<HomeProvider>(builder: (context, provider, child) {
                  return provider.searchChanging == true
                      ? Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                              color: Color(0xff424242),
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Consumer<HomeProvider>(
                              builder: (context, provider, child) {
                            return Image.memory(provider.imageData!);
                          }),
                        )
                      : Container(
                          width: 320,
                          height: 320,
                          decoration: BoxDecoration(
                              color: Color(0xff424242),
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.grey[400],
                                size: 90,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'No image is generated',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        GoogleFonts.openSans().fontFamily),
                              ),
                            ],
                          ),
                        );
                }),
                SizedBox(
                  height: 40,
                ),
                Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xff424242),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                        controller: homeProvider.textController,
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.openSans().fontFamily),
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText: 'Enter your prompt here.......',
                            hintStyle: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.openSans().fontFamily),
                            contentPadding: EdgeInsets.all(20),
                            border: InputBorder.none))),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        homeProvider.textToImage();
                        homeProvider.loadingUpdate(true);
                      },
                      child: Container(
                        height: 60,
                        width: 160,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.deepPurpleAccent,
                                  Colors.purple,
                                ])),
                        child: Consumer<HomeProvider>(
                          builder: (context, provider, child) {
                            return provider.isLoading == false
                                ? Text(
                                    'Generate',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            GoogleFonts.openSans().fontFamily),
                                  )
                                : CircularProgressIndicator(
                                    color: Colors.white);
                          },
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        homeProvider.searchUpdate(false);
                        homeProvider.textController.clear();
                      },
                      child: Container(
                        height: 60,
                        width: 160,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.pink,
                                  Colors.red,
                                ])),
                        child: Text(
                          'Clear',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.openSans().fontFamily),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    await homeProvider.saveImage();
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue,
                              Colors.green,
                            ])),
                    child: Text(
                      'save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.openSans().fontFamily),
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
