enum CreateGroupEvents {
  pressBackButtonCreateGroup('press_back_button_create_group'),

  shareGroupCode('share_group_code'),

  pressAddGroupPicture('press_add_group_picture'),

  pressChooseFromGalleryAddPicture('press_choose_from_gallery_add_picture'),

  pressTakePhotoAddPicture('press_take_photo_add_picture');
    
  final String value;
  
  const CreateGroupEvents(this.value);
}