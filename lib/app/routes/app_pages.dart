import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../modules/admin/categories/bindings/categories_binding.dart';
import '../modules/admin/categories/views/categories_view.dart';
import '../modules/admin/dashboard/bindings/dashboard_binding.dart';
import '../modules/admin/dashboard/views/dashboard_view.dart';
import '../modules/admin/posts/bindings/posts_binding.dart';
import '../modules/admin/posts/views/posts_view.dart';
import '../modules/admin/users/bindings/users_binding.dart';
import '../modules/admin/users/views/users_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/post_create/bindings/post_create_binding.dart';
import '../modules/post_create/views/post_create_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import 'middlewares/admin_middleware.dart';
import 'middlewares/auth_middleware.dart';
import 'middlewares/guest_middleware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        middlewares: [AuthMiddleware(), AdminMiddleware()]),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding(),
        middlewares: [GuestMiddleware()]),
    GetPage(
        name: _Paths.REGISTER,
        page: () => RegisterView(),
        binding: RegisterBinding(),
        middlewares: [GuestMiddleware()]),
    GetPage(
        name: _Paths.DASHBOARD,
        page: () => DashboardView(),
        binding: DashboardBinding()),
    GetPage(
      name: _Paths.CATEGORIES,
      page: () => CategoriesView(),
      binding: CategoriesBinding(),
    ),
    GetPage(
      name: _Paths.POST_CREATE,
      page: () => PostCreateView(),
      binding: PostCreateBinding(),
    ),
    GetPage(
      name: _Paths.POSTS,
      page: () => PostsView(),
      binding: PostsBinding(),
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => UsersView(),
      binding: UsersBinding(),
    ),
  ];
}
