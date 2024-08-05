import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/constants/router.dart';
import 'package:spacex_app/core/theme/theme.dart';
import 'package:spacex_app/core/widgets/custom_network_img.dart';
import 'package:spacex_app/model/launch/launch.dart';
import 'package:spacex_app/modules/home/bloc/home_bloc.dart';
import 'dart:math' as math;

import 'package:spacex_app/utils/common.dart';

class LaunchesContents extends StatefulWidget {
  const LaunchesContents({
    super.key,
    required this.contents,
    required this.nextPage,
    required this.isLoadMore,
  });

  final List<LaunchModel> contents;
  final int? nextPage;
  final bool isLoadMore;

  @override
  State<LaunchesContents> createState() => _LaunchesContentsState();
}

class _LaunchesContentsState extends State<LaunchesContents> {
  int? get nextPage => widget.nextPage;
  final ScrollController _scrollController = ScrollController();
  double oldMaxScroll = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_checkScrollable);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_checkScrollable);
  }

  void _checkScrollable() {
    if (_scrollController.hasClients) {
      var launchBloc = context.read<HomeBloc>();
      var filter = launchBloc.state.filter;
      var fetchMoreArea = _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels >= fetchMoreArea &&
          nextPage != null) {
        if (oldMaxScroll != 0 && oldMaxScroll == fetchMoreArea) {
          return;
        }

        oldMaxScroll = fetchMoreArea;

        if (launchBloc.state.isLoadMore) return;
        var newFilter = filter.copyWith(page: filter.page + 1);
        launchBloc.add(LoadMoreEvent(filter: newFilter));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<LaunchModel> contents = widget.contents;

    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: GridConstant.spacingScreen,
        ),
        child: Column(
          children: [
            //
            const SizedBox(
              height: GridConstant.spacingMd,
            ),

            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: GridConstant.spacingMd,
                  crossAxisSpacing: GridConstant.spacingBase,
                  mainAxisExtent: 225,
                ),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contents.length + 2,
                itemBuilder: (context, i) {
                  if (i >= contents.length) {
                    if (!widget.isLoadMore) {
                      return const SizedBox();
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final content = contents[i];
                  return Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 225,
                            decoration: BoxDecoration(
                              color: ColorConstant.subCard,
                              borderRadius: BorderRadius.circular(
                                GridConstant.radiusMd,
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 220,
                                    decoration: BoxDecoration(
                                      color: ColorConstant.primaryCard,
                                      borderRadius: BorderRadius.circular(
                                        GridConstant.radiusMd,
                                      ),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                GridConstant.radiusMd,
                                              ),
                                              topRight: Radius.circular(
                                                GridConstant.radiusMd,
                                              ),
                                            ),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          height: 150,
                                          width: double.infinity,
                                          child: _buildImg(content),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              GridConstant.spacingSm),
                                          child: Text(
                                            content.name ?? '-',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              _buildStatusIcon(content.success),
                            ],
                          ),
                        ],
                      ),
                      Positioned.fill(
                        child: Material(
                          borderRadius: const BorderRadius.all(Radius.circular(
                            GridConstant.radiusMd,
                          )),
                          clipBehavior: Clip.hardEdge,
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                RouteNames.launchesDetail,
                                arguments: content.id,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(bool? success) {
    final width = context.width;
    if (success == null) {
      return const SizedBox();
    }
    return Positioned(
      left: width >= 411 ? 135 : 125,
      top: 10,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: success
              ? ColorConstant.textSuccessOnDark
              : ColorConstant.textDangerOnDark,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Transform.rotate(
            angle: (success ? 0 : 180) * math.pi / 180,
            child: const Icon(
              Icons.flight,
              size: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImg(LaunchModel content) {
    final links = content.links;
    if (links == null) {
      return const SizedBox();
    }

    final images = links.images;
    final logo = links.logo;
    if (images != null && images.isNotEmpty) {
      return CustomNetworkImg(
        url: images.first,
        fit: BoxFit.cover,
      );
    }

    if (logo != null && logo.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: GridConstant.spacingBase,
        ),
        child: CustomNetworkImg(
          url: logo,
          fit: BoxFit.fitHeight,
        ),
      );
    }

    return const CustomNetworkImg(
      url:
          'https://static.vecteezy.com/system/resources/previews/012/003/110/non_2x/information-not-found-concept-illustration-flat-design-eps10-modern-graphic-element-for-landing-page-empty-state-ui-infographic-icon-vector.jpg',
      fit: BoxFit.cover,
    );
  }
}
