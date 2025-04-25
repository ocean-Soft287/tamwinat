class UserDataModel {
  int? usID;
  String? usName;
  String? passWord;
 dynamic accessPermission;
  String? fullUserName;
  dynamic accBR;
  dynamic showPrice;
  dynamic employeeID;
  int? uSIDH;
  dynamic  acAc;
  dynamic acGpr;
  dynamic cIAccP;



  UserDataModel.fromJson(Map<String, dynamic> json) {
    usID = json['UsID'];
    usName = json['UsName'];
    passWord = json['PassWord'];
    accessPermission = json['AccessPermission'];
    fullUserName = json['FullUserName'];
    accBR = json['AccBR'];
    showPrice = json['ShowPrice'];
    employeeID = json['EmployeeID'];
    uSIDH = json['USIDH'];
    acAc = json['AcAc'];
    acGpr = json['AcGpr'];
    cIAccP = json['CIAccP'];
  }


}