class ValidatorMixin{



  String? validateText(String? textField,bool required, {bool email = false, int minLenght = 0, int maxLength = 0, bool phone = false,bool isInt = false, int? minInt = null, int? maxInt = null }){
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
         if(int.tryParse(textField) != null){
           msg = msg;
           if(minInt != null){
             msg = (int.tryParse(textField)??-1) < minInt ? "Укажите число более ${minInt}"   : msg;
           }
           if(maxInt != null){
             msg = (int.tryParse(textField)??-1) > maxInt ? "Укажите менее  ${maxInt}"   : msg;
           }
         }
         else{
           msg =  'Введите число';
         }
       }
       if(required){
         msg = textField.trim().isEmpty ? "Обязательно для заполнения" : msg;
       }
       return msg;
    }
    }

  String? validateDate(DateTime? dateTime, bool required){
    String? msg;
    if(required){
      msg = dateTime == null ? "Установите время" : null;
    }
    return msg;






  }




}