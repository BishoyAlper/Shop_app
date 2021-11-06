import 'package:flutter/material.dart';
import 'package:shoping_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login/login_shop_screen.dart';

class OnboardingModel
{
  final String image;
  final String title;
  final String body;

  OnboardingModel({@required this.image, @required this.title, @required this.body});
}

class OnBoardScreen extends StatefulWidget{
  @override
  _StateOnBoardScreen createState() => _StateOnBoardScreen();
}

class _StateOnBoardScreen extends State<OnBoardScreen>{

  var boardController = PageController();

  List<OnboardingModel> board = [
    OnboardingModel(
        image: "assets/onboard_1.jpg",
        title: "onBoard 1 Title",
        body: "onBoard 1 Body"
    ),
    OnboardingModel(
        image: "assets/onboard_2.jpg",
        title: "onBoard 2 Title",
        body: "onBoard 2 Body"
    ),
    OnboardingModel(
        image: "assets/onboard_3.jpg",
        title: "onBoard 3 Title",
        body: "onBoard 3 Body"
    ),
  ];

  bool isLast = false;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            onSubmit();
          }, child: Text("SKIP")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  onPageChanged:(int index)
                  {
                    if(index == board.length-1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardController,
                  itemBuilder:(context, index) => buildBordingItem(board[index]),
                  itemCount: 3,
                )
            ),
            SizedBox(height: 40.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: board.length,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 2,
                      spacing: 5.0
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast){
                     onSubmit();
                    }
                    boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn
                    );
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBordingItem(OnboardingModel model){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
              image: AssetImage("${model.image}")
          ),
        ),
        Text(
          "${model.title}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0
          ),
        ),
        SizedBox(height: 14.0,),
        Text(
          "${model.body}",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0
          ),
        ),
      ],
    );
  }


  void onSubmit(){
    CasheHelper.saveData(key: "onBoarding", value: true).then((value){
      if(value){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ShopLoginScreen()),
                (route) => false
        );
      }
    });
  }
}