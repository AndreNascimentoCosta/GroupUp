enum MainPageViewEvents {
  addProjectButton('home_tap_get_started_button'),

  mainPageViewScreen('main_page_view_screen'),

  pressCreateGroup('press_create_group'),

  pressJoinGroup('press_join_group');

  final String value;

  const MainPageViewEvents(this.value);
}
