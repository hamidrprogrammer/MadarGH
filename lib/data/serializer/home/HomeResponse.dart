import 'dart:convert';
HomeResponse homeResponseFromJson(String str) => HomeResponse.fromJson(json.decode(str));
String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());
class HomeResponse {
  HomeResponse({
      this.mainImage, 
      this.signupImage, 
      this.signinImage, 
      this.forgotPassword, 
      this.changePassword, 
      this.homePageDown, 
      this.categoryAd, 
      this.packageAd, 
      this.subscriptionImage, 
      this.videoFile, 
      this.carrouselImages, 
      this.packageWorkshops,});

  HomeResponse.fromJson(dynamic json) {
    if (json['mainImage'] != null) {
      mainImage = [];
      json['mainImage'].forEach((v) {
        mainImage?.add(MainImage.fromJson(v));
      });
    }
    signupImage = json['signupImage'] != null ? SignupImage.fromJson(json['signupImage']) : null;
    signinImage = json['signinImage'] != null ? SigninImage.fromJson(json['signinImage']) : null;
    forgotPassword = json['forgotPassword'] != null ? ForgotPassword.fromJson(json['forgotPassword']) : null;
    changePassword = json['changePassword'] != null ? ChangePassword.fromJson(json['changePassword']) : null;
    homePageDown = json['homePageDown'] != null ? HomePageDown.fromJson(json['homePageDown']) : null;
    categoryAd = json['categoryAd'] != null ? CategoryAd.fromJson(json['categoryAd']) : null;
    packageAd = json['packageAd'] != null ? PackageAd.fromJson(json['packageAd']) : null;
    subscriptionImage = json['subscriptionImage'] != null ? SubscriptionImage.fromJson(json['subscriptionImage']) : null;
    videoFile = json['videoFile'] != null ? VideoFile.fromJson(json['videoFile']) : null;
    if (json['carrouselImages'] != null) {
      carrouselImages = [];
      json['carrouselImages'].forEach((v) {
        carrouselImages?.add(CarrouselImages.fromJson(v));
      });
    }
    if (json['packageWorkshops'] != null) {
      packageWorkshops = [];
      json['packageWorkshops'].forEach((v) {
        packageWorkshops?.add(PackageWorkshops.fromJson(v));
      });
    }
  }
  List<MainImage>? mainImage;
  SignupImage? signupImage;
  SigninImage? signinImage;
  ForgotPassword? forgotPassword;
  ChangePassword? changePassword;
  HomePageDown? homePageDown;
  CategoryAd? categoryAd;
  PackageAd? packageAd;
  SubscriptionImage? subscriptionImage;
  VideoFile? videoFile;
  List<CarrouselImages>? carrouselImages;
  List<PackageWorkshops>? packageWorkshops;
HomeResponse copyWith({  List<MainImage>? mainImage,
  SignupImage? signupImage,
  SigninImage? signinImage,
  ForgotPassword? forgotPassword,
  ChangePassword? changePassword,
  HomePageDown? homePageDown,
  CategoryAd? categoryAd,
  PackageAd? packageAd,
  SubscriptionImage? subscriptionImage,
  VideoFile? videoFile,
  List<CarrouselImages>? carrouselImages,
  List<PackageWorkshops>? packageWorkshops,
}) => HomeResponse(  mainImage: mainImage ?? this.mainImage,
  signupImage: signupImage ?? this.signupImage,
  signinImage: signinImage ?? this.signinImage,
  forgotPassword: forgotPassword ?? this.forgotPassword,
  changePassword: changePassword ?? this.changePassword,
  homePageDown: homePageDown ?? this.homePageDown,
  categoryAd: categoryAd ?? this.categoryAd,
  packageAd: packageAd ?? this.packageAd,
  subscriptionImage: subscriptionImage ?? this.subscriptionImage,
  videoFile: videoFile ?? this.videoFile,
  carrouselImages: carrouselImages ?? this.carrouselImages,
  packageWorkshops: packageWorkshops ?? this.packageWorkshops,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mainImage != null) {
      map['mainImage'] = mainImage?.map((v) => v.toJson()).toList();
    }
    if (signupImage != null) {
      map['signupImage'] = signupImage?.toJson();
    }
    if (signinImage != null) {
      map['signinImage'] = signinImage?.toJson();
    }
    if (forgotPassword != null) {
      map['forgotPassword'] = forgotPassword?.toJson();
    }
    if (changePassword != null) {
      map['changePassword'] = changePassword?.toJson();
    }
    if (homePageDown != null) {
      map['homePageDown'] = homePageDown?.toJson();
    }
    if (categoryAd != null) {
      map['categoryAd'] = categoryAd?.toJson();
    }
    if (packageAd != null) {
      map['packageAd'] = packageAd?.toJson();
    }
    if (subscriptionImage != null) {
      map['subscriptionImage'] = subscriptionImage?.toJson();
    }
    if (videoFile != null) {
      map['videoFile'] = videoFile?.toJson();
    }
    if (carrouselImages != null) {
      map['carrouselImages'] = carrouselImages?.map((v) => v.toJson()).toList();
    }
    if (packageWorkshops != null) {
      map['packageWorkshops'] = packageWorkshops?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

PackageWorkshops packageWorkshopsFromJson(String str) => PackageWorkshops.fromJson(json.decode(str));
String packageWorkshopsToJson(PackageWorkshops data) => json.encode(data.toJson());
class PackageWorkshops {
  PackageWorkshops({
      this.id, 
      this.packageTitle, 
      this.discountPrice, 
      this.finalPrice, 
      this.teacherName, 
      this.ageDomain, 
      this.iconUrl, 
      this.isPrivate, 
      this.isPublic, 
      this.fileUrl,});

  PackageWorkshops.fromJson(dynamic json) {
    id = json['id'];
    packageTitle = json['packageTitle'];
    discountPrice = json['discountPrice'];
    finalPrice = json['finalPrice'];
    teacherName = json['teacherName'];
    ageDomain = json['ageDomain'];
    iconUrl = json['iconUrl'];
    isPrivate = json['isPrivate'];
    isPublic = json['isPublic'];
    fileUrl = json['fileUrl'];
  }
  num? id;
  String? packageTitle;
  num? discountPrice;
  num? finalPrice;
  String? teacherName;
  String? ageDomain;
  String? iconUrl;
  bool? isPrivate;
  bool? isPublic;
  dynamic fileUrl;
PackageWorkshops copyWith({  num? id,
  String? packageTitle,
  num? discountPrice,
  num? finalPrice,
  dynamic teacherName,
  String? ageDomain,
  String? iconUrl,
  bool? isPrivate,
  bool? isPublic,
  dynamic fileUrl,
}) => PackageWorkshops(  id: id ?? this.id,
  packageTitle: packageTitle ?? this.packageTitle,
  discountPrice: discountPrice ?? this.discountPrice,
  finalPrice: finalPrice ?? this.finalPrice,
  teacherName: teacherName ?? this.teacherName,
  ageDomain: ageDomain ?? this.ageDomain,
  iconUrl: iconUrl ?? this.iconUrl,
  isPrivate: isPrivate ?? this.isPrivate,
  isPublic: isPublic ?? this.isPublic,
  fileUrl: fileUrl ?? this.fileUrl,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['packageTitle'] = packageTitle;
    map['discountPrice'] = discountPrice;
    map['finalPrice'] = finalPrice;
    map['teacherName'] = teacherName;
    map['ageDomain'] = ageDomain;
    map['iconUrl'] = iconUrl;
    map['isPrivate'] = isPrivate;
    map['isPublic'] = isPublic;
    map['fileUrl'] = fileUrl;
    return map;
  }

}

CarrouselImages carrouselImagesFromJson(String str) => CarrouselImages.fromJson(json.decode(str));
String carrouselImagesToJson(CarrouselImages data) => json.encode(data.toJson());
class CarrouselImages {
  CarrouselImages({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  CarrouselImages.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  dynamic link;
  num? imageLocation;
  String? title;
  num? fileType;
  dynamic description;
CarrouselImages copyWith({  num? id,
  String? src,
  dynamic link,
  num? imageLocation,
  String? title,
  num? fileType,
  dynamic description,
}) => CarrouselImages(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

VideoFile videoFileFromJson(String str) => VideoFile.fromJson(json.decode(str));
String videoFileToJson(VideoFile data) => json.encode(data.toJson());
class VideoFile {
  VideoFile({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  VideoFile.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  dynamic imageLocation;
  String? title;
  num? fileType;
  String? description;
VideoFile copyWith({  num? id,
  String? src,
  String? link,
  dynamic imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => VideoFile(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

SubscriptionImage subscriptionImageFromJson(String str) => SubscriptionImage.fromJson(json.decode(str));
String subscriptionImageToJson(SubscriptionImage data) => json.encode(data.toJson());
class SubscriptionImage {
  SubscriptionImage({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  SubscriptionImage.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
SubscriptionImage copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => SubscriptionImage(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

PackageAd packageAdFromJson(String str) => PackageAd.fromJson(json.decode(str));
String packageAdToJson(PackageAd data) => json.encode(data.toJson());
class PackageAd {
  PackageAd({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  PackageAd.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
PackageAd copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => PackageAd(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

CategoryAd categoryAdFromJson(String str) => CategoryAd.fromJson(json.decode(str));
String categoryAdToJson(CategoryAd data) => json.encode(data.toJson());
class CategoryAd {
  CategoryAd({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  CategoryAd.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
CategoryAd copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => CategoryAd(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

HomePageDown homePageDownFromJson(String str) => HomePageDown.fromJson(json.decode(str));
String homePageDownToJson(HomePageDown data) => json.encode(data.toJson());
class HomePageDown {
  HomePageDown({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  HomePageDown.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
HomePageDown copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => HomePageDown(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

ChangePassword changePasswordFromJson(String str) => ChangePassword.fromJson(json.decode(str));
String changePasswordToJson(ChangePassword data) => json.encode(data.toJson());
class ChangePassword {
  ChangePassword({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  ChangePassword.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
ChangePassword copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => ChangePassword(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

ForgotPassword forgotPasswordFromJson(String str) => ForgotPassword.fromJson(json.decode(str));
String forgotPasswordToJson(ForgotPassword data) => json.encode(data.toJson());
class ForgotPassword {
  ForgotPassword({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  ForgotPassword.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
ForgotPassword copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => ForgotPassword(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

SigninImage signinImageFromJson(String str) => SigninImage.fromJson(json.decode(str));
String signinImageToJson(SigninImage data) => json.encode(data.toJson());
class SigninImage {
  SigninImage({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  SigninImage.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
SigninImage copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => SigninImage(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

SignupImage signupImageFromJson(String str) => SignupImage.fromJson(json.decode(str));
String signupImageToJson(SignupImage data) => json.encode(data.toJson());
class SignupImage {
  SignupImage({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  SignupImage.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
SignupImage copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => SignupImage(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}

MainImage mainImageFromJson(String str) => MainImage.fromJson(json.decode(str));
String mainImageToJson(MainImage data) => json.encode(data.toJson());
class MainImage {
  MainImage({
      this.id, 
      this.src, 
      this.link, 
      this.imageLocation, 
      this.title, 
      this.fileType, 
      this.description,});

  MainImage.fromJson(dynamic json) {
    id = json['id'];
    src = json['src'];
    link = json['link'];
    imageLocation = json['imageLocation'];
    title = json['title'];
    fileType = json['fileType'];
    description = json['description'];
  }
  num? id;
  String? src;
  String? link;
  num? imageLocation;
  String? title;
  num? fileType;
  String? description;
MainImage copyWith({  num? id,
  String? src,
  String? link,
  num? imageLocation,
  String? title,
  num? fileType,
  String? description,
}) => MainImage(  id: id ?? this.id,
  src: src ?? this.src,
  link: link ?? this.link,
  imageLocation: imageLocation ?? this.imageLocation,
  title: title ?? this.title,
  fileType: fileType ?? this.fileType,
  description: description ?? this.description,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['src'] = src;
    map['link'] = link;
    map['imageLocation'] = imageLocation;
    map['title'] = title;
    map['fileType'] = fileType;
    map['description'] = description;
    return map;
  }

}