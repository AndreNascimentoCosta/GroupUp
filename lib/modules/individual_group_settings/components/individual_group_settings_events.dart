enum IndividualGroupSettingsEvents {

  pressBackButtonIndividualGroupSettings('press_back_button_individual_group_settings'),

  pressReportParticipantScreen('press_report_participant_screen'),

  pressEditGroupName('press_edit_group_name'),

  pressEditGroupObjetive('press_edit_group_objetive'),

  pressEditGroupReward('press_edit_group_reward'),

  pressEditGroupDates('press_edit_group_dates'),

  pressOkCantChangeDates('press_ok_cant_change_dates'),

  pressEditNumberOfParticipants('press_edit_number_of_participants'),

  pressOkCantEditNumberOfParticipants('press_ok_cant_edit_number_of_participants'),

  shareGroupCode('share_group_code'),

  pressExitGroup('press_exit_group'),

  pressBackButtonEditGroupDates('press_back_button_edit_group_dates'),

  pressDiscardAndBackButtonEditGroupDates('press_discard_and_back_button_edit_group_dates'),

  pressBackButtonEditNumberOfParticipants('press_back_button_edit_number_of_participants'),

  pressDiscardAndBackButtonEditNumberOfParticipants('press_discard_and_back_button_edit_number_of_participants'),

  pressBackButtonEditGroupObjective('press_back_button_edit_group_objective'),

  pressDiscardChangesEditGroupObjective('press_discard_changes_edit_group_objective'),

  pressBackButtonEditGroupReward('press_back_button_edit_group_reward'),

  pressDiscardChangesEditGroupReward('press_discard_changes_edit_group_reward'),

  pressBackButtonEditGroupName('press_back_button_edit_group_name'),

  pressDiscardChangesEditGroupName('press_discard_changes_edit_group_name');

  final String value;
  const IndividualGroupSettingsEvents(this.value);
}