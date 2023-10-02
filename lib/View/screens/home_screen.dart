import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/Presenter/init_cubit/init_cubit.dart';
import 'package:sport_app/View/consts/colors.dart';
import 'package:sport_app/View/widgets/custom_error_widget.dart';
import 'package:sport_app/View/widgets/custom_loading_widget.dart';
import 'package:sport_app/View/widgets/plug_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<InitCubit>(context).checkUrl();
  }

  String url = '';

  final WebViewController _controller = WebViewController();
    // ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // ..setBackgroundColor(const Color(0x00000000))
    // ..setNavigationDelegate(
    //   NavigationDelegate(
    //     onProgress: (int progress) {
    //       // Update loading bar.
    //     },
    //     onPageStarted: (String url) {},
    //     onPageFinished: (String url) {},
    //     onWebResourceError: (WebResourceError error) {},
    //     onNavigationRequest: (NavigationRequest request) {
    //       if (request.url.startsWith('https://www.youtube.com/')) {
    //         return NavigationDecision.prevent;
    //       }
    //       return NavigationDecision.navigate;
    //     },
    //   ),
    // )
    // ..loadRequest(Uri.parse(url));


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitCubit, InitState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            return false;
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
      homeScreenWidget = const CustomErrorWidget();
    } else if (state is ShowWebView) {
      url = BlocProvider.of<InitCubit>(context).remoteConfig?.url ?? '';
      _controller.loadRequest(Uri.parse(url));
      homeScreenWidget = WebViewWidget(controller: _controller);
    } else if (state is ShowPlug) {
      homeScreenWidget = PlugWidget();
    }

    return homeScreenWidget;
  }
}
