import 'package:findout/app/routes/middlewares/initial_middleware.dart';
import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../modules/admin/categories/bindings/categories_binding.dart';
import '../modules/admin/categories/views/categories_view.dart';
import '../modules/admin/dashboard/bindings/dashboard_binding.dart';
import '../modules/admin/dashboard/views/dashboard_view.dart';
import '../modules/admin/posts/bindings/posts_binding.dart';
import '../modules/admin/posts/views/posts_view.dart';
import '../modules/admin/posts_single/bindings/posts_single_binding.dart';
import '../modules/admin/posts_single/controllers/posts_single_controller.dart';
import '../modules/admin/posts_single/views/posts_single_view.dart';
import '../modules/admin/users/bindings/users_binding.dart';
import '../modules/admin/users/views/users_view.dart';
import '../modules/change_profile/bindings/change_profile_binding.dart';
import '../modules/change_profile/views/change_profile_view.dart';
import '../modules/chat_page/bindings/chat_page_binding.dart';
import '../modules/chat_page/views/chat_page_view.dart';
import '../modules/chatroom_view/bindings/chatroom_view_binding.dart';
import '../modules/chatroom_view/views/chatroom_view_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/initial/bindings/initial_binding.dart';
import '../modules/initial/views/initial_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/post_create/bindings/post_create_binding.dart';
import '../modules/post_create/views/post_create_view.dart';
import '../modules/post_edit/bindings/post_edit_binding.dart';
import '../modules/post_edit/views/post_edit_view.dart';
import '../modules/post_view/bindings/post_view_binding.dart';
import '../modules/post_view/views/post_view_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import 'middlewares/admin_middleware.dart';
import 'middlewares/auth_middleware.dart';
import 'middlewares/guest_middleware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIALPAGE;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        middlewares: [AuthMiddleware()]),
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
        binding: DashboardBinding(),
        middlewares: [AdminMiddleware()]),
    GetPage(
        name: _Paths.CATEGORIES,
        page: () => CategoriesView(),
        binding: CategoriesBinding(),
        middlewares: [AdminMiddleware()]),
    GetPage(
      name: _Paths.POST_CREATE,
      page: () => PostCreateView(),
      binding: PostCreateBinding(),
    ),
    GetPage(
        name: _Paths.POSTS,
        page: () => PostsView(),
        binding: PostsBinding(),
        middlewares: [AdminMiddleware()]),
    GetPage(
      name: _Paths.POST_EDIT,
      page: () => PostEditView(),
      binding: PostEditBinding(),
    ),
    GetPage(
      name: _Paths.POST_VIEW,
      page: () => PostViewView(),
      binding: PostViewBinding(),
    ),
    GetPage(
        name: _Paths.USERS,
        page: () => UsersView(),
        binding: UsersBinding(),
        middlewares: [AdminMiddleware()]),
    GetPage(
      name: _Paths.INITIALPAGE,
      page: () => InitialView(),
      binding: InitialBinding(),
      middlewares: [InitialMiddleware()],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PROFILE,
      page: () => ChangeProfileView(),
      binding: ChangeProfileBinding(),
    ),
    GetPage(
      name: _Paths.POSTS_SINGLE,
      page: () => PostsSingleView(),
      binding: PostsSingleBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_PAGE,
      page: () => ChatPageView(),
      binding: ChatPageBinding(),
    ),
    GetPage(
      name: _Paths.CHATROOM_VIEW,
      page: () => ChatroomViewView(),
      binding: ChatroomViewBinding(),
    ),
  ];
}
