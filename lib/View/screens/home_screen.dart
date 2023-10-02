import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/Presenter/init_cubit/init_cubit.dart';
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
    BlocProvider.of<InitCubit>(context).getData();
    url = BlocProvider.of<InitCubit>(context).data?.url ?? '';
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
        return Scaffold(
          body: SafeArea(
            child: getHomeScreenWidget(state),
          ),
        );
      },
    );
  }

  Widget getHomeScreenWidget(InitState state) {
    Widget homeScreenWidget = const SizedBox();

    if (state is Loading) {
      homeScreenWidget = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is Error) {
      homeScreenWidget = const Center(
        child: Text('Error'),
      );
    } else if (state is Success) {
      _controller.loadRequest(Uri.parse(url));
      homeScreenWidget = WebViewWidget(controller: _controller);
    }

    return homeScreenWidget;
  }
}
