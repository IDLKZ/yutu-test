import 'package:findout/app/helpers/global_mixin.dart';
import 'package:findout/app/helpers/kcolors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardPost extends StatelessWidget {
  final String url;
  final String name;
  final String city;
  final int age;
  final String cardImg;
  final String cardTitle;
  final int countPeople;
  final String date;

  const CardPost(this.url, this.name, this.city, this.age, this.cardImg, this.cardTitle, this.countPeople, this.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: KColors.kLightGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding:
          const EdgeInsets.only(top: 10, bottom: 10, right: 3, left: 3),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${city}, ${age}',
                          style: TextStyle(color: KColors.kSpaceGray),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 50,),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.delete),
                  )
                ],
              ),
              Container(
                height: 220,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(cardImg),
                        fit: BoxFit.contain)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  GlobalMixin.truncateText(
                      cardTitle,
                      60),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.userAlt),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${countPeople}',
                      style:
                      TextStyle(fontSize: 16, color: KColors.kSpaceGray),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(FontAwesomeIcons.calendarAlt),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${date}',
                      style:
                      TextStyle(fontSize: 16, color: KColors.kSpaceGray),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
