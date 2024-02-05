enum CreateGroupEvents {
  pressBackButtonCreateGroup('press_back_button_create_group'),

  shareGroupCode('share_group_code'),

  pressAddGroupPicture('press_add_group_picture'),

  pressChooseFromGalleryAddPicture('press_choose_from_gallery_add_picture'),

  pressTakePhotoAddPicture('press_take_photo_add_picture'),

  pressCancelCreateGroupDialog('press_cancel_create_group_dialog'),

  confirmCreateGroup('confirm_create_group'),

  pressCreateGroupSuccessDialog('press_create_group_success_dialog'),

  pressNextButtonCreateGroup('press_next_button_create_group'),

  pressCancelLeaveGroupDialog('press_cancel_leave_group_dialog'),

  pressLeaveGroup('press_leave_group'),

  addProfilePicture('add_profile_picture'),;
    
  final String value;
  
  const CreateGroupEvents(this.value);
}