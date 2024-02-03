enum IndividualGroupEvents {

  addInput('add_input'),

  editGroupPicture('edit_group_picture'),

  pressOkGroupEndedDialog('press_ok_group_ended_dialog'),

  pressObjectiveDialog('press_objective_dialog'),

  dismissObjectiveDialog('dismiss_objective_dialog'),

  pressRewardDialog('press_reward_dialog'),

  dismissRewardDialog('dismiss_reward_dialog'),

  pressParticipantStory('press_participant_story'),

  presBackButtonIndividualGroup('press_back_button_individual_group'),

  pageZeroPageViewIndividualGroup('page_zero_page_view_individual_group'),

  pressIndividualGroupSettingsButton('press_individual_group_settings_button'),

  pressChoosePhotoToChangeGroupPicture('press_choose_photo_to_change_group_picture'),

  pressTakePhotoToChangeGroupPicture('press_take_photo_to_change_group_picture'),

  dataValidated('data_validated'),

  dataInvalidated('data_invalidated'),

  pressOkTieBreakerDialog('press_ok_tie_breaker_dialog'),

  clearInputOfAddInput('clear_input_of_add_input'),

  addMediaAddInput('add_media_add_input'),

  dismissInstagrammable('dismiss_instagrammable'),

  pressImage1Instagrammable('press_image1_instagrammable'),

  pressImage2Instagrammable('press_image2_instagrammable'),

  pressImage3Instagrammable('press_image3_instagrammable'),

  pressImage4Instagrammable('press_image4_instagrammable'),

  pressImage5Instagrammable('press_image5_instagrammable'),

  shareInstagrammable('share_instagrammable');

  final String value;

  const IndividualGroupEvents(this.value);
}