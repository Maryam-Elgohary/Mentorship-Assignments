// split the large interface into smaller, role-specific ones such as BasicController for init and dispose
abstract class BasicController {
  void initState();
  void dispose();
}

// for handling animations
abstract class AnimationController {
  void handleAnimation();
}

// for handling network
abstract class NetworkController {
  void handleNetwork();
}

class SimpleButtonController implements BasicController {
  @override
  void initState() => print('Init button');

  @override
  void dispose() => print('Dispose button');
}

class AnimatedButtonController implements BasicController, AnimationController {
  @override
  void initState() => print('Init animated button');

  @override
  void dispose() => print('Dispose animated button');

  @override
  void handleAnimation() => print('Handle animation for animated button');
}

class NetworkedWidgetController implements BasicController, NetworkController {
  @override
  void initState() => print('Init networked widget');

  @override
  void dispose() => print('Dispose networked widget');

  @override
  void handleNetwork() => print('Handle network for widget');
}
