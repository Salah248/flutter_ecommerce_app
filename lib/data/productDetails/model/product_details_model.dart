class RatesModel {
    RatesModel({
        required this.id,
        required this.createdAt,
        required this.rate,
        required this.forUser,
        required this.forProduct,
    });

    final String? id;
    final DateTime? createdAt;
    final int? rate;
    final String? forUser;
    final String? forProduct;

    factory RatesModel.fromJson(Map<String, dynamic> json){ 
        return RatesModel(
            id: json["id"],
            createdAt: DateTime.tryParse(json['created_at']),
            rate: json["rate"],
            forUser: json["for_user"],
            forProduct: json["for_product"],
        );
    }

} 

// Comments_Table 

class CommentsModel {
    CommentsModel({
        required this.id,
        required this.createdAt,
        required this.comment,
        required this.forUser,
        required this.forProduct,
        required this.userName,
        required this.replay,
    });

    final String? id;
    final DateTime? createdAt;
    final String? comment;
    final String? forUser;
    final String? forProduct;
    final dynamic userName;
    final dynamic replay;

    factory CommentsModel.fromJson(Map<String, dynamic> json){ 
        return CommentsModel(
            id: json["id"],
            createdAt: DateTime.tryParse(json['created_at']),
            comment: json["comment"],
            forUser: json["for_user"],
            forProduct: json["for_product"],
            userName: json["user_name"],
            replay: json["replay"],
        );
    }

}
