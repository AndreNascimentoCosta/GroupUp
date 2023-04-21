import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/medium_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/created_groups/components/dates.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IndividualCreatedGroup extends StatelessWidget {
  const IndividualCreatedGroup({
    required this.group,
  });

  final GroupModel group;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(37.5),
            child: group.image.isNotEmpty
                ? Container(
                    height: Insets.l * 3.75,
                    width: Insets.l * 3.75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          group.image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const GPIcon(
                    GPIcons.profile2,
                    height: Insets.xl * 3,
                    width: Insets.xl * 3,
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: kDefaultPadding,
              ),
              child: group.endDate!.isBefore(DateTime.now())
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StaticText(
                          text: Characters(group.projectName)
                              .replaceAll(
                                  Characters(''), Characters('\u{200B}'))
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                        ),
                        const SizedBox(height: Insets.s),
                        MediumBody(
                          text: appLocalizations.ended,
                          color: GPColors.secondaryColor,
                        ),
                      ],
                    )
                  : StaticText(
                      text: Characters(group.projectName)
                          .replaceAll(Characters(''), Characters('\u{200B}'))
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                    ),
            ),
          ),
          const SizedBox(width: Insets.s),
          ShowDates(
            group: group,
          )
        ],
      ),
    );
  }
}
