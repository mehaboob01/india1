class UploadSignedModel {
  String? uploadSignedURL;
  String? fileName;

  UploadSignedModel({this.uploadSignedURL, this.fileName});

  UploadSignedModel.fromJson(Map<String, dynamic> json) {
    uploadSignedURL = json['uploadSignedURL'];
    fileName = json['fileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uploadSignedURL'] = this.uploadSignedURL;
    data['fileName'] = this.fileName;
    return data;
  }
}
