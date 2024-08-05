import 'package:flutter/material.dart';
import 'package:spacex_app/constants/images.dart';
import 'package:spacex_app/core/theme/theme.dart';
import 'package:spacex_app/model/launch/launch.dart';
import 'package:spacex_app/utils/common.dart';
import 'package:url_launcher/url_launcher.dart';

class Content extends StatelessWidget {
  const Content({
    super.key,
    required this.name,
    required this.flightNumber,
    required this.fireDate,
    required this.crew,
    required this.success,
    required this.details,
    required this.urlLink,
  });

  final String name;
  final String flightNumber;
  final String fireDate;
  final List<CrewModel>? crew;
  final bool? success;
  final String? details;
  final String? urlLink;

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(GridConstant.spacingScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            const SizedBox(
              height: GridConstant.spacingMd,
            ),

            _buildBackground(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: GridConstant.spacingMd),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GridConstant.spacingScreen,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: GridConstant.spacingMd,
                        ),
                        const Divider(
                          height: 0,
                        ),
                        const SizedBox(
                          height: GridConstant.spacingMd,
                        ),
                      ],
                    ),
                  ),
                  _buildRowText(
                    label: 'Flight No.',
                    value: flightNumber.toString(),
                  ),
                  const SizedBox(
                    height: GridConstant.spacingBase,
                  ),
                  _buildRowText(
                    label: 'Fire Date',
                    value: fireDate,
                  ),
                  const SizedBox(
                    height: GridConstant.spacingBase,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: GridConstant.spacingScreen,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Crew :'),
                        Row(
                          children: [
                            Text(crew?.length.toString() ?? "0"),
                            const SizedBox(
                              width: GridConstant.spacingBase,
                            ),
                            const Icon(Icons.person),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: GridConstant.spacingBase,
                  ),
                  _buildRowText(
                    label: 'Successful Launch',
                    value: success == null
                        ? "-"
                        : success!
                            ? "Success"
                            : "Failed",
                    valueStyle: textTheme.bodyMedium!.copyWith(
                      color: success == null
                          ? null
                          : success!
                              ? ColorConstant.textSuccessOnDark
                              : ColorConstant.textDangerOnDark,
                    ),
                  ),
                ],
              ),
            )),

            //
            const SizedBox(
              height: GridConstant.spacingMd,
            ),
            details == null
                ? const SizedBox()
                : _buildBackground(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            GridConstant.spacingScreen,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Details :'),
                              const SizedBox(
                                height: GridConstant.spacingBase,
                              ),
                              Text(details!),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

            //
            const SizedBox(
              height: GridConstant.spacingMd,
            ),
            _buildLinkYoutube(urlLink)
          ],
        ),
      ),
    );
  }

  Widget _buildLinkYoutube(String? url) {
    if (url == null) {
      return const SizedBox();
    }
    return Material(
      color: Colors.white10,
      borderRadius: BorderRadius.circular(
        GridConstant.radiusBase,
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          _launchURL(url);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
            GridConstant.radiusBase,
          )),
          child: Padding(
            padding: const EdgeInsets.all(GridConstant.spacingMd),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.asset(MainImage.youtube),
                ),
                const SizedBox(
                  width: GridConstant.spacingMd,
                ),
                const Text('Watch clip on youtube'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowText({
    required String label,
    required String value,
    TextStyle? valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: GridConstant.spacingScreen,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          '$label :',
        ),
        Text(
          value,
          style: valueStyle,
        ),
      ]),
    );
  }

  Widget _buildBackground({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(
            GridConstant.radiusBase,
          )),
      child: child,
    );
  }
}
