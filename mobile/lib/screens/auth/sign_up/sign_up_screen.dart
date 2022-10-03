import 'package:easy_read/providers/loading_notifier.dart';
import 'package:easy_read/screens/auth/sign_up/components/body.dart';
import 'package:easy_read/shared/helpers.dart';
import 'package:easy_read/shared/loading_widget.dart';
import 'package:easy_read/shared/util/auth_screen_backgound.dart';
import 'package:easy_read/shared/util/plain_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends StatelessWidget {
  /// For users to create an account
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: myPrimaryColor,
        appBar: plainAppBar(
          surfaceTintColor: myPrimaryColor,
          context: context,
          hasLeadingBackButton: false,
        ),
        body: Consumer(
          builder: (context, WidgetRef ref, Widget? child) {
            final isLoading = ref.watch(loadingProvider);

            return isLoading
                ? const LoadingWidget()
                : const AuthScreenBackground(
                    child: Body(),
                  );
          },
        ),
      ),
    );
  }
}
