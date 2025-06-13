import 'package:my_ios_app/data/body/app/ContactUsBody.dart';

class ContactUsFormState {
  String message;
  int contentCategoryId;
  ContactUsFormState({

    this.contentCategoryId = 0,

    this.message = '',
  });

  ContactUsBody createBody() => ContactUsBody(

      message: message,
    contentCategoryId: contentCategoryId);
}
