import 'package:easy_read/providers/loading_notifier.dart';
import 'package:easy_read/shared/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPrimaryButton extends StatelessWidget {
  /// The primary button for this app
  const MyPrimaryButton({
    Key? key,
    required this.text,
    this.press,
    this.height = myDefaultSize * 3,
    this.width,
    this.backgroundColor,
    this.textSize,
    this.textColor,
  }) : super(key: key);

  final String text;
  final Function()? press;
  final double? height, width, textSize;
  final Color? backgroundColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? myDefaultSize * 18,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(myDefaultSize * .8),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            blurRadius: 3.0,
            spreadRadius: .4,
          ),
        ],
      ),
      child:
          Consumer(builder: (BuildContext context, WidgetRef ref, Widget? _) {
        final isLoading = ref.watch(loadingProvider);

        return TextButton(
          onPressed: press,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor ?? mySecondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(myDefaultSize * .8),
            ),
          ),
          child: isLoading
              ? LoadingWidget(
                  backgroundColor:
                      backgroundColor == null ? myPrimaryColor : Colors.white,
                  strokeWidth: 4.0,
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: textSize ?? myDefaultSize * 1.25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        );
      }),
    );
  }
}
