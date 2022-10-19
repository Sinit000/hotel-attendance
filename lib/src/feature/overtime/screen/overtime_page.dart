import 'package:e_learning/src/config/routes/routes.dart';
import 'package:e_learning/src/feature/auth/bloc/index.dart';
import 'package:e_learning/src/feature/ot_compesation/screen/ot_compensation_dashboard.dart';
import 'package:e_learning/src/feature/overtime/bloc/index.dart';

import 'package:e_learning/src/shared/widget/delay_widget.dart';
import 'package:e_learning/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../appLocalizations.dart';
import 'widget/component_widget.dart';

OverTimeBloc overtimeBloc = OverTimeBloc();

class OvertimePage extends StatelessWidget {
  const OvertimePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("ot")!}"),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: Theme.of(context).primaryColor,
          ),
          ListView(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              SizedBox(height: 20),
              // delayedWidget(
              //   child: ComponentWidget(
              //     name:
              //         "${AppLocalizations.of(context)!.translate("contract")!}",
              //     onPressed: () {
              //       // Navigator.of(context).pushNamed(contract);
              //     },
              //   ),
              // ),
              BlocProvider.of<AuthenticationBloc>(context)
                          .state
                          .user!
                          .roleName ==
                      "Cheif Department"
                  ? delayedWidget(
                      child: ComponentWidget(
                        name:
                            "${AppLocalizations.of(context)!.translate("all_ot")!}",
                        onPressed: () {
                          Navigator.of(context).pushNamed(allovertime);
                        },
                      ),
                    )
                  : Container(),
              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name: "${AppLocalizations.of(context)!.translate("my_ot")!}",
                  onPressed: () {
                    Navigator.of(context).pushNamed(myovertime);
                  },
                ),
              ),
              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("ot_compesation")!}",
                  onPressed: () {
                    // Navigator.of(context).pushNamed(otcompesation);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTCompensationDashBoard()));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
