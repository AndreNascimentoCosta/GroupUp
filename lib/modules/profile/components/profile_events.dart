enum ProfileEvents {

  pressEditProfileButton('press_edit_profile_button'),

  pressCreatedGroupsButton('press_created_groups_button'),

  updateProfileName('update_profile_name'),

  reportProblem('report_problem'),

  pressPrivacyPolicyButton('press_privacy_policy_button'),

  pressOtherOptionsProfileButton('press_other_options_profile_button'),

  pressDeleteAccountButton('press_delete_account_button'),

  cancelDeleteAccount('cancel_delete_account'),

  confirmDeleteAccount('confirm_delete_account'),

  pressDiscardChangesEditProfileName('press_discard_changes_edit_profile_name'),

  keepChangesEditProfileName('keep_changes_edit_profile_name'),

  logout('logout');

  final String value;

  const ProfileEvents(this.value);
}
