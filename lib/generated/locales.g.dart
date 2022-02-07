// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

// ignore_for_file: lines_longer_than_80_chars
// ignore: avoid_classes_with_only_static_members
import 'package:get/get.dart';

class AppTranslation extends Translations {
  static Map<String, Map<String, String>> translations = {
    'ru': Locales.ru,
    'en': Locales.en,
  };

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => translations;
}

class LocaleKeys {
  LocaleKeys._();
  static const registration = 'registration';
  static const name = 'name';
  static const surname = 'surname';
  static const birthday = 'birthday';
  static const email = 'email';
  static const password = 'password';
  static const city = 'city';
  static const register = 'register';
  static const login = 'login';
  static const welcome = 'welcome';
  static const forget = 'forget';
  static const search_post = 'search_post';
  static const title = 'title';
  static const main = 'main';
  static const hello = 'hello';
  static const all = 'all';
  static const upload_image = 'upload_image';
  static const take_photo = 'take_photo';
  static const upload_gallery = 'upload_gallery';
  static const cancel = 'cancel';
  static const categories = 'categories';
  static const select_category = 'select_category';
  static const description = 'description';
  static const action_location = 'action_location';
  static const select_city = 'select_city';
  static const location = 'location';
  static const date = 'date';
  static const persons = 'persons';
  static const save = 'save';
  static const oops = 'oops';
  static const fill_fields = 'fill_fields';
  static const update = 'update';
  static const sure_to_delete = 'sure_to_delete';
  static const enter_to_delete = 'enter_to_delete';
  static const delete = 'delete';
  static const setting = 'setting';
  static const change_profile = 'change_profile';
  static const liked_posts = 'liked_posts';
  static const blacklists = 'blacklists';
  static const logout = 'logout';
  static const delete_account = 'delete_account';
  static const deleting_account = 'deleting_account';
  static const something_went_wrong = 'something_went_wrong';
  static const success = 'success';
  static const post_updated = 'post_updated';
  static const post_not_fount = 'post_not_fount';
  static const post_deleted = 'post_deleted';
  static const account_deleted = 'account_deleted';
  static const return_back = 'return_back';
  static const account_doesnt_exist = 'account_doesnt_exist';
  static const incorrect_password = 'incorrect_password';
  static const weak_password = 'weak_password';
  static const email_in_used = 'email_in_used';
  static const image_is_ready = 'image_is_ready';
  static const image_is_uploaded = 'image_is_uploaded';
  static const incorrect_image = 'incorrect_image';
  static const deleted_account = 'deleted_account';
  static const you_are_in_banlist = 'you_are_in_banlist';
  static const  post_created = "post_created";
  static const messenger = "messenger";
  static const ban_user = "ban_user";
  static const  delete_chat = "delete_chat";
  static const search = "search";
  static const validate_email = "validate_email";
  static const validate_phone = "validate_phone";
  static const cant_less = "cant_less";
  static const cant_more = "cant_more";
  static const symbols = "symbols";
  static const choose_int = "choose_int";
  static const number_more = "number_more";
  static const number_less = "number_less";
  static const required = "required";
  static const choose_time = "choose_time";
  static const write = "write";
  static const start_time = "start_time";
  static const end_time = "end_time";

}

class Locales {
  static const ru = {
    'registration': 'Регистрация',
    'name': 'Имя',
    'surname': 'Фамилия',
    'birthday': 'Дата рождения (+18 лет)',
    'email': 'Email',
    'password': 'Пароль',
    'city': 'Ваш город',
    'register': 'Зарегистрироваться',
    'login': 'Вход',
    'welcome': 'Добро пожаловать!',
    'forget': 'Забыли пароль',
    'search_post': 'Поиск по постам',
    'title': 'Наименование',
    'main': 'Главная',
    'hello': 'Привет',
    'all': 'Все',
    'upload_image': 'Загрузить изображение',
    'take_photo': 'Сделать фото',
    'upload_gallery': 'Загрузить с галереи',
    'cancel': 'Отмена',
    'categories': 'Категории',
    'select_category': 'Выберите категорию',
    'description': 'Описание',
    'action_location': 'Место действия',
    'select_city': 'Выберите город/область',
    'location': 'Локация',
    'date': 'Дата события',
    'persons': 'Кол-во свободных мест',
    'save': 'Сохранить',
    'oops': 'Упс',
    'fill_fields': 'Заполните все поля',
    'update': 'Изменить',
    'sure_to_delete': 'Аккаунт и все связанные данные будут навсегда потеряны? Вы уверены',
    'enter_to_delete': 'Введите 0000 если уверены в удалении аккаунта',
    'delete': 'Удалить',
    'setting': 'Настройки',
    'change_profile': 'Изменить данные',
    'liked_posts': 'Понравившиеся посты',
    'blacklists': 'Черный список',
    'logout': 'Выйти',
    'delete_account': 'Удалить аккаунт',
    'deleting_account': 'Удаление аккаунта',
    'something_went_wrong': 'Что-то пошло не так',
    'success': 'Успешно',
    'post_updated': 'Пост успешно обновлен',
    'post_not_fount': 'Поста не существует',
    'post_deleted': 'Пост успешно удален',
    'account_deleted': 'Аккаунт успешно удален',
    'return_back': 'С возвращением',
    'account_doesnt_exist': 'Такого пользователя не существует',
    'incorrect_password': 'Неверный пароль',
    'weak_password': 'Пароль слишком слаб',
    'email_in_used': 'Такой email уже используется',
    'image_is_ready': 'Фото готово',
    'image_is_uploaded': 'Фото загружено',
    'incorrect_image': 'Фото не соответсвует правилам приложения!',
    'deleted_account': 'Удаленный пользователь',
    'you_are_in_banlist': 'Пользователь ограничил доступ к переписке',
    "post_created":"Пост успешно создан",
    "messenger":"Мессенджер",
    "ban_user":"Черный список",
    "delete_chat":"Удалить переписку",
    "search":"Поиск",
    "validate_email":"Невалидная почта",
    "validate_phone":"Невалидный телефон",
    "cant_less":"Поле не может быть меньше ",
    "cant_more":"Поле не может быть более ",
    "symbols":"Символов",
    "choose_int":"Введите число",
    "number_more":"Число не может быть более",
    "number_less":"Число не может быть меньше",
    "required":"Поле обязательно для заполнения",
    "choose_time":"Выберите время",
    "write":"Написать",
    "start_time":"Дата начала",
    "end_time":"Дата окончания"
  };
  static const en = {
    'registration': 'Registration',
    'name': 'Name',
    'surname': 'surname',
    'birthday': 'Date of birth (+18 years)',
    'email': 'Email',
    'password': 'Password',
    'city': 'Your city',
    'register': 'Register',
    'login': 'Login',
    'welcome': 'Welcome!',
    'forget': 'Forgot password',
    'search_post': 'Search by posts',
    'title': 'title',
    'main': 'Main',
    'hello': 'hello',
    'all': 'All',
    'upload_image': 'Upload image',
    'take_photo': 'Take a photo',
    'upload_gallery': 'Upload from gallery',
    'cancel': 'Cancel',
    'categories': 'Categories',
    'select_category': 'Select a category',
    'description': 'Description',
    'action_location': 'Action Location',
    'select_city': 'Select City/Province',
    'location': 'Location',
    'date': 'Event date',
    'persons': 'Number of available seats',
    'save': 'Save',
    'oops': 'oops',
    'fill_fields': 'Fill in all fields',
    'update': 'Change',
    'sure_to_delete': 'Account and all associated data will be permanently lost? Are you sure',
    'enter_to_delete': 'Enter 0000 if you are sure to delete the account',
    'delete': 'Delete',
    'setting': 'Settings',
    'change_profile': 'Change data',
    'liked_posts': 'Posts Liked',
    'blacklists': 'Blacklist',
    'logout': 'Logout',
    'delete_account': 'Delete account',
    'deleting_account': 'Deleting an account',
    'something_went_wrong': 'Something went wrong',
    'success': 'Success',
    'post_updated': 'Post updated successfully',
    'post_not_fount': 'Post does not exist',
    'post_deleted': 'Post deleted successfully',
    'account_deleted': 'Account deleted successfully',
    'return_back': 'Welcome back',
    'account_doesnt_exist': 'This user does not exist',
    'incorrect_password': 'Incorrect password',
    'weak_password': 'Password is too weak',
    'email_in_used': 'This email is already in use',
    'image_is_ready': 'Photo is ready',
    'image_is_uploaded': 'Photo uploaded',
    'incorrect_image': 'Photo doesnt follow app rules!',
    'deleted_account': 'Deleted User',
    'you_are_in_banlist': 'You have been blacklisted',
  "post_created":"Post successfully created",
  "messenger": "Messenger",
  "ban_user":"blacklist",
  "delete_chat":"Delete conversation",
  "search":"Search",
  "validate_email":"Invalid email",
  "validate_phone":"Invalid phone",
  "cat_less":"Field can not be less than ",
  "cant_more":"Field can't be more than ",
  "symbols":"Symbols",
  "choose_int":"Enter a number",
  "number_more":"the Number cannot be more than ",
  "number_less":"the Number cannot be less than",
  "required":"required Field",
  "choose_time":"Select time",
    "write":"Message",
    "start_time":"Start date",
    "end_time":"End date"
  };
}
