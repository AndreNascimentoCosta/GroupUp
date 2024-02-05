import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/modules/individual_group/components/calendar_add_input/data_history.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditAndHistoryGroupButton extends StatefulWidget {
  const EditAndHistoryGroupButton({
    required this.homeViewModel,
    this.backgroundColor = GPColors.primaryColor,
  });

  final HomeViewModel homeViewModel;
  final Color backgroundColor;

  @override
  State<EditAndHistoryGroupButton> createState() =>
      _EditAndHistoryGroupButtonState();
}

class _EditAndHistoryGroupButtonState extends State<EditAndHistoryGroupButton> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    if (individualGroupProvider.group == null) {
      return const GPLoading();
    }
    final user = Provider.of<AuthProvider>(
      context,
    ).user;
    final userInputData = individualGroupProvider.group!.participantsData
        .firstWhere(
          (element) => element.uid == user?.id,
        )
        .inputData;
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: ValueListenableBuilder(
          valueListenable: widget.homeViewModel.isEditing,
          builder: (context, value, child) {
            if (widget.homeViewModel.isEditing.value) {
              return FloatingActionButton(
                heroTag: 'btn5',
                highlightElevation: 0,
                onPressed: widget.homeViewModel.switchEdit,
                backgroundColor: widget.backgroundColor,
                elevation: 0,
                child: const GPIcon(
                  GPIcons.exit,
                  height: Insets.xl,
                  width: Insets.xl,
                ),
              );
            }
            if (individualGroupProvider.pageIndex == 0) {
              return FloatingActionButton(
                heroTag: 'btn4',
                onPressed: individualGroupProvider.pageIndex == 0
                    ? widget.homeViewModel.switchEdit
                    : () {
                        Provider.of<MixPanelProvider>(
                          context,
                          listen: false,
                        ).logEvent(
                          eventName: 'View Data History',
                        );
                        gpModalBottomSheet(
                          context,
                          500,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: Insets.l),
                                GPTextBody(
                                  text: appLocalizations.dataHistory,
                                  textAlign: TextAlign.center,
                                  fontSize: 24,
                                ),
                                const SizedBox(height: Insets.l),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: GPTextBody(
                                        text: appLocalizations.dates,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: Insets.l),
                                    Expanded(
                                      child: GPTextBody(
                                        text: appLocalizations.values,
                                        textAlign: TextAlign.center,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Insets.l),
                                if (userInputData.isEmpty)
                                  GPTextBody(
                                    text: appLocalizations.noData,
                                    textAlign: TextAlign.center,
                                    color: GPColors.secondaryColor,
                                    fontSize: 16,
                                  ),
                                Expanded(
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      height: 20,
                                      thickness: 0.5,
                                      color: GPColors.secondaryColor,
                                    ),
                                    itemCount: userInputData.length,
                                    itemBuilder: ((context, index) {
                                      int itemCount = userInputData.length;
                                      int reversedIndex = itemCount - 1 - index;
                                      return Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: GPTextBody(
                                              text: DateFormat.yMd(
                                                Localizations.localeOf(context)
                                                    .toLanguageTag(),
                                              ).format(
                                                  userInputData[reversedIndex]
                                                      .date),
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(width: Insets.l),
                                          Expanded(
                                            child: GPTextBody(
                                              text: userInputData[reversedIndex]
                                                  .value
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                backgroundColor: widget.backgroundColor,
                highlightElevation: 0,
                elevation: 0,
                child: individualGroupProvider.pageIndex == 0
                    ? const GPIcon(
                        GPIcons.edit,
                        height: Insets.xl,
                        width: Insets.xl,
                      )
                    : const Icon(
                        Icons.history,
                        size: 30,
                      ),
              );
            } else {
              return DataHistoryButton(
                homeViewModel: widget.homeViewModel,
              );
            }
          },
        ),
      ),
    );
  }
}
