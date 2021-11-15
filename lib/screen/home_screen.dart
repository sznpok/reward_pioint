import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_calculator/constant/color_constant.dart';
import 'package:reward_calculator/constant/custom_loader.dart';
import 'package:reward_calculator/model/reward_model.dart';
import 'package:reward_calculator/provider/data_provider.dart';
import 'package:reward_calculator/screen/reward_screen.dart';
import 'package:reward_calculator/widgets/general_textfield.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  double amount = 0.0;
  _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    onLoading(context);
    Timer(const Duration(milliseconds: 1000), () {
      calculateReward(amount);
    });
    _formKey.currentState!.save();
  }

  Future<void> calculateReward(totalAmount) async {
    var amount = totalAmount * (1.5 / 100);
    log(amount.toString());
    Navigator.pop(context);
    final provider = Provider.of<TodoProvider>(context, listen: false);
    provider.addItem(
      Todo(
        amount: totalAmount.toString(),
        phonNumber: _phoneNumber.text,
        rewardPoint: amount.toString(),
      ),
    );
    await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => RewardScreen(
          amount: totalAmount.toString(),
          phoneNumber: _phoneNumber.text,
          rewardPoint: amount.toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              color: primaryColor,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Phone Number",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          GeneralTextField(
                            obscureText: false,
                            controller: _phoneNumber,
                            hintText: "Phone number",
                            keywordType: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'Please enter phone number';
                              }
                            },
                            onFieldSubmit: (newValue) {},
                            textInputAction: TextInputAction.next,
                            onSave: (value) {},
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "Amount Spent",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          GeneralTextField(
                            obscureText: false,
                            hintText: "amount",
                            keywordType: TextInputType.number,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "Please enter amount number";
                              }
                            },
                            onChanged: (String value) {
                              amount = double.parse(value);
                              setState(() {});
                            },
                            onFieldSubmit: (newValue) {
                              _onSubmit();
                            },
                            textInputAction: TextInputAction.done,
                            onSave: (newValue) {},
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {
                              _onSubmit();
                            },
                            child: const Text(
                              'Calculate',
                            ),
                          )
                        ],
                      ),
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
