import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.red,
        ),
        body: aboutUsBody());
  }
}

Widget aboutUsBody() {
  return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              aboutUsheading(),
              aboutUsPicWidget(),
              aboutUsParaWidget(),
              reviewSectionWidget(),
              testimonialSectionWidget()
            ],
          )));
}

Widget aboutUsheading() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      padding: EdgeInsets.all(10),
      child: Text("About Us",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
    ),
  );
}

Widget aboutUsPicWidget() {
  return Container(
    child: Image(image: AssetImage('assets/images/about_us_profile_pic.jpg')),
  );
}

Widget aboutUsParaWidget() {
  var text = """
  Chitvish is now a household name across the globe. Her countless recipes have taken the culinary world by storm. Each and every mouth watering recipe of hers is tried meticulously by a lonely bride in Alaska or Australia living far away from her dear parents. When she is able to cook a dish the way her mother did thanks to Chitvish's recipes, her homesickness vanishes instantly.

  Despite her strong South Indian roots, Chitvish's recipes transcend national and international barriers. Be it the typically Tamilian akkaravadisal, the Gujurati dhokla, the Rajasthani Lapsi or the Mexican fajita, her avid followers just make a beeline to her recipes whenever they want to make it.'Ask Chitvish' is the mantra chanted by thousands day in and day out!


  Welcome to the wonderland of Chitvish!
  """;
  return paragraphWidget(text);
}

Widget paragraphWidget(String text) {
  return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: TextStyle(fontSize: 14))));
}

Widget reviewSectionWidget() {
  double linkSpace = 15;

  var reviewItems = [
    {
      'name': 'The Hindu',
      'url':
          'https://www.thehindu.com/features/metroplus/hits-likes-and-sambar/article6163393.ece'
    },
    {
      'name': 'New Indian Express',
      'url':
          'https://www.newindianexpress.com/cities/chennai/2014/oct/09/Akkaravadisal-for-the-South-Indian-Soul-669706.html'
    },
    {
      'name': 'Rediff',
      'url':
          'https://www.rediff.com/getahead/slide-show/slide-show-1-achievers-75-yr-old-chitra-viswanathan-has-a-cooking-app-to-her-name/20140728.htm'
    },
  ];
  List<Widget> reviewItemsList =
      reviewItems.map((e) => reviewLink(e['name'], e['url'])).toList();

  return Column(
    children: [
      subHeading('Reviews', 22),
      SizedBox(height: linkSpace),
      ...reviewItemsList
    ],
  );
}

Widget subHeading(String headingText, double size) {
  return Align(
      alignment: Alignment.centerLeft,
      child: Text(headingText,
          style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline)));
}

Widget reviewLink(String linkText, String url) {
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            child: new Text(linkText,
                style: TextStyle(
                    color: Color(0xFFC3373D), // shade of red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline)),
            onTap: () => launch(url),
          )));
}

Widget testimonialSectionWidget() {
  double linkSpace = 15;
  var testimonialItems = [
    {
      'name': 'Shymala Srivatsan',
      'text':
          'Very useful and handy(on hand all the time) cook book fom an experienced culinary expert. Chitra has explained everything neatly and clearly.'
    },
    {
      'name': 'Sundar Matpadi',
      'text':
          'Wonderful collection of recipe, all personally made and verified by the author.'
    },
    {
      'name': 'Jayashree Arvind',
      'text':
          'Best app and a must in every mobile. Lots of tips and detailed step by step recipe with photos. Since everything has been tried, it comes out perfectly. Lots od effort has gone into this app.'
    },
    {'name': 'Ayesha Fakhruddin', 'text': 'Best companion in the kitchen.'},
  ];

  List<Widget> testimonialWidgets =
      testimonialItems.map((e) => testimonial(e['name'], e['text'])).toList();
  return Column(
    children: [
      SizedBox(height: 40),
      subHeading('Testimonials', 22),
      SizedBox(height: linkSpace),
      ...testimonialWidgets,
    ],
  );
}

Widget testimonial(String name, String text) {
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Column(children: [subHeading(name, 16), paragraphWidget(text)]));
}
