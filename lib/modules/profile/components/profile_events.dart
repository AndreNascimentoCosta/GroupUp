enum ProfileEvents {

  pressEditProfileButton('press_edit_profile_button'),

  pressCreatedGroupsButton('press_created_groups_button'),

  reportProblem('report_problem'),

  pressPrivacyPolicyButton('press_privacy_policy_button'),

  pressOtherOptionsProfileButton('press_other_options_profile_button'),

  pressDeleteAccountButton('press_delete_account_button'),

  cancelDeleteAccount('cancel_delete_account'),

  confirmDeleteAccount('confirm_delete_account'),

  logout('logout');

  final String value;

  const ProfileEvents(this.value);
}
