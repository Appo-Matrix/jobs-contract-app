import 'package:flutter/material.dart';
import '../../../../data/models/content_model.dart';
import '../../../../utils/common_widgets/widget_support.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          contents[i].image,
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF2F4F7),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 15, left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    contents[i].title,
                                    style: AppWidget.semiBoldTextFieldStyle(),
                                  ),
                                  SizedBox(height: 10),
                                  if (currentIndex == 0) forward_button(),
                                  if (currentIndex == 1)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        back_button(),
                                        SizedBox(width: 7),
                                        forward_button(),
                                      ],
                                    ),
                                  if (currentIndex == 2)
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Sign Up As'),
                                        SizedBox(height: 5),
                                        main_button(
                                          btn_title:
                                              'I’m a client, Hiring Professionals',
                                          btn_radius: 10,
                                          btn_color: Color(0xff7030F1),
                                          btn_boarder_color: Color(0xff7030F1),
                                          title_color: Colors.white,
                                        ),

                                        SizedBox(height: 10,),

                                        main_button(
                                          btn_title:
                                          'I’m a Freelancer, Looking for work',
                                          btn_radius: 10,
                                          btn_color: Colors.transparent,
                                          btn_boarder_color: Color(0xff7030F1),
                                          title_color: Color(0xff7030F1),
                                        ),
                                      ],
                                    ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 3,
      width: 40, //currentIndex == index ? 18 : 7,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: currentIndex == index ? Colors.blue : Colors.black38,
      ),
    );
  }
}

class main_button extends StatelessWidget {
  final String btn_title;
  final double btn_radius;
  final Color btn_color;
  final Color title_color;
  final Color btn_boarder_color;

  const main_button({
    super.key,
    required this.btn_title,
    required this.btn_radius,
    required this.btn_color,
    required this.btn_boarder_color,
    required this.title_color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(btn_radius)),
          color: btn_color, //Color(0xff7030F1),
          border: Border.all(color: btn_boarder_color)),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
        child: Center(
            child: Text(
          btn_title,
          style: TextStyle(color: title_color),
        )),
      ),
    );
  }
}

class back_button extends StatelessWidget {
  const back_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        border: Border.all(color: Color(0xff7030F1), width: 1),
      ),
      child: Icon(
        Icons.arrow_back,
        color: Color(0xff7030F1),
      ),
    );
  }
}

class forward_button extends StatelessWidget {
  const forward_button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          color: Color(0xff7030F1)),
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }
}
