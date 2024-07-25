abstract class ProfileStates {}

class ProfileStatesInitialStateStates extends ProfileStates {}
class ProfileStatesLoadingStateStates extends ProfileStates {}
class ProfileSucssessfullStateStates extends ProfileStates {

  ProfileSucssessfullStateStates();
}
class ProfileErrorStateStates extends ProfileStates {

  ProfileErrorStateStates();
}

class EditProfileStatesLoadingStateStates extends ProfileStates {}
class EditProfileSucssessfullStateStates extends ProfileStates {

  EditProfileSucssessfullStateStates();
}
class EditProfileErrorStateStates extends ProfileStates {
final int stateCode;
  EditProfileErrorStateStates( this.stateCode);
}

class CreateProfileStatesLoadingStateStates extends ProfileStates {}
class CreateProfileSucssessfullStateStates extends ProfileStates {

  CreateProfileSucssessfullStateStates();
}
class CreateProfileErrorStateStates extends ProfileStates {

  CreateProfileErrorStateStates();
}

class AboutMeStatesLoadingStateStates extends ProfileStates {}
class AboutMeSucssessfullStateStates extends ProfileStates {

  AboutMeSucssessfullStateStates();
}
class AboutMeErrorStateStates extends ProfileStates {
 final int stateCode;
  AboutMeErrorStateStates(this.stateCode);
}

class EditAboutMeStatesLoadingStateStates extends ProfileStates {}
class EditAboutMeSucssessfullStateStates extends ProfileStates {

  EditAboutMeSucssessfullStateStates();
}
class EditAboutMeErrorStateStates extends ProfileStates {
  final int stateCode;
  EditAboutMeErrorStateStates(this.stateCode);
}

class WorkExperienceStatesLoadingStateStates extends ProfileStates {}
class WorkExperienceSucssessfullStateStates extends ProfileStates {

  WorkExperienceSucssessfullStateStates();
}
class WorkExperienceErrorStateStates extends ProfileStates {
  final int stateCode;

  WorkExperienceErrorStateStates(this.stateCode);
}

class EditWorkExperienceStatesLoadingStateStates extends ProfileStates {}
class EditWorkExperienceSucssessfullStateStates extends ProfileStates {

  EditWorkExperienceSucssessfullStateStates();
}
class EditWorkExperienceErrorStateStates extends ProfileStates {
  final int stateCode;

  EditWorkExperienceErrorStateStates(this.stateCode);
}

class EducationStatesLoadingStateStates extends ProfileStates {}
class EducationSucssessfullStateStates extends ProfileStates {

  EducationSucssessfullStateStates();
}
class EducationErrorStateStates extends ProfileStates {
  final int stateCode;

  EducationErrorStateStates(this.stateCode);
}

class EditEducationStatesLoadingStateStates extends ProfileStates {}
class EditEducationSucssessfullStateStates extends ProfileStates {

  EditEducationSucssessfullStateStates();
}
class EditEducationErrorStateStates extends ProfileStates {
  final int stateCode;

  EditEducationErrorStateStates(this.stateCode);
}

class GetInformationStatesLoadingStateStates extends ProfileStates {}
class GetInformationSucssessfullStateStates extends ProfileStates {

  GetInformationSucssessfullStateStates();
}
class GetInformationErrorStateStates extends ProfileStates {
  final int stateCode;
  GetInformationErrorStateStates(this.stateCode);
}

class PostFileLoadStateStates extends ProfileStates {

}
class PostFileSucssessfullStateStates extends ProfileStates {

}
class PostFileErrorStateStates extends ProfileStates {
  final int statusCode;
  final String message;
  PostFileErrorStateStates(this.statusCode, this.message);
}