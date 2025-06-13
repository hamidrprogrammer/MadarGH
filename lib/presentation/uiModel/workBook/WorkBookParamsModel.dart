class WorkBookParamsModel {
  String userChildId, workShopId;
  String? lastWorkShopId, lastAgeDomain,idPack;

  WorkBookParamsModel(
      {this.userChildId = '',
      this.workShopId = '',
         this.idPack = '',
      this.lastWorkShopId,
      this.lastAgeDomain});

  Map<String, String> toJson() => {
        'userChildId': userChildId,
        'workShopId': workShopId,
           'idPack': idPack ?? 'null',
        'lastWorkShopId': lastWorkShopId ?? 'null',
        'lastAgeDomain': lastAgeDomain ?? 'null',
      };
}
