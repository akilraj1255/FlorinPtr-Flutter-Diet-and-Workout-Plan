
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Person.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'exercise_screen.dart';
import 'meal_plan_screen.dart';

class DetailsScreen extends StatefulWidget {


  @override
  DetailsScreenState createState() {
    return DetailsScreenState();
  }

}

  class DetailsScreenState extends State<DetailsScreen>
  with SingleTickerProviderStateMixin {

    TabController tabController;

    @override
  void initState() {
      tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(67.0),
      child: AppBar(
        elevation: 10.0,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: SafeArea(
              child: getTabBar(),

          ),
        ),
      ),
      ),
        body: getTabBarPages()
    );
  }

  Widget getTabBar() {
    return TabBar(controller: tabController,
        tabs: [
      Tab(text: AppLocalizations.of(context).translate("nav_dieta"),
          icon: Icon(MdiIcons.silverwareForkKnife)),
      Tab(text: AppLocalizations.of(context).translate("nav_exercise"),
          icon: Icon(MdiIcons.dumbbell)),
      Tab(text: AppLocalizations.of(context).translate("_news"),
          icon: Icon(MdiIcons.newspaper)),
      Tab(text: AppLocalizations.of(context).translate("nav_info"),
          icon: Icon(MdiIcons.accountDetails)),

    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: tabController, physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
      new MealPlanScreen(),
      new ExerciseScreen(),
      Container(color: Colors.blue),
      Container(color: Colors.yellow)

        ]);
  }

  }

