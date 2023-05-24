import 'package:flutter/material.dart' show BuildContext, ModalRoute;

// This code defines an extension method named `getArgument` on the `BuildContext` class in Flutter's `material.dart` library. 
// The purpose of this method is to retrieve the argument of a specific type (`T`) that was passed to a named route when navigating to a new screen in a Flutter app.
extension GetArgument on BuildContext {
  T? getArgument<T>() {
    // Retrieve the current `ModalRoute` object associated with the context using the `ModalRoute.of` method.
    final modalRoute = ModalRoute.of(this);
    // If the `modalRoute` object is not null, then retrieve the arguments passed to the route using the `settings.arguments` property.
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      // If the arguments are not null and are of the requested type (`T`), then return the arguments cast to the specified type.
      if (args != null && args is T) {
        return args as T;
      }
    }
    // Return null if the arguments could not be retrieved or if they are not of the requested type.
    return null;
  }
}

/* This code defines an extension method named `getArgument` on the `BuildContext` class in Flutter's `material.dart` library. 
The purpose of this method is to retrieve the argument of a specific type (`T`) that was passed to a named route when 
navigating to a new screen in a Flutter app.
The method first retrieves the current `ModalRoute` object associated with the context using the `ModalRoute.of` method.
If the `modalRoute` object is not null, it then retrieves the arguments passed to the route using the `settings.arguments` 
property. If the arguments are not null and are of the requested type (`T`), the method returns the arguments cast to the 
specified type.
The use of this extension method simplifies the process of retrieving route arguments in a Flutter app by encapsulating the 
logic in a single method that can be called from any `BuildContext` object. For example, instead of writing 
`ModalRoute.of(context)!.settings.arguments as MyType` to retrieve an argument of type `MyType`, we can now simply write 
`context.getArgument<MyType>()`. */