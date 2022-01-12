class ValidatorMixin{



  String? validateText(String? textField,bool required, {bool email = false, int minLenght = 0, int maxLength = 0, bool phone = false,bool isInt = false}){
    String? msg;
    if(textField != null){

       if(email){
         msg =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(textField.trim()) ? msg : 'Почта не валидна';
       }
       if(minLenght > 0){
         msg = textField.trim().length < minLenght ? "Поле не может быть менее ${minLenght} символов" : msg;
       }
       if(maxLength > 0){
         msg = textField.trim().length > maxLength ? "Поле не может быть более ${minLenght} символов" : msg;
       }
       if(isInt){
         msg = int.tryParse(textField) == null ? 'Введите число' : msg;
       }
       if(required){
         msg = textField.trim().isEmpty ? "Обязательно для заполнения" : msg;
       }

       return msg;
    }






  }




}