import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spacex_app/core/theme/theme.dart';
import 'package:spacex_app/core/widgets/no_data.dart';
import 'package:spacex_app/modules/launches_detail/bloc/launches_detail_bloc.dart';
import 'package:spacex_app/modules/launches_detail/views/widgets/content.dart';
import 'package:spacex_app/modules/launches_detail/views/widgets/header_img.dart';

class LaunchesDetail extends StatefulWidget {
  const LaunchesDetail({super.key});

  @override
  State<LaunchesDetail> createState() => _LaunchesDetailState();
}

class _LaunchesDetailState extends State<LaunchesDetail> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<LaunchesDetailBloc>();
    bloc.add(const LoadByIdEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchesDetailBloc, LaunchesDetailState>(
      buildWhen: (previous, current) {
        return previous.loading != current.loading;
      },
      builder: (context, state) {
        if (state.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final content = state.content;
        if (content == null) {
          return Scaffold(
            body: SizedBox(
              height: double.infinity,
              child: Stack(
                children: [
                  const NoData(),
                  _buildBackButton(true),
                ],
              ),
            ),
          );
        }
        final name = content.name ?? "";
        final fireDate = content.fireDate != null
            ? DateFormat('dd MMMM yyyy').format(content.fireDate!.toLocal())
            : "-";
        final success = content.success;
        final flightNumber = content.flightNumber.toString();
        final crew = content.crew;
        final details = content.details;
        final videoUrl = content.links?.videoUrl;

        return Scaffold(
          body: SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                HeaderImage(
                  data: content,
                ),
                Positioned.fill(
                  top: 260,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          GridConstant.radiusMd,
                        ),
                        topRight: Radius.circular(
                          GridConstant.radiusMd,
                        ),
                      ),
                      color: ColorConstant.primaryCard,
                    ),
                    child: Content(
                      name: name,
                      fireDate: fireDate,
                      flightNumber: flightNumber,
                      crew: crew,
                      success: success,
                      details: details,
                      urlLink: videoUrl,
                    ),
                  ),
                ),
                _buildBackButton(false),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackButton(bool isInverted) {
    return Positioned(
      left: GridConstant.spacingScreen,
      top: GridConstant.spacingScreen,
      child: SafeArea(
        child: Material(
          color: isInverted ? ColorConstant.textStrongOnDark : Colors.black,
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              GridConstant.radiusSm,
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    GridConstant.radiusSm,
                  ),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: isInverted ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
