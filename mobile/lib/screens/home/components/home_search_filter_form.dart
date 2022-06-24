import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/util/my_primary_button.dart';
import 'package:flutter/material.dart';

enum Sorts { title, priceLH, priceHL, publicationDate }

class HomeSearchFilterForm extends StatefulWidget {
  const HomeSearchFilterForm({Key? key}) : super(key: key);

  @override
  State<HomeSearchFilterForm> createState() => _HomeSearchFilterFormState();
}

class _HomeSearchFilterFormState extends State<HomeSearchFilterForm> {
  Sorts _sortBy = Sorts.title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.42,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: myDefaultSize * 1.2,
        horizontal: myDefaultSize * 1.5,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sort By',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: myDefaultSize),
            radioInputTile(title: 'Title', value: Sorts.title),
            radioInputTile(title: 'Price: Low to High', value: Sorts.priceLH),
            radioInputTile(title: 'Price: High to Low', value: Sorts.priceHL),
            radioInputTile(
                title: 'Publication Date', value: Sorts.publicationDate),
            MyPrimaryButton(
              text: 'Apply',
              press: () {},
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Widget radioInputTile({
    required String title,
    required Sorts value,
  }) =>
      ListTile(
        title: GestureDetector(
          onTap: () => setState(() => _sortBy = value),
          child: Text(title),
        ),
        leading: Radio<Sorts>(
          value: value,
          groupValue: _sortBy,
          onChanged: (Sorts? value) => setState(() => _sortBy = value!),
          fillColor: MaterialStateProperty.resolveWith<Color?>(getColor),
        ),
        contentPadding: const EdgeInsets.all(0),
        horizontalTitleGap: 0,
      );
}
