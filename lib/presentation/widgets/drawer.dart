import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../data/data_analytics.dart';
import '../screens/aboutscreen/about_screen.dart';
import '../screens/analyticscreen/analytics_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.analyticalData});
  final List<DataAnalyticsData> analyticalData;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          LottieBuilder.asset(
            'assets/img/splash_art.json',
            width: 200,
            repeat: false,
          ),
          Text(
            'Expense Tracker',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 20),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            color: Theme.of(context).colorScheme.inversePrimary,
            child: ListTile(
              leading: Icon(
                Icons.line_axis,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'Analytics',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AnalyticsScreen(
                      analyticdata: analyticalData,
                    );
                  },
                ));
              },
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.black,
          ),
          Container(
            color: Theme.of(context).colorScheme.inversePrimary,
            child: ListTile(
              leading: Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              title: Text(
                'About',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AboutPg();
                  },
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
