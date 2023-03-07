class Massage{
  String? text;
  String? senderId;
  String? data;
  String? receiverID;

  Massage({
    this.receiverID,
    this.senderId,
    this.text,
    this.data,
  });

  Massage.fromJson(Map<String,dynamic>? json){
    receiverID = json!['receiverID'];
    text = json['text'];
    senderId = json['senderId'];
    data = json['data'];
  }

  Map<String,dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverID': receiverID,
      'text': text,
      'data' : data,
    };
  }

}