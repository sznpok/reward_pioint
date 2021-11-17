import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_calculator/constant/color_constant.dart';
import 'package:reward_calculator/constant/custom_loader.dart';
import 'package:reward_calculator/model/reward_model.dart';
import 'package:reward_calculator/provider/data_provider.dart';
import 'package:reward_calculator/widgets/general_textfield.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    Provider.of<TodoProvider>(context, listen: false).getItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('Reward Record'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              color: primaryColor,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: GeneralTextField(
                    obscureText: false,
                    hintText: "search",
                    keywordType: TextInputType.name,
                    validate: (value) {},
                    onFieldSubmit: (value) {},
                    onChanged: (value) {
                      provider.searchItem(value);
                    },
                    textInputAction: TextInputAction.search,
                    onSave: () {},
                  ),
                ),
                const ListItem(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  const ListItem({Key? key}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  List<Choice> choices = const <Choice>[
    Choice(title: 'Update', icon: Icons.edit),
    Choice(title: 'Delete', icon: Icons.delete),
  ];
  Choice? _selectedChoice;

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    if (provider.getList.isEmpty) {
      return Center(
        heightFactor: MediaQuery.of(context).size.height * 0.02,
        child: Text(
          'No Data Available',
          style: Theme.of(context).textTheme.headline6,
        ),
      );
    }
    return ListView.separated(
      separatorBuilder: (c, i) {
        return const SizedBox(
          height: 8.0,
        );
      },
      itemCount: provider.getList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      itemBuilder: (c, i) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: [
              Material(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                color: colorWhite,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Purhcase Amount:",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            provider.getList[i].amount!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: primaryColor,
                                    ),
                          ),
                          const Expanded(child: SizedBox()),
                          PopupMenuButton<Choice>(
                            onSelected: _select,
                            itemBuilder: (BuildContext context) {
                              return choices.map((Choice choice) {
                                return PopupMenuItem<Choice>(
                                  value: choice,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (choice.title == "Update") {
                                        editDialogue(
                                          i,
                                          amount: provider.getList[i].amount,
                                          mobileNumber:
                                              provider.getList[i].phonNumber,
                                          rewardPoint:
                                              provider.getList[i].rewardPoint,
                                        );
                                      }
                                      if (choice.title == "Delete") {
                                        onLoading(context);
                                        Timer(const Duration(milliseconds: 500),
                                            () {
                                          provider.deleteItem(i);
                                          Navigator.of(context).pop(context);
                                        });
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(choice.title!),
                                        const SizedBox(
                                          width: 4.0,
                                        ),
                                        Icon(
                                          choice.icon!,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Mobile Number:",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            provider.getList[i].phonNumber!,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: primaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Material(
                color: primaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.0),
                        bottomRight: Radius.circular(12.0))),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        double.parse(provider.getList[i].rewardPoint!)
                            .toStringAsFixed(2),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: colorWhite,
                            ),
                      ),
                      const SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "cash rewards",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: colorWhite,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  final TextEditingController _amountSpentController = TextEditingController();
  final TextEditingController _rewardController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  editDialogue(int index, {amount, rewardPoint, mobileNumber}) {
    showDialog(
        context: context,
        builder: (context) {
          _amountSpentController.text = amount;
          _mobileController.text = mobileNumber;
          _rewardController.text = rewardPoint;
          final provider = Provider.of<TodoProvider>(context, listen: false);
          return Dialog(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Update Record',
                        style: TextStyle(
                            fontSize: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone number cannot be empty';
                            }
                            return null;
                          },
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          controller: _amountSpentController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Purchase Amount  cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Purchase amount',
                            border: InputBorder.none,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: TextFormField(
                          controller: _rewardController,
                          keyboardType: TextInputType.number,
                          focusNode: FocusNode(descendantsAreFocusable: false),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Cash Rewards cannot be empty';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Cash Rewards',
                            border: InputBorder.none,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                onLoading(context);
                                amount = _amountSpentController.text;
                                mobileNumber = _mobileController.text;
                                rewardPoint = _rewardController.text;
                                Timer(const Duration(milliseconds: 1000), () {
                                  provider.updateItem(
                                    index,
                                    Todo(
                                      amount: amount,
                                      phonNumber: mobileNumber,
                                      rewardPoint: rewardPoint,
                                    ),
                                  );
                                  log(amount);
                                  log(mobileNumber);
                                  log(rewardPoint);

                                  Navigator.pop(context);
                                  _amountSpentController.clear();
                                  _mobileController.clear();
                                  _rewardController.clear();
                                  provider.getItem();
                                  Navigator.pop(context);
                                });
                              },
                              child: const Text('Update'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String? title;
  final IconData? icon;
}
