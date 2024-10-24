import 'package:flutter/material.dart';
import 'package:projetinho_final/models/product.dart';
import 'package:projetinho_final/models/statistic_unit.dart';
import 'package:projetinho_final/pages/addPage.dart';

class AutoComplete extends StatelessWidget {
  final List<String> listWords;
  final String textFieldLabel;
  final Icon prefixIcon;
  final TextEditingController textEditingController;

  void getStatUnitName(String selectedString) async {
    textEditingController.text = selectedString;

    if (textFieldLabel == 'Products...') {

      List<Product> produtcs = await Product.getAll();

      Product selectedProduct = produtcs.firstWhere(
        (product) => product.productDescription.contains(selectedString),
      );

      List<StatisticUnit> stsUnit = await StatisticUnit.getAll();

      StatisticUnit selectedStUnit = stsUnit.firstWhere(
        (stU) => stU.stUnitID.contains(selectedProduct.productStUnit),
      );
      txtEditCtrStUnit.text = selectedStUnit.stUnitName;
    }
    // else if()
    // {

    // }
    // else if()
    // {

    // }
    // else if()
    // {

    // }
  }

  AutoComplete({
    super.key,
    required this.listWords,
    required this.textFieldLabel,
    required this.prefixIcon,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }

          return listWords.where((String letter) {
            return letter
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (String selectedString) => getStatUnitName(selectedString),

        //change the height of options (list of itens)
        // optionsMaxHeight: MediaQuery.sizeOf(context).height * 0.4,
        optionsViewBuilder: (context, onSelected, options) {
          return Container(
            height: 200,
            width: 200,
            margin: EdgeInsets.only(
              top: 3,
              right: 40,
              bottom: options.length < 4
                  ? MediaQuery.sizeOf(context).height *
                      (1 - 0.065 * options.length)
                  : MediaQuery.sizeOf(context).height * 0.805,
            ),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  var op = options.elementAt(index);
                  return ListTile(
                    title: Text(op),
                    onTap: () {
                      onSelected(op.toString());
                    },
                  );
                },
              ),
            ),
          );
        },
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          return TextField(
            maxLines: 3,
            minLines: 1,
            controller: textEditingController,
            focusNode: focusNode,
            onEditingComplete: onFieldSubmitted,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              label: Text(textFieldLabel),
              prefixIcon: prefixIcon,
            ),
          );
        });
  }
}
