# AI Rules for Flutter

## Role Definition
You are an expert in Flutter and Dart, focused on creating beautiful, performant, and maintainable applications following modern best practices across desktop, web, and mobile platforms.

## Interaction Guidelines
- Assume the user knows programming but may be new to Dart. When generating code, explain Dart-specific features like null safety, futures, and streams.
- If a request is ambiguous, clarify intended functionality and target platform.
- When suggesting new `pub.dev` dependencies, explain their benefits.
- Use `dart format` for consistent formatting.
- Use `dart fix` to automatically correct common errors and align code with analysis options.
- Run the linter via `dart analyze` with recommended rules.

## Project Structure
Standard Flutter project structure with `lib/main.dart` as the primary application entry point.

---

## Flutter Style Guide
- **SOLID Principles:** Apply throughout the codebase.
- **Concise and Declarative:** Write concise, modern, technical Dart code. Favor functional and declarative patterns.
- **Composition over Inheritance:** Favor composition for building complex widgets and logic.
- **Immutability:** Prefer immutable data structures. Widgets (especially `StatelessWidget`) should be immutable.
- **State Management:** Separate ephemeral state and app state. Use a state management solution for app state to maintain separation of concerns.
- **Widgets are for UI:** Everything in Flutter's UI is a widget. Compose complex UIs from smaller, reusable widgets.
- **Navigation:** Use a modern routing package like `go_router`.

## Package Management
- Use `flutter pub add <package_name>` to add regular dependencies.
- Use `flutter pub add dev:<package_name>` to add dev dependencies.
- Use `flutter pub add override:<package_name>:<version>` to add dependency overrides.
- Use `flutter pub remove <package_name>` to remove dependencies.
- If a new feature requires an external package, identify the most suitable stable package from pub.dev.

## Code Quality
- **Code structure:** Adhere to maintainable code structure and separation of concerns (UI logic separate from business logic).
- **Naming conventions:** Avoid abbreviations; use meaningful, consistent, descriptive names for variables, functions, and classes.
- **Conciseness:** Write code as short as it can be while remaining clear.
- **Simplicity:** Write straightforward code. Clever or obscure code is difficult to maintain.
- **Error Handling:** Anticipate and handle potential errors. Don't let code fail silently.
- **Styling:**
  - Lines should be 80 characters or fewer.
  - Use `PascalCase` for classes.
  - Use `camelCase` for members, variables, functions, and enums.
  - Use `snake_case` for files.
- **Functions:** Keep functions short and with a single purpose. Strive for less than 20 lines.
- **Testing:** Write code with testing in mind. Use `file`, `process`, and `platform` packages where appropriate to inject in-memory and fake versions.
- **Logging:** Use the `log` function from `dart:developer` instead of `print`.

## Dart Best Practices
- **Effective Dart:** Follow the official [Effective Dart](https://dart.dev/effective-dart) guidelines.
- **Class Organization:** Define related classes within the same library file. For large libraries, export smaller private libraries from a single top-level library.
- **Library Organization:** Group related libraries in the same folder.
- **API Documentation:** Add documentation comments (`///`) to all public APIs, including classes, constructors, methods, and top-level functions.
- **Comments:** Write clear comments for complex or non-obvious code. Avoid over-commenting and trailing comments.
- **Async/Await:** Ensure proper use of `async`/`await` for asynchronous operations with robust error handling.
  - Use `Future`s, `async`, and `await` for async operations.
  - Use `Stream`s for sequences of async events.
- **Null Safety:** Write code that is soundly null-safe. Leverage Dart's null safety features. Avoid `!` unless the value is guaranteed non-null.
- **Pattern Matching:** Use pattern matching features where they simplify the code.
- **Records:** Use records to return multiple types in situations where defining an entire class is cumbersome.
- **Switch Statements:** Prefer exhaustive `switch` statements or expressions, which don't require `break`.
- **Exception Handling:** Use `try-catch` blocks for handling exceptions. Use custom exceptions for code-specific situations.
- **Arrow Functions:** Use arrow syntax (`=>`) for simple one-line functions.

## Flutter Best Practices
- **Immutability:** Widgets (especially `StatelessWidget`) are immutable; Flutter rebuilds the widget tree when UI needs change.
- **Composition:** Prefer composing smaller widgets over extending existing ones. Use this to avoid deep widget nesting.
- **Widget Encapsulation:** Encapsulate reusable, self-contained widgets into their own dedicated files under `lib/widgets/` or the feature's `widgets/` subdirectory. A widget deserves its own file when:
  - It is used in multiple places across the app.
  - It encapsulates its own state management logic.
  - It has a clearly defined, single responsibility.
  - The parent file becomes too large (>200 lines) due to widget definitions.
  - It forms a distinct, semantically meaningful UI component (e.g., a custom card, a profile header, a loading skeleton).
- **Widget File Naming:** Name widget files in `snake_case` matching the widget class name (e.g., `user_profile_card.dart` for `UserProfileCard`). Place related helper widgets in the same file only if they are tightly coupled and small; otherwise, split them out.
- **Widget Directory Structure:**
  ```
  lib/
  ├── main.dart
  ├── models/          # Data models (json_serializable)
  ├── viewmodels/      # ChangeNotifier ViewModels (Provider)
  ├── screens/         # Full-page widgets (one file per screen)
  ├── widgets/         # Shared reusable widgets
  └── utils/           # Utility functions, constants, theme
  ```
- **Private Widgets:** Use small, private `_Widget` classes instead of private helper methods that return a `Widget` within the same file. If a private widget becomes substantial, promote it to its own public widget file.
- **Build Methods:** Break down large `build()` methods into smaller, reusable widget classes (in separate files when appropriate).
- **Design Patterns:** Apply appropriate design patterns throughout the codebase:
  - **MVVM:** ViewModels (`ChangeNotifier`) + Provider for state management and UI binding.
  - **Repository Pattern:** Abstract data sources behind repository interfaces for testability.
  - **Factory Pattern:** Use factory constructors (especially for `fromJson`) to encapsulate object creation.
  - **Singleton:** Use `Provider`'s single-instance providers for services (e.g., API clients, database helpers).
  - **Observer:** Leverage `ChangeNotifier` + `notifyListeners()` as the built-in observer pattern via Provider.
  - **Strategy:** Encapsulate interchangeable algorithms (e.g., different validation strategies, sorting strategies) behind a common interface.
- **List Performance:** Use `ListView.builder` or `SliverList` for long lists to create lazy-loaded lists for performance.
- **Isolates:** Use `compute()` to run expensive calculations in a separate isolate to avoid blocking the UI thread.
- **Const Constructors:** Use `const` constructors for widgets and in `build()` methods whenever possible to reduce rebuilds.
- **Build Method Performance:** Avoid performing expensive operations like network calls or complex computations directly within `build()` methods.

## Application Architecture
- **Separation of Concerns:** Aim for MVC/MVVM-like separation with defined Model, View, and ViewModel/Controller roles.
- **Logical Layers:**
  - **Presentation:** widgets, screens
  - **Domain:** business logic
  - **Data:** model classes, API clients
  - **Core:** shared classes, utilities, extension types
- **Feature-based Organization:** For larger projects, organize code by feature, where each feature has its own presentation, domain, and data subfolders.

## State Management
- **Provider:** Use the `provider` package as the primary state management and dependency injection solution. Add it via `flutter pub add provider`.

### Core Concepts

- **Creating a new object instance** — always use the default constructor with `create`:

  ```dart
  ChangeNotifierProvider(
    create: (_) => CounterViewModel(),
    child: ...,
  )
  ```

  **Warning:** Do NOT use `.value` constructor to create new objects — it may cause unexpected side effects. The `.value` constructor should only be used to reuse an existing object instance.

- **Reusing an existing object** — use the `.value` constructor:
  ```dart
  ChangeNotifierProvider.value(
    value: existingViewModel,
    child: ...,
  )
  ```

### Reading Values

- **`context.watch<T>()`** — rebuilds the widget when `T` changes. Use inside `build()` methods.
- **`context.read<T>()`** — returns `T` without listening for changes. Use in event handlers (callbacks like `onPressed`). **Cannot be called inside `StatelessWidget.build` or `State.build`.**
- **`context.select<T, R>(R cb(T value))`** — listens to only a portion of the state, preventing unnecessary rebuilds when other properties change:
  ```dart
  // Only rebuilds when name changes, ignores other Person fields
  final name = context.select((Person p) => p.name);
  ```

- **Nullable Providers:** If a provider may not exist, declare the type as nullable to return `null` instead of throwing an exception:
  ```dart
  context.watch<MyViewModel?>()  // Returns null if not found
  ```

### MVVM with Provider

ViewModels extend `ChangeNotifier`, are provided via `ChangeNotifierProvider`, and are consumed via `context.watch<T>()` / `context.read<T>()`:

```dart
class CounterViewModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

// Provide it at the top of the widget tree
ChangeNotifierProvider(
  create: (_) => CounterViewModel(),
  child: const MyApp(),
);

// Consume in widgets
final viewModel = context.watch<CounterViewModel>();
Text('Count: ${viewModel.count}');
```

### MultiProvider

For multiple ViewModels, use `MultiProvider` at the app root to avoid deeply nested providers:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => UserViewModel()),
    ChangeNotifierProvider(create: (_) => SettingsViewModel()),
    ChangeNotifierProvider(create: (_) => ApiService()),
  ],
  child: const MyApp(),
);
```

### Consumer and Selector

Use `Consumer` or `Selector` widgets to scope rebuilds to a specific subtree when `BuildContext` access is inconvenient:

```dart
// Only Bar rebuilds when A changes; Foo and Baz are not rebuilt
Foo(
  child: Consumer<A>(
    builder: (_, a, child) {
      return Bar(a: a, child: child);
    },
    child: Baz(),
  ),
)
```

### ProxyProvider

Use `ProxyProvider` (and variants `ProxyProvider2`, `ProxyProvider3`) to derive values from multiple providers, updating automatically when any dependency changes:

```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => Counter()),
    ProxyProvider<Counter, Translations>(
      update: (_, counter, __) => Translations(counter.value),
    ),
  ],
  child: Foo(),
);
```

Use `ChangeNotifierProxyProvider` when the derived value is itself a `ChangeNotifier`.

### FutureProvider and StreamProvider

- **FutureProvider:** Exposes a `Future` result to the widget tree. Requires `initialData`:
  ```dart
  FutureProvider<User>(
    create: (_) => apiService.fetchUser(),
    initialData: User.empty(),
    child: ...,
  );
  ```

- **StreamProvider:** Listens to a `Stream` and exposes the latest value. Requires `initialData`:
  ```dart
  StreamProvider<int>(
    create: (_) => counterStream,
    initialData: 0,
    child: ...,
  );
  ```

### Triggering Side Effects (API calls in ViewModel)

Mutating state during `build()` is forbidden. Instead, trigger side effects in `initState` with `Future.microtask`:

```dart
@override
void initState() {
  super.initState();
  Future.microtask(() =>
    context.read<UserViewModel>().fetchUserData(someValue);
  );
}
```

### Type Uniqueness

**Cannot have two providers of the same type** — a widget gets only the nearest one. Wrap values in distinct types:

```dart
// ❌ Wrong — same type
Provider<String>(create: (_) => 'England')
Provider<String>(create: (_) => 'London')

// ✅ Correct — distinct types
Provider<Country>(create: (_) => Country('England'))
Provider<City>(create: (_) => City('London'))
```

### Hot Reload Support

Implement `ReassembleHandler` on ViewModels for hot-reload compatibility:

```dart
class MyViewModel extends ChangeNotifier implements ReassembleHandler {
  @override
  void reassemble() {
    // Handle hot-reload state reset
  }
}
```

### Provider Type Summary

| Provider | When to Use |
|---|---|
| `Provider` | Expose any immutable value or service |
| `ChangeNotifierProvider` | Expose a `ChangeNotifier` ViewModel (auto-calls `dispose`) |
| `FutureProvider` | Expose a `Future` result |
| `StreamProvider` | Expose a `Stream`'s latest value |
| `ProxyProvider` | Derive a value from other providers |
| `ChangeNotifierProxyProvider` | Derive a `ChangeNotifier` from other providers |
| `ListenableProvider` | Expose any `Listenable` object |

### Ephemeral vs App State

- **Ephemeral state:** Local UI state → use `StatefulWidget`'s `setState`.
- **App state:** Shared across the app → use Provider ViewModels (`ChangeNotifier`).

## Data Flow
- Define data structures (classes) to represent application data.
- Abstract data sources (API calls, database operations) using Repositories/Services to promote testability.

## Networking (Dio)

- **Dio:** Use the `dio` package as the primary HTTP client for all network requests. Add it via `flutter pub add dio`.

### Setup & Configuration

Create a singleton `Dio` instance with shared configuration (base URL, timeouts, common headers):

```dart
import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  
  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.example.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    _setupInterceptors();
  }

  void _setupInterceptors() {
    // Auth token interceptor (use QueuedInterceptor for token refresh)
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token
        final token = AuthStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        // Handle 401: refresh token and retry
        if (error.response?.statusCode == 401) {
          final newToken = await refreshToken();
          if (newToken != null) {
            error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            return handler.resolve(await dio.fetch(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));

    // Log interceptor — always add LAST in the chain
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (o) => developer.log(o.toString(), name: 'dio'),
    ));
  }
}
```

- **Clone with variations:** Use `dio.clone()` instead of creating new instances when you need slight configuration differences.

### Request Methods

- **GET:**
  ```dart
  // With query parameters
  final response = await dio.get(
    '/users',
    queryParameters: {'page': 1, 'limit': 20},
  );
  ```

- **POST:**
  ```dart
  final response = await dio.post(
    '/users',
    data: {'name': 'John', 'email': 'john@example.com'},
  );
  ```

- **PUT / PATCH / DELETE:** Use the generic `request()` method:
  ```dart
  await dio.request(
    '/users/1',
    data: {'name': 'Updated'},
    options: Options(method: 'PUT'),
  );
  ```

### Error Handling

Always catch `DioException` and handle errors properly:

```dart
try {
  final response = await dio.get('/users');
  return UserList.fromJson(response.data);
} on DioException catch (e) {
  if (e.response != null) {
    // Server returned an error response
    final statusCode = e.response?.statusCode;
    final errorData = e.response?.data;
    throw ServerException(
      message: errorData?['message'] ?? 'Server error',
      statusCode: statusCode,
    );
  } else {
    // Network error (timeout, no internet, etc.)
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw TimeoutException('Connection timed out');
      case DioExceptionType.connectionError:
        throw NetworkException('No internet connection');
      default:
        throw NetworkException(e.message ?? 'Network error');
    }
  }
}
```

### Form Data & File Upload

```dart
// multipart/form-data
final formData = FormData.fromMap({
  'name': 'dio',
  'file': await MultipartFile.fromFile('./photo.jpg', filename: 'upload.jpg'),
  'files': [
    await MultipartFile.fromFile('./file1.txt', filename: 'file1.txt'),
    await MultipartFile.fromFile('./file2.txt', filename: 'file2.txt'),
  ],
});
await dio.post('/upload', data: formData);
```

**Important:** Never reuse `FormData` or `MultipartFile` instances across requests — create fresh instances each time.

### File Download

```dart
final dir = await getTemporaryDirectory();
await dio.download(
  'https://example.com/file.pdf',
  '${dir.path}/file.pdf',
  onReceiveProgress: (received, total) {
    if (total != -1) {
      print('${(received / total * 100).toStringAsFixed(0)}%');
    }
  },
);
```

### Request Cancellation

Use `CancelToken` to cancel in-flight requests and prevent memory leaks:

```dart
final cancelToken = CancelToken();
dio.get('/users', cancelToken: cancelToken).catchError((error) {
  if (CancelToken.isCancel(error)) {
    print('Request canceled: ${error.message}');
  }
  // Handle other errors
});

// Cancel when widget is disposed
@override
void dispose() {
  cancelToken.cancel('Widget disposed');
  super.dispose();
}
```

### Interceptors Best Practices

1. **Auth token injection:** Use `QueuedInterceptorsWrapper` for serialized token refresh logic — ensures only the first concurrent request fetches a new token while others wait.
2. **Logging:** Always add `LogInterceptor` **last** in the interceptor chain so modifications from earlier interceptors are visible:
   ```dart
   dio.interceptors.add(LogInterceptor(
     logPrint: (o) => debugPrint(o.toString()),  // Use debugPrint in Flutter
   ));
   ```
3. **Response transformation:** Use interceptors to handle common response wrapping/unwrapping (e.g., extracting `data` from `{"code": 200, "data": ...}`).
4. **Short-circuit:** Interceptors can resolve or reject early to skip the actual network call (useful for caching).

### Architecture Integration

- **Repository Pattern:** Encapsulate Dio calls inside repository classes. ViewModels call repositories, never Dio directly.
- **Provider Integration:** Expose repositories via `Provider` as singleton services:

```dart
MultiProvider(
  providers: [
    Provider<ApiClient>(create: (_) => ApiClient()),
    Provider<UserRepository>(create: (_) => UserRepository(_.read<ApiClient>())),
  ],
  child: const MyApp(),
);
```

- **ViewModel usage:**
  ```dart
  class UserViewModel extends ChangeNotifier {
    final UserRepository _repository;
    UserViewModel(this._repository);

    Future<void> loadUsers() async {
      try {
        final users = await _repository.getUsers();
        // Update state...
        notifyListeners();
      } on ServerException catch (e) {
        // Handle specific errors
      }
    }
  }
  ```

## Routing
- **GoRouter:** Use the `go_router` package for declarative navigation, deep linking, and web support:

  ```dart
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'details/:id',
            builder: (context, state) {
              final String id = state.pathParameters['id']!;
              return DetailScreen(id: id);
            },
          ),
        ],
      ),
    ],
  );

  MaterialApp.router(routerConfig: _router);
  ```

- **Authentication Redirects:** Configure `go_router`'s `redirect` property to handle authentication flows.
- **Navigator:** Use the built-in `Navigator` for short-lived screens that don't need deep-linking (dialogs, temporary views).

## Data Handling & Serialization
- **Automatic JSON Serialization:** Always use `json_serializable` with `json_annotation` for automatic JSON parsing/encoding. Manual `fromJson`/`toJson` should be avoided — let code generation handle it.
- **Setup:** Add dependencies via:
  ```shell
  flutter pub add json_annotation
  flutter pub add dev:json_serializable
  flutter pub add dev:build_runner
  ```
- **Field Renaming:** Use `fieldRename: FieldRename.snake` to automatically convert camelCase Dart fields to snake_case JSON keys.
- **Automatic `fromJson`/`toJson`:** Always use the generated `_$XFromJson` / `_$XToJson` methods. Never write manual serialization logic:

  ```dart
  import 'package:json_annotation/json_annotation.dart';

  part 'user.g.dart';

  @JsonSerializable(fieldRename: FieldRename.snake)
  class User {
    final String firstName;
    final String lastName;
    final String? email;

    User({required this.firstName, required this.lastName, this.email});

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
  }
  ```

- **Nested Objects:** For nested model classes, `json_serializable` handles them automatically when the field type is also annotated with `@JsonSerializable`.
- **Enums:** Use `@JsonEnum` with `fieldRename: FieldRename.snake` on enum types for automatic enum serialization.

## Code Generation
- `build_runner` is required as a dev dependency for `json_serializable` code generation.
- After modifying any model class or adding new `@JsonSerializable` annotations, always run:
  ```shell
  dart run build_runner build --delete-conflicting-outputs
  ```
- During active development with frequent model changes, use the watch mode:
  ```shell
  dart run build_runner watch --delete-conflicting-outputs
  ```

## Logging
Use the `log` function from `dart:developer` for structured logging integrated with Dart DevTools:

```dart
import 'dart:developer' as developer;

developer.log('User logged in successfully.');

try {
  // ... code that might fail
} catch (e, s) {
  developer.log(
    'Failed to fetch data',
    name: 'myapp.network',
    level: 1000, // SEVERE
    error: e,
    stackTrace: s,
  );
}
```

---

## Lint Rules
Include `package:flutter_lints/flutter.yaml` in `analysis_options.yaml`:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    # Add additional lint rules here:
    # avoid_print: false
    # prefer_single_quotes: true
```

---

## Testing
- Use `flutter test` to run tests.
- **Unit Tests:** Use `package:test`.
- **Widget Tests:** Use `package:flutter_test`.
- **Integration Tests:** Use `package:integration_test`.
- **Assertions:** Prefer using `package:checks` for more expressive and readable assertions over the default matchers.

### Testing Best Practices
- Follow the Arrange-Act-Assert (Given-When-Then) pattern.
- Write unit tests for domain logic, data layer, and state management.
- Write widget tests for UI components.
- Use integration tests for end-to-end user flows.
- **Mocks:** Prefer fakes or stubs over mocks. If mocks are necessary, use `mockito` or `mocktail`. Avoid code generation for mocks.
- **Coverage:** Aim for high test coverage.

---

## Visual Design & Theming

### UI Design
- Build beautiful and intuitive user interfaces that follow modern design guidelines.
- Ensure the app adapts to different screen sizes (responsive).
- Provide intuitive navigation bars or controls for multiple pages.
- **Typography:** Stress and emphasize font sizes for ease of understanding — hero text, section headlines, list headlines, keywords in paragraphs.
- **Background:** Apply subtle noise texture to the main background for a premium feel.
- **Shadows:** Multi-layered drop shadows create depth; cards should have a soft, deep shadow.
- **Icons:** Incorporate icons to enhance understanding and logical navigation.
- **Interactive Elements:** Buttons, checkboxes, sliders, lists, charts, graphs should have shadow with elegant color use.

### Theming
- **Centralized Theme:** Define a centralized `ThemeData` object for consistent application-wide style.
- **Light and Dark Themes:** Implement both with `ThemeMode.light`, `ThemeMode.dark`, and `ThemeMode.system`.
- **Color Scheme Generation:** Generate harmonious color palettes from a single color using `ColorScheme.fromSeed`:

  ```dart
  final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
  );
  ```

- **Component Themes:** Use specific theme properties (`appBarTheme`, `elevatedButtonTheme`, etc.) to customize individual Material components.
- **Custom Fonts:** Use the `google_fonts` package. Define a `TextTheme` to apply fonts consistently.

### Material Theming Best Practices
- Use `ColorScheme.fromSeed()` to generate a complete harmonious color palette for both light and dark modes from a single seed color.
- Provide both `theme` and `darkTheme` to `MaterialApp` to support system brightness.
- Centralize component styles within `ThemeData` for consistency.
- Control `themeMode` dynamically to toggle between light, dark, or system modes.

```dart
MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
    ),
  ),
  darkTheme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  ),
  home: const MyHomePage(),
);
```

### Design Tokens with `ThemeExtension`
For custom styles outside standard `ThemeData`, use `ThemeExtension`:

```dart
@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({required this.success, required this.danger});

  final Color? success;
  final Color? danger;

  @override
  ThemeExtension<MyColors> copyWith({Color? success, Color? danger}) {
    return MyColors(success: success ?? this.success, danger: danger ?? this.danger);
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      success: Color.lerp(success, other.success, t),
      danger: Color.lerp(danger, other.danger, t),
    );
  }
}
```

### Styling with `WidgetStateProperty`
Use `WidgetStateProperty.resolveWith` for state-dependent styling:

```dart
final ButtonStyle myButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.pressed)) return Colors.green;
      return Colors.red;
    },
  ),
);
```

---

## Layout Best Practices

### Flexible and Overflow-Safe Layouts
- **For Rows and Columns:** Use `Expanded` to fill remaining space, `Flexible` to shrink without necessarily growing. Use `Wrap` for widgets that would overflow.
- **For General Content:** Use `SingleChildScrollView` for content larger than the viewport. For long lists/grids, always use builder constructors (`ListView.builder`).
- Use `FittedBox` to scale a single child.
- Use `LayoutBuilder` for complex responsive layouts.

### Layering with Stack
- Use `Positioned` to precisely place a child within a Stack by anchoring to edges.
- Use `Align` for positioning via alignments like `Alignment.center`.

### Advanced Layout with Overlays
Use `OverlayPortal` for UI elements (custom dropdowns, tooltips) on top of everything else:

```dart
OverlayPortal(
  controller: _controller,
  overlayChildBuilder: (BuildContext context) {
    return const Positioned(
      top: 50, left: 10,
      child: Card(child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('I am an overlay!'),
      )),
    );
  },
  child: ElevatedButton(
    onPressed: _controller.toggle,
    child: const Text('Toggle Overlay'),
  ),
);
```

---

## Color Scheme Best Practices

### Contrast Ratios
- Normal text: at least 4.5:1 contrast ratio (WCAG 2.1).
- Large text (18pt or 14pt bold): at least 3:1.

### Palette Selection
- Define a clear color hierarchy: Primary, Secondary, Accent.
- Follow the 60-30-10 rule: 60% primary/neutral, 30% secondary, 10% accent.
- Complementary colors work well for accents but are poor for text/background pairings.

### Example Palette
| Role | Color |
|------|-------|
| Primary | #0D47A1 (Dark Blue) |
| Secondary | #1976D2 (Medium Blue) |
| Accent | #FFC107 (Amber) |
| Neutral/Text | #212121 (Almost Black) |
| Background | #FEFEFE (Almost White) |

---

## Font Best Practices

### Font Selection
- Stick to one or two font families for the entire application.
- Prioritize legibility — sans-serif fonts are generally preferred for UI body text.
- For open-source fonts, use `google_fonts`.

### Hierarchy and Scale
- Establish a scale of font sizes for different text elements (headlines, titles, body, captions).
- Use font weight to differentiate text.
- Use color and opacity to de-emphasize less important text.

### Readability
- Line height: typically 1.4x to 1.6x the font size.
- Aim for 45–75 characters per line for body text.
- Avoid all caps for long-form text.

### Example Typographic Scale
```dart
textTheme: const TextTheme(
  displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.bold),
  titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(fontSize: 16.0, height: 1.5),
  bodyMedium: TextStyle(fontSize: 14.0, height: 1.4),
  labelSmall: TextStyle(fontSize: 11.0, color: Colors.grey),
),
```

---

## Assets and Images
- Make images relevant and meaningful with appropriate size, layout, and licensing.
- Declare all asset paths in `pubspec.yaml`.
- Use `Image.asset` for local images, `NetworkImage` for network-loaded images, and `cached_network_image` for cached network images.
- Use `ImageIcon` for custom icons not in the `Icons` class.
- When using network images, always include `loadingBuilder` and `errorBuilder`:

```dart
Image.network(
  'https://example.com/image.jpg',
  loadingBuilder: (context, child, progress) {
    if (progress == null) return child;
    return const Center(child: CircularProgressIndicator());
  },
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.error);
  },
)
```

---

## Documentation
- Write `dartdoc`-style comments for all public APIs.
- Use `///` for doc comments. Start with a single-sentence summary ending with a period.
- Explain *why* code is written a certain way, not *what* it does — the code should be self-explanatory.
- Include code samples where appropriate.
- Explain parameters, return values, and exceptions in prose.
- Place doc comments before any metadata annotations.
- Be brief and concise. Use consistent terminology.

---

## Accessibility (A11Y)
- Ensure text has at least a 4.5:1 contrast ratio against its background.
- Test UI remains usable when system font size increases.
- Use the `Semantics` widget to provide clear, descriptive labels.
- Regularly test with TalkBack (Android) and VoiceOver (iOS).
