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
  static const privacy_term = "privacy_term";

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
    'forget': 'Забыли пароль?',
    'reset': 'Восстановление пароля',
    'reset_btn': 'Восстановить',
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
    "end_time":"Дата окончания",
    "choose_action":"Выберите действие",
    "verify_email":"Подтвердите почту",
    "home":"Вернуться домой",
    "dashboard":"Панель управления",
    "check_connection":"Проверьте интернет соединение",
    "connection_restored":"Соединение восстановлено",
    "privacy_term":"Политика конфидециальности и условия использования",
    "i_accept_pt":"Я согласен с Политикой Конфидециальности и Условиями пользования",
    "term_of_use":"Условия пользования",
    "term_of_use_text":"При загрузке или использовании приложения эти условия автоматически применяются к вам, поэтому вы должны убедиться, что вы внимательно их прочитали, прежде чем использовать приложение. Вам не разрешается каким-либо образом копировать или изменять приложение, любую его часть или наши товарные знаки. Вам не разрешается пытаться извлечь исходный код приложения, а также вам не следует пытаться переводить приложение на другие языки или создавать производные версии. Само приложение и все связанные с ним товарные знаки, авторские права, права на базы данных и другие права на интеллектуальную собственность по-прежнему принадлежат Автору приложения.Автор приложения стремится сделать приложение максимально полезным и эффективным. По этой причине мы оставляем за собой право вносить изменения в приложение или взимать плату за его услуги в любое время и по любой причине. Мы никогда не будем взимать плату за приложение или его услуги, не разъяснив вам, за что именно вы платите.Приложение Hangout хранит и обрабатывает персональные данные, которые вы нам предоставили, для предоставления моего Сервиса. Вы несете ответственность за безопасность своего телефона и доступа к приложению. Поэтому мы рекомендуем вам не делать джейлбрейк или рутировать свой телефон, что представляет собой процесс снятия программных ограничений и ограничений, налагаемых официальной операционной системой вашего устройства. Это может сделать ваш телефон уязвимым для вредоносных программ/вирусов/вредоносных программ, поставить под угрозу функции безопасности вашего телефона, а также может привести к тому, что приложение Hangout не будет работать должным образом или вообще не будет работать.Приложение использует сторонние сервисы, которые объявляют свои Условия использования.Ссылка на Условия и положения сторонних поставщиков услуг, используемых приложением• Сервисы Google PlayВы должны знать, что есть определенные вещи, за которые Автор приложения не возьмет на себя ответственность. Некоторые функции приложения потребуют, чтобы приложение имело активное подключение к Интернету. Соединение может быть Wi-Fi или предоставлено вашим оператором мобильной связи, но Автор приложения не может нести ответственность за то, что приложение не работает в полную силу, если у вас нет доступа к Wi-Fi, и у вас нет ваших данных. надбавка осталась.Если вы используете приложение за пределами зоны с Wi-Fi, вы должны помнить, что условия соглашения с вашим оператором мобильной связи продолжают действовать. В результате ваш оператор мобильной связи может взимать с вас плату за передачу данных на время соединения при доступе к приложению или другие сторонние сборы. При использовании приложения вы принимаете на себя ответственность за любые такие расходы, включая плату за передачу данных в роуминге, если вы используете приложение за пределами своей домашней территории (т. е. региона или страны) без отключения передачи данных в роуминге. Если вы не являетесь плательщиком счетов за устройство, на котором используете приложение, имейте в виду, что мы предполагаем, что вы получили разрешение от плательщика счетов на использование приложения.В том же духе Автор приложения не всегда может взять на себя ответственность за то, как вы используете приложение, т. е. вам необходимо следить за тем, чтобы ваше устройство оставалось заряженным — если в нем разрядился аккумулятор и вы не можете включить его, чтобы воспользоваться Сервисом, Автор приложения не может принять на себя ответственность.Что касается ответственности автора приложения за использование вами приложения, когда вы используете приложение, важно помнить, что, хотя мы стремимся обеспечить его постоянное обновление и правильность, мы полагаемся на третьи стороны в предоставлении информацию нам, чтобы мы могли сделать ее доступной для вас. Автор приложения не несет ответственности за любые убытки, прямые или косвенные, которые вы понесете в результате того, что полностью полагаетесь на эту функциональность приложения.В какой-то момент мы можем захотеть обновить приложение. Приложение в настоящее время доступно для Android и iOS — требования для обеих систем (и для любых дополнительных систем, на которые мы решили расширить доступность приложения) могут измениться, и вам нужно будет загрузить обновления, если вы хотите сохранить с помощью приложения. Автор приложения не обещает, что всегда будет обновлять приложение, чтобы оно было актуальным для вас и/или работало с той версией Android и iOS, которая установлена на вашем устройстве. Тем не менее, вы обещаете всегда принимать обновления приложения, когда они вам предлагаются. Мы также можем прекратить предоставление приложения и прекратить его использование в любое время, не уведомляя вас о прекращении. Если мы не уведомим вас об ином, при прекращении действия (а) права и лицензии, предоставленные вам в соответствии с настоящими условиями, прекратят свое действие; (b) вы должны прекратить использование приложения и (при необходимости) удалить его со своего устройства.",
    "privacy_policy":"Политика конфидециальности",
    "privacy_policy_text":"Владелец приложения создал приложение Hangout как бесплатное приложение. Эта УСЛУГА предоставляется владельцем приложения бесплатно и предназначена для использования в исходном виде.Эта страница используется для информирования посетителей о моих правилах сбора, использования и раскрытия Личной информации, если кто-то решил воспользоваться моим Сервисом.Если вы решите использовать мой Сервис, вы соглашаетесь на сбор и использование информации в связи с этой политикой. Личная информация, которую я собираю, используется для предоставления и улучшения Сервиса. Я не буду использовать или делиться вашей информацией с кем-либо, кроме случаев, описанных в настоящей Политике конфиденциальности.Термины, используемые в настоящей Политике конфиденциальности, имеют те же значения, что и в наших Условиях и положениях, которые доступны в Hangout, если иное не определено в настоящей Политике конфиденциальности.Сбор и использование информацииДля лучшего опыта использования нашего Сервиса я могу потребовать от вас предоставить нам определенную личную информацию, включая, помимо прочего, имя, фамилию, адрес электронной почты, город. Информация, которую я запрашиваю, будет сохранена на вашем устройстве и никоим образом не будет собираться мной.Приложение использует сторонние сервисы, которые могут собирать информацию, используемую для вашей идентификации.Ссылка на политику конфиденциальности сторонних поставщиков услуг, используемых приложением• Сервисы Google PlayДанные журнала.Я хочу сообщить вам, что всякий раз, когда вы используете мой Сервис, в случае ошибки в приложении я собираю данные и информацию (через сторонние продукты) на вашем телефоне под названием «Данные журнала». Эти данные журнала могут включать в себя такую ​​информацию, как адрес интернет-протокола («IP») вашего устройства, имя устройства, версия операционной системы, конфигурация приложения при использовании моего Сервиса, время и дата использования вами Сервиса и другие статистические данные. .ПеченьеФайлы cookie — это файлы с небольшим объемом данных, которые обычно используются в качестве анонимных уникальных идентификаторов. Они отправляются в ваш браузер с веб-сайтов, которые вы посещаете, и сохраняются во внутренней памяти вашего устройства.Эта Служба не использует эти «куки» в явном виде. Однако приложение может использовать сторонний код и библиотеки, которые используют файлы cookie для сбора информации и улучшения своих услуг. У вас есть возможность либо принять, либо отказаться от этих файлов cookie и узнать, когда файл cookie отправляется на ваше устройство. Если вы решите отказаться от наших файлов cookie, вы не сможете использовать некоторые части этой Услуги.Поставщики услуг.Я могу нанимать сторонние компании и частных лиц по следующим причинам:• Для облегчения нашего Сервиса;• Для предоставления Услуги от нашего имени;• Для выполнения Сервисных услуг; или• Чтобы помочь нам проанализировать, как используется наш Сервис.Я хочу сообщить пользователям этого Сервиса, что эти третьи лица имеют доступ к их Личной информации. Причина в том, чтобы выполнять возложенные на них задачи от нашего имени. Однако они обязаны не разглашать и не использовать информацию для каких-либо других целей.Безопасность:Я ценю ваше доверие в предоставлении нам вашей личной информации, поэтому мы стремимся использовать коммерчески приемлемые средства ее защиты. Но помните, что ни один метод передачи через Интернет или метод электронного хранения не является на 100% безопасным и надежным, и я не могу гарантировать его абсолютную безопасность.Ссылки на другие сайтыЭта Служба может содержать ссылки на другие сайты. Если вы нажмете на стороннюю ссылку, вы будете перенаправлены на этот сайт. Обратите внимание, что эти внешние сайты не управляются мной. Поэтому я настоятельно рекомендую вам ознакомиться с Политикой конфиденциальности этих веб-сайтов. Я не контролирую и не несу ответственности за содержание, политику конфиденциальности или действия любых сторонних сайтов или служб.Конфиденциальность детей.Эти Услуги не предназначены для лиц моложе 18 лет. Я намеренно не собираю личную информацию от детей младше 13 лет. Если я узнаю, что ребенок младше 13 лет предоставил мне личную информацию, я немедленно удаляю ее с наших серверов. Если вы являетесь родителем или опекуном и знаете, что ваш ребенок предоставил нам личную информацию, свяжитесь со мной, чтобы я мог предпринять необходимые действия.Изменения в настоящей Политике конфиденциальностиЯ могу время от времени обновлять нашу Политику конфиденциальности. Таким образом, вам рекомендуется периодически просматривать эту страницу на предмет любых изменений. Я сообщу вам о любых изменениях, опубликовав новую Политику конфиденциальности на этой странице.Эта политика действует с 01.04.2022.Связаться с нами:Если у вас есть какие-либо вопросы или предложения относительно моей Политики конфиденциальности, не стесняйтесь обращаться ко мне по адресу hangout2077@gmail.com.",
    "privacy_agree":"Вы должны согласиться с условиями пользования и политикой конфидециальности"
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
    'reset': 'Recover password',
    'reset_btn': 'Recovery',
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
    "end_time":"End date",
    "choose_action":"Choose Action",
    "verify_email":"Verify your email",
    "home":"Return back",
    "dashboard":"My Dashboard",
    "check_connection":"Check connection",
    "connection_restored":"Connection Restored",
    "privacy_term":"Privacy policy and Terms of use",
    "i_accept_pt":"I agree with the Privacy Policy and Term Of Use",
    "term_of_use":"Term Of Use",
    "term_of_use_text":"By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. You’re not allowed to copy or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages or make derivative versions. The app itself, and all the trademarks, copyright, database rights, and other intellectual property rights related to it, still belong to App owner.App owner is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.The Hangout app stores and processes personal data that you have provided to us, to provide my Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Hangout app won’t work properly or at all.The app does use third-party services that declare their Terms and Conditions.Link to Terms and Conditions of third-party service providers used by the app•	Google Play ServicesYou should be aware that there are certain things that App owner will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but App owner cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left.If you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.Along the same lines, App owner cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, App owner cannot accept responsibility.With respect to App owner’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. App owner accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.At some point, we may wish to update the app. The app is currently available on Android & iOS – the requirements for the both systems(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. App owner does not promise that it will always update the app so that it is relevant to you and/or works with the Android & iOS version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.",
    "privacy_policy":"Privacy Policy",
    "privacy_policy_text":"Privacy Policy.App owner built the Hangout app as a Free app. This SERVICE is provided by App owner at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Hangout unless otherwise defined in this Privacy Policy.Information Collection and Use.For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Name, Surname, Email, City. The information that I request will be retained on your device and is not collected by me in any way.The app does use third-party services that may collect information used to identify you.Link to the privacy policy of third-party service providers used by the app.•	Google Play Services.Log Data.I want to inform you that whenever you use my Service, in a case of an error in the app I collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.Cookies.Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.This Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.Service Providers.I may employ third-party companies and individuals due to the following reasons:•	To facilitate our Service;•	To provide the Service on our behalf;•	To perform Service-related services; or•	To assist us in analyzing how our Service is used.I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.Security.I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.Links to Other Sites.This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.Children’s Privacy.These Services do not address anyone under the age of 18. I do not knowingly collect personally identifiable information from children under 13 years of age. In the case I discover that a child under 13 has provided me with personal information, I immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact me so that I will be able to do the necessary actions.Changes to This Privacy Policy. I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.This policy is effective as of 2022-04-01. Contact Us. If you have any questions or suggestions about my Privacy Policy, do not hesitate to contact me at hangout2077@gmail.com.",
    "privacy_agree":"You must agree to the terms of use and privacy policy"

  };
}
