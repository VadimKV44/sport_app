import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/Presenter/init_cubit/init_cubit.dart';
import 'package:sport_app/View/consts/colors.dart';
import 'package:sport_app/View/widgets/custom_error_widget.dart';
import 'package:sport_app/View/widgets/custom_loading_widget.dart';
import 'package:sport_app/View/widgets/plug_widget.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final cookieManager = WebviewCookieManager();
  final String cookieValue = 'some-cookie-value';
  final String domain = 'youtube.com';
  final String cookieName = 'some_cookie_name';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<InitCubit>(context).checkUrl();
  }

  Future<bool> _willPopCallback() async {
    WebViewController webViewController = await _controller.future;
    bool canNavigate = await webViewController.canGoBack();
    if (canNavigate) {
      webViewController.goBack();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitCubit, InitState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () {
            return _willPopCallback();
          },
          child: Scaffold(
            backgroundColor: MainColors.kWhiteColor1,
            body: SafeArea(
              child: getHomeScreenWidget(state),
            ),
          ),
        );
      },
    );
  }

  Widget getHomeScreenWidget(InitState state) {
    Widget homeScreenWidget = const SizedBox();

    if (state is Loading) {
      homeScreenWidget = const CustomLoadingWidget();
    } else if (state is Error) {
      homeScreenWidget = CustomErrorWidget(
        onTap: () {
          BlocProvider.of<InitCubit>(context).checkUrl();
        },
      );
    } else if (state is ShowWebView) {
      String url = BlocProvider.of<InitCubit>(context).remoteConfig?.url ?? '';

      homeScreenWidget = WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          _controller.complete(webViewController);
          await cookieManager.setCookies([
            Cookie(cookieName, cookieValue)
              ..domain = domain
              ..expires = DateTime.now().add(const Duration(days: 10))
              ..httpOnly = false
          ]);
        },
      );
    } else if (state is ShowPlug) {
      homeScreenWidget = const PlugWidget();
    }

    return homeScreenWidget;
  }
}
