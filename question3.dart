// introduce a Navigable interface implemented only by screens that support navigation
abstract class Navigable {
  void navigate();
}

// This screen include the navigation method
class HomeScreen implements Navigable {
  @override
  void navigate() {
    print('Navigating to home');
  }
}

//This class is non-navigable
class SettingsScreen {
  // no navigate, handled differently
}

class NavigationButton extends StatelessWidget {
  final Navigable screen; 
  NavigationButton(this.screen);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => screen.navigate(),
      child: Text('Navigate'),
    );
  }
}
