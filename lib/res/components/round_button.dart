import 'package:flutter/material.dart';
import 'package:provider_mvm/res/components/custom_color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.loading = false});
  final bool loading;
  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.buttonColor),
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Center(
                child: Text(
                title,
                style: TextStyle(color: AppColor.whiteColor),
              )),
      ),
    );
  }
}
