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

---

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
  ├── common/
  │   ├── api/         # API 客户端、Dio 实例
  │   ├── entity/      # 数据实体（@JsonSerializable）
  │   ├── utils/       # 工具函数、常量、主题
  │   ├── values/      # 颜色、字符串等资源常量
  │   └── widgets/     # 跨页面共享的通用 widget
  └── pages/           # 页面，每个页面一个子文件夹
  ```
- **Private Widgets:** Use small, private `_Widget` classes instead of private helper methods that return a `Widget` within the same file. If a private widget becomes substantial, promote it to its own public widget file.
- **Build Methods:** Break down large `build()` methods into smaller, reusable widget classes (in separate files when appropriate).
- **Design Patterns:** Apply appropriate design patterns throughout the codebase:
  - **Provider + ChangeNotifier:** 状态管理核心模式，`ChangeNotifier` 管理状态，`Provider` 注入和分发。
  - **Repository Pattern:** Abstract data sources behind repository interfaces for testability.
  - **Factory Pattern:** Use factory constructors (especially for `fromJson`) to encapsulate object creation.
  - **Singleton:** Use `Provider`'s single-instance providers for services (e.g., API clients, database helpers).
  - **Observer:** Leverage `ChangeNotifier` + `notifyListeners()` as the built-in observer pattern via Provider.
  - **Strategy:** Encapsulate interchangeable algorithms (e.g., different validation strategies, sorting strategies) behind a common interface.
- **List Performance:** Use `ListView.builder` or `SliverList` for long lists to create lazy-loaded lists for performance.
- **Isolates:** Use `compute()` to run expensive calculations in a separate isolate to avoid blocking the UI thread.
- **Const Constructors:** Use `const` constructors for widgets and in `build()` methods whenever possible to reduce rebuilds.
- **Build Method Performance:** Avoid performing expensive operations like network calls or complex computations directly within `build()` methods.

---

## Application Architecture
- **Separation of Concerns:** 页面与通用组件分离，业务逻辑与 UI 分离。
- **Logical Layers:**
  - **pages:** 页面级 widget，每个页面对应一个子文件夹
  - **common/api:** API 客户端、网络请求层
  - **common/entity:** 数据实体类（`@JsonSerializable`）
  - **common/utils:** 工具函数、主题、路由配置
  - **common/values:** 资源常量（颜色、字符串等）
  - **common/widgets:** 可复用的通用 widget

---

## State Management — Provider (必须使用)

> 参考文档: [Provider 中文 README](https://github.com/rrousselGit/provider/blob/master/resources/translations/zh-CN/README.md)

- **Provider:** 本项目必须使用 `provider` 作为状态管理和依赖注入方案。添加方式：`flutter pub add provider`。

### 核心原则

#### 创建新对象实例 — 始终使用默认构造函数 + `create`
```dart
ChangeNotifierProvider(
  create: (_) => CounterNotifier(),
  child: ...,
)
```
**警告：不要** 使用 `.value` 构造函数创建新对象——可能导致非预期的副作用。`.value` 构造函数**只能用于**复用已存在的对象实例。

#### 复用已有对象 — 使用 `.value` 构造函数
```dart
ChangeNotifierProvider.value(
  value: existingNotifier,
  child: ...,
)
```

#### 延迟创建（Lazy）
`create` 和 `update` 回调默认是**延迟调用**的，只有首次读取时才会执行。如需预热计算，设置 `lazy: false`。

### 读取值

| 方法 | 行为 | 使用场景 |
|------|------|---------|
| `context.watch<T>()` | 监听 `T` 的变化，变化时重建 widget | `build()` 方法内 |
| `context.read<T>()` | 直接返回 `T`，不监听变化 | 事件处理回调（`onPressed` 等），**不可在 `StatelessWidget.build` 或 `State.build` 中使用** |
| `context.select<T, R>(R cb(T))` | 只监听 `T` 的一部分内容，只有该部分变化时才重建 | 避免不必要的重建，性能优化首选 |

```dart
// ❌ 错误 — person 的任何字段变化都会触发重建
final name = context.watch<Person>().name;

// ✅ 正确 — 只有 name 变化时才触发重建
final name = context.select((Person p) => p.name);
```

#### 可空 Provider
当某个 provider 可能不存在时，声明类型为可空来获取 `null` 而不是抛出异常：
```dart
context.watch<MyNotifier?>()  // 未找到时返回 null
```

### MultiProvider
消除深层嵌套，行为等同于逐层嵌套：
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => UserNotifier()),
    ChangeNotifierProvider(create: (_) => SettingsNotifier()),
    Provider<ApiService>(create: (_) => ApiService()),
  ],
  child: const MyApp(),
);
```
**注意：`providers` 数组不能为空。**

### Consumer 和 Selector
当 `BuildContext` 不方便直接访问时（例如需要限制重建范围），使用 `Consumer` 或 `Selector` 将重建限定到特定子树：
```dart
// 只有 Bar 在 A 变化时重建；Foo 和 Baz 不重建
Foo(
  child: Consumer<A>(
    builder: (_, a, child) {
      return Bar(a: a, child: child);
    },
    child: Baz(),
  ),
)
```
`child` 参数在重建时被保留，**避免不必要的重建**——这是 Provider 的核心性能优化手段。

### ProxyProvider
使用 `ProxyProvider`（及变体 `ProxyProvider2`、`ProxyProvider3`）从多个 provider 聚合/派生值，任一依赖更新时自动更新：
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
当派生值本身是 `ChangeNotifier` 时，使用 `ChangeNotifierProxyProvider`。

### FutureProvider 和 StreamProvider
- **FutureProvider:** 将 `Future` 结果暴露给 widget 树。**必须**提供 `initialData`：
  ```dart
  FutureProvider<User>(
    create: (_) => apiService.fetchUser(),
    initialData: User.empty(),
    child: ...,
  );
  ```
- **StreamProvider:** 监听 `Stream` 并暴露最新值。**必须**提供 `initialData`：
  ```dart
  StreamProvider<int>(
    create: (_) => counterStream,
    initialData: 0,
    child: ...,
  );
  ```

### 在状态类中触发副作用（API 调用）
在 `build()` 期间修改状态是被禁止的。应在 `initState` 中使用 `Future.microtask` 延迟执行：
```dart
@override
void initState() {
  super.initState();
  Future.microtask(() =>
    context.read<UserNotifier>().fetchUserData(someValue);
  );
}
```

### 类型唯一性
**不能有两个同类型的 provider** —— widget 只会获取最近的。用不同的类型包装：
```dart
// ❌ 错误 — 相同类型，London 会覆盖 England
Provider<String>(create: (_) => 'England')
Provider<String>(create: (_) => 'London')

// ✅ 正确 — 不同类型
Provider<Country>(create: (_) => Country('England'))
Provider<City>(create: (_) => City('London'))
```

### 接口/实现分离
通过泛型类型提示消费接口、提供具体实现：
```dart
ChangeNotifierProvider<RepositoryInterface>(
  create: (_) => RepositoryImplementation(),
  child: Foo(),
)
```

### 热重载支持
在 `ChangeNotifier` 上实现 `ReassembleHandler` 以兼容热重载：
```dart
class MyNotifier extends ChangeNotifier implements ReassembleHandler {
  @override
  void reassemble() {}
}
```

### Provider 类型速查

| Provider | 用途 |
|---|---|
| `Provider` | 暴露任意不可变值或服务 |
| `ChangeNotifierProvider` | 暴露 `ChangeNotifier`（自动调用 `dispose`） |
| `FutureProvider` | 暴露 `Future` 结果（需要 `initialData`） |
| `StreamProvider` | 暴露 `Stream` 的最新值（需要 `initialData`） |
| `ProxyProvider` | 从其他 provider 派生值 |
| `ChangeNotifierProxyProvider` | 从其他 provider 派生 `ChangeNotifier` |
| `ListenableProvider` | 暴露任意 `Listenable` 对象 |

### 临时状态 vs 应用状态
- **临时状态（Ephemeral state）：** 局部 UI 状态 → 使用 `StatefulWidget` 的 `setState`。
- **应用状态（App state）：** 跨组件共享的状态 → 使用 Provider + `ChangeNotifier`。

---

## 网络请求 — Dio（必须使用）

> 参考文档: [Dio 中文 README](https://github.com/cfug/dio/blob/main/dio/README-ZH.md)

- **Dio:** 本项目必须使用 `dio` 作为 HTTP 客户端。添加方式：`flutter pub add dio`。

### 核心概念

Dio 实例支持统一配置（`BaseOptions`），可同时发起多个请求，每个请求可独立配置（`Options`）。所有请求都通过 `Future<Response<T>> request<T>(...)` 流转，便捷方法（`get`、`post` 等）是其封装。

### 实例创建与配置

创建**单例** `Dio` 实例，集中配置 baseUrl、超时、公共 headers：

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
    // Auth token 注入（QueuedInterceptor 确保并发请求串行刷新 token）
    dio.interceptors.add(QueuedInterceptorsWrapper(
      onRequest: (options, handler) {
        final token = AuthStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) async {
        // 401 时自动刷新 token 并重试
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

    // Log 拦截器 — 必须放在最后，否则后续拦截器的修改不会出现在日志中
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (o) => developer.log(o.toString(), name: 'dio'),
    ));
  }
}
```

- **克隆变体：** 需要少量配置差异时，使用 `dio.clone()` 而不是新建实例。

### 拦截器（Interceptor）

拦截器以 FIFO 顺序执行。每个拦截器可以通过 `handler` 控制流转：
- `handler.next(data)` — 传给下一个拦截器
- `handler.resolve(response)` — 短路返回自定义数据（触发 `.then`）
- `handler.reject(error)` — 中断请求并抛出错误（触发 `.catchError`）

**并行 vs 串行：**
- 标准 `Interceptor`：允许并发进入，适合日志、header 注入
- `QueuedInterceptor`：串行化进入，**当多个并发请求同时进入拦截器且需要共享状态时使用**（如 token 刷新——确保只发起一次刷新请求）

**关键规则：`LogInterceptor` 必须作为最后一个拦截器添加。**

### 请求方法

- **GET（带查询参数）：**
  ```dart
  final response = await dio.get(
    '/users',
    queryParameters: {'page': 1, 'limit': 20},
  );
  ```

- **POST：**
  ```dart
  final response = await dio.post(
    '/users',
    data: {'name': 'John', 'email': 'john@example.com'},
  );
  ```

- **PUT / PATCH / DELETE：** 使用通用 `request()` 方法：
  ```dart
  await dio.request(
    '/users/1',
    data: {'name': 'Updated'},
    options: Options(method: 'PUT'),
  );
  ```

### 错误处理

所有错误统一包装为 `DioException`，关键字段：
- `type` — `DioExceptionType` 枚举（connectionTimeout、sendTimeout、receiveTimeout、connectionError、badResponse、cancel 等）
- `response` — 服务器返回了非 2xx/304 响应时非空
- `requestOptions` — 始终可用，用于诊断
- `error` — 底层原始错误对象
- `stackTrace` — 保留的错误堆栈

```dart
try {
  final response = await dio.get('/users');
  return UserList.fromJson(response.data);
} on DioException catch (e) {
  if (e.response != null) {
    // 服务器返回了错误响应
    final statusCode = e.response?.statusCode;
    final errorData = e.response?.data;
    throw ServerException(
      message: errorData?['message'] ?? 'Server error',
      statusCode: statusCode,
    );
  } else {
    // 网络错误（超时、无网络等）
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

### FormData 与文件上传

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

**重要：切勿在请求之间复用 `FormData` 或 `MultipartFile` 实例——必须每次创建新实例。**

### 文件下载

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

### 请求取消

使用 `CancelToken` 取消进行中的请求，防止内存泄漏：
```dart
final cancelToken = CancelToken();
dio.get('/users', cancelToken: cancelToken).catchError((error) {
  if (CancelToken.isCancel(error)) {
    print('Request canceled: ${error.message}');
  }
});

@override
void dispose() {
  cancelToken.cancel('Widget disposed');
  super.dispose();
}
```
一个 `CancelToken` 可以跨多个请求共享，一次性取消所有关联请求。

### 架构集成

- **Repository 模式：** 将 Dio 调用封装在 Repository 类中。状态管理类调用 Repository，**绝不直接调用 Dio**。
- **Provider 集成：** 通过 `Provider` 将服务作为单例暴露：
  ```dart
  MultiProvider(
    providers: [
      Provider<ApiClient>(create: (_) => ApiClient()),
      Provider<UserRepository>(create: (_) => UserRepository(_.read<ApiClient>())),
    ],
    child: const MyApp(),
  );
  ```
- **状态管理类使用：**
  ```dart
  class UserNotifier extends ChangeNotifier {
    final UserRepository _repository;
    UserNotifier(this._repository);

    Future<void> loadUsers() async {
      try {
        final users = await _repository.getUsers();
        notifyListeners();
      } on ServerException catch (e) {
        // 处理特定错误
      }
    }
  }
  ```

---

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

## Design Patterns（设计模式 — 必须遵循）

本项目遵循以下设计模式，按现有目录结构组织：

### Provider + ChangeNotifier（状态管理核心）

```
Page Widget → ChangeNotifier (状态) → Repository → ApiClient (Dio)
      ↑ context.watch / context.read
```

- **Entity**（`common/entity/`）：数据实体，`@JsonSerializable` 注解，纯数据结构。
- **ChangeNotifier**（`common/utils/` 或页面文件夹内）：管理业务状态，通过 Provider 暴露。
- **Page Widget**（`pages/`）：消费状态、渲染 UI，不直接访问 API 或数据库。
- **API Client**（`common/api/`）：Dio 实例 + 拦截器配置。

### Repository 模式
```
ChangeNotifier → Repository → DataSource (API / DB)
```
- Repository 是数据源的抽象层，让状态管理类不需要知道数据从哪里来。
- Repository 放在 `common/api/` 或页面文件夹内。
- 便于单元测试时注入 fake/stub 替代真实数据源。

### 其他必备模式

| 模式 | 应用场景 |
|------|---------|
| **Singleton** | `ApiClient`（Dio 实例）— 通过 Provider 单例暴露 |
| **Factory** | 数据实体的 `factory X.fromJson(...)` 构造函数 |
| **Observer** | `ChangeNotifier` + `notifyListeners()` — Provider 内置的观察者模式 |
| **Strategy** | 可互换的算法（验证策略、排序策略）— 定义接口，注入不同实现 |

---

## Widget 封装规则（必须遵循）

### 必须封装为独立 Widget 的场景

以下任一条件满足，该 widget **必须**封装为独立类（文件）：
1. **跨页面复用：** 同一个 widget 在 ≥2 个地方使用
2. **自包含状态：** widget 拥有自己独立的状态管理逻辑
3. **单一职责：** widget 有明确定义的单一功能（如头像卡片、评分组件）
4. **语义独立：** widget 对应一个明确的概念/实体（如 `UserCard`、`CommentBubble`）
5. **父文件过长：** 父文件因 widget 内联导致超过 200 行

### 封装方式

- **优先 `StatelessWidget`：** 无内部状态时使用
- **有内部状态时：** 使用 `StatefulWidget` 或 Provider 消费 `ChangeNotifier`
- **小粒度私有 widget：** 创建 `_PrivateWidget` 类而不是 `Widget _buildXxx()` 私有方法
- **文件命名：** `snake_case`，与类名一致（`UserCard` → `user_card.dart`）

### 目录策略

```
lib/
├── common/widgets/    # 跨页面共享的通用 widget
│   ├── buttons/
│   ├── cards/
│   └── dialogs/
└── pages/             # 页面，每个页面对应一个子文件夹
    └── home/
        └── widgets/   # 仅该页面使用的私有 widget
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
