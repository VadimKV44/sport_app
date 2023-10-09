import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_app/Presenter/init_cubit/init_cubit.dart';
import 'package:sport_app/View/consts/colors.dart';
import 'package:sport_app/View/widgets/custom_loading_widget.dart';
import 'package:sport_app/View/widgets/plug_widget.dart';
import 'package:sport_app/View/widgets/web_view_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitCubit, InitState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MainColors.kWhiteColor1,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/background_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                getHomeScreenWidget(state),
              ],
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
    } else if (state is ShowWebView) {
      String url = BlocProvider.of<InitCubit>(context).remoteConfigUrl ?? '';

      homeScreenWidget = WebViewWidget(url: url);
    } else if (state is ShowPlug) {
      homeScreenWidget = const PlugWidget();
    }

    return homeScreenWidget;
  }
}
