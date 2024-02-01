enum EditProfileEvents {
  pressBackButtonEditProfile('press_back_button_edit_profile'),

  editProfilePictureChooseFromGallery(
      'edit_profile_picture_choose_from_gallery'),

  editProfilePictureTakePhoto('edit_profile_picture_take_photo'),

  editNameScreen('edit_name_screen');

  final String value;

  const EditProfileEvents(this.value);
}
