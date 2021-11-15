import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reward_calculator/constant/color_constant.dart';
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

class ListItem extends StatelessWidget {
  const ListItem({Key? key}) : super(key: key);

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
          elevation: 1.0,
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
                  children: [
                    Text(
                      "Phone Number:",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      provider.getList[i].phonNumber!,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Amount Spent:",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      provider.getList[i].amount!,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Total Reward Point:",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      provider.getList[i].rewardPoint!,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
