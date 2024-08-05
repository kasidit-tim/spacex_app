import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spacex_app/constants/images.dart';
import 'package:spacex_app/core/theme/theme.dart';
import 'package:spacex_app/core/widgets/no_data.dart';
import 'package:spacex_app/model/launch_filter.dart';
import 'package:spacex_app/modules/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacex_app/modules/home/views/widgets/contents.dart';
import 'package:spacex_app/utils/common.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String? _lastQuery;

  @override
  void initState() {
    super.initState();
    _load();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  _load({
    SortNameType? sortName,
    SortFlightNumberType? sortFlightNumber,
  }) {
    final bloc = context.read<HomeBloc>();
    bloc.add(
      LoadEvent(
        filter: LaunchFilter(
          page: 1,
          sortName: sortName,
          sortFlightNumber: sortFlightNumber,
        ),
      ),
    );
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 200), () {
      final query = _controller.text;

      if (query != _lastQuery) {
        final bloc = context.read<HomeBloc>();
        final filter = bloc.state.filter;
        if (query.isEmpty) {
          bloc.add(const ResetSearchEvent());
        } else {
          bloc.add(LoadEvent(
            filter: filter.copyWith(
              page: 1,
              search: query,
            ),
          ));
        }
        _lastQuery = query;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: ColorConstant.primaryBackground,
        centerTitle: true,
        title: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              color: ColorConstant.primaryCard,
              borderRadius: BorderRadius.all(
                Radius.circular(GridConstant.radiusLg),
              )),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(MainImage.appIcon),
              ),
              const SizedBox(
                width: GridConstant.spacingMd,
              ),
              Text(
                'SPACE X',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(
                width: GridConstant.spacingMd,
              ),
            ],
          ),
        ),
        actions: [
          PopupMenuButton(
              icon: const Icon(
                Icons.sort,
                color: Colors.white,
              ),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: SortNameType.asc,
                    child: Text("Sort By Name A-Z"),
                  ),
                  const PopupMenuItem(
                    value: SortNameType.desc,
                    child: Text("Sort By Name Z-A"),
                  ),
                  const PopupMenuItem(
                    value: SortFlightNumberType.desc,
                    child: Text("Sort by latest flight number"),
                  ),
                  const PopupMenuItem(
                    value: SortFlightNumberType.asc,
                    child: Text("Sort by oldest flight number"),
                  ),
                ];
              },
              onSelected: (value) {
                switch (value) {
                  case SortNameType.asc:
                    _load(sortName: SortNameType.asc);
                  case SortNameType.desc:
                    _load(sortName: SortNameType.desc);
                  case SortFlightNumberType.asc:
                    _load(sortFlightNumber: SortFlightNumberType.asc);
                  case SortFlightNumberType.desc:
                    _load(sortFlightNumber: SortFlightNumberType.desc);
                }
              }),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(
              height: GridConstant.spacingLg,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: GridConstant.spacingScreen,
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search By Name',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: ColorConstant.primaryCard,
                  hoverColor: ColorConstant.primaryCard,
                  focusColor: ColorConstant.primaryCard,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(GridConstant.radiusSm),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) {
                return previous.loading != current.loading ||
                    previous.isLoadMore != current.isLoadMore;
              }, builder: (context, state) {
                if (state.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final contents = state.data.docs;

                if (contents.isEmpty) {
                  return const NoData();
                }

                return LaunchesContents(
                  contents: contents,
                  nextPage: state.data.nextPage,
                  isLoadMore: state.isLoadMore,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
