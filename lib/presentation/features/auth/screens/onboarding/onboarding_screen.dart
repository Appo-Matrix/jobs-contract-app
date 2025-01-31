import 'package:flutter/material.dart';
import '../../../../../data/models/content_model.dart';
import '../../../../../utils/common_widgets/main_button.dart';
import '../../../../../utils/common_widgets/widget_support.dart';

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
      body: PageView.builder(
          controller: _controller,
          itemCount: contents.length,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (_, i) {
            return Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        if (currentIndex == 0)
                          TextButton(onPressed: () {}, child: Text('Skip')),
                        SizedBox(height: 10),
                        const SizedBox(
                          height: 16,
                        ),
                        Image.asset(
                          contents[i].image,
                          height: MediaQuery.of(context).size.height / 2.5,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xffF2F4F7),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35)),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, right: 15, left: 15),
                        child: Column(
                          children: [
                            Text(
                              contents[i].title,
                              style: AppWidget.semiBoldTextFieldStyle(),
                            ),
                            Spacer(),
                            if (currentIndex == 0)
                              forward_button(
                                onClick: () {

                                },
                              ),
                            if (currentIndex == 0)
                              SizedBox(
                                height: 40,
                              ),
                            if (currentIndex == 1)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  back_button(),
                                  SizedBox(width: 7),
                                  forward_button(onClick: () {

                                  },),
                                ],
                              ),
                            if (currentIndex == 1)
                              SizedBox(
                                height: 40,
                              ),
                            if (currentIndex == 2)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Sign Up As'),
                                  SizedBox(height: 5),
                                  MainButton(
                                    btn_title:
                                        'I’m a client, Hiring Professionals',
                                    btn_radius: 10,
                                    btn_color: Color(0xff7030F1),
                                    btn_boarder_color: Color(0xff7030F1),
                                    title_color: Colors.white,
                                    image_value: false,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  MainButton(
                                    onTap:() {

                                    },
                                    btn_title:
                                        'I’m a Freelancer, Looking for work',
                                    btn_radius: 10,
                                    btn_color: Colors.transparent,
                                    btn_boarder_color: Color(0xff7030F1),
                                    title_color: Color(0xff7030F1),
                                    image_value: false,
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account?',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xff667085),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        ' Log in',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xff7030F1),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
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
  final VoidCallback onClick;

  const forward_button({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            color: Color(0xff7030F1)),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );


  }

}


