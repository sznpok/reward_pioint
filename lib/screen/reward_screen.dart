import 'package:flutter/material.dart';
import 'package:reward_calculator/constant/color_constant.dart';

class RewardScreen extends StatelessWidget {
  final String phoneNumber;
  final String rewardPoint;
  final String amount;
  const RewardScreen({
    Key? key,
    required this.amount,
    required this.phoneNumber,
    required this.rewardPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reward Result'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              color: primaryColor,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Phone Number:",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              phoneNumber,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Amount Spent:",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              amount,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Reward Point:",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(
                              rewardPoint,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Go Back'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
