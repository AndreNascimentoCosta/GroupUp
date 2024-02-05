enum JoinGroupEvents {
  pressBackButtonJoinGroup('press_back_button_join_group'),

  pressNextButtonJoinGroup('press_next_button_join_group'),

  pressJoinGroupButton('press_join_group_button');
  
  final String value;

  const JoinGroupEvents(this.value);
}