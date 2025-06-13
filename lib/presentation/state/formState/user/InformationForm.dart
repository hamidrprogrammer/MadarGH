import 'package:my_ios_app/data/body/user/information/InformationBodey.dart';
import 'package:my_ios_app/presentation/ui/Information/InformationUi.dart';

class InformationFormState {
  String? firstName;
  String? lastName;
  int? motherEducation;
  String? motherJobTitle;
  String? id;

  int? motherJobStatus;
  int? fatherEducation;
  String? fatherJobTitle;
  int? fatherJobStatus;
  int? maritalStatus;
  int? mentalPeace;
  int? support;
  int? health;

  InformationFormState({
    this.firstName = '',
    this.lastName = '',
    this.id = '',
    this.motherEducation = 0,
    this.motherJobTitle = '',
    this.motherJobStatus = 0,
    this.fatherEducation = 0,
    this.fatherJobTitle = '',
    this.fatherJobStatus = 0,
    this.maritalStatus = 0,
    this.mentalPeace = 0,
    this.support = 0,
    this.health = 0,
  });

  InformationBody getBody() {
    return InformationBody(
      firstName: firstName,
      lastName: lastName,
      id: id,
      motherEducation: motherEducation,
      motherJobTitle: motherJobTitle,
      motherJobStatus: motherJobStatus,
      fatherEducation: fatherEducation,
      fatherJobTitle: fatherJobTitle,
      fatherJobStatus: fatherJobStatus,
      maritalStatus: maritalStatus,
      mentalPeace: mentalPeace,
      support: support,
      health: health,
    );
  }
}
