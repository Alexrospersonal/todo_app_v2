enum RouteNames {
  userProfile(name: '/user_profile'),
  lists(name: '/lists'),
  archive(name: '/archive'),
  settings(name: '/settings'),
  feedback(name: '/feedback'),
  faq(name: '/faq');

  const RouteNames({required this.name});

  final String name;
}
