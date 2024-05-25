class Tables {
  final int id;
  final String tname;
  final int chairs;
  final String price;
  final String tableDesc;
  final String imagePath;
  final bool reserve;

  Tables({
    required this.id,
    required this.tname,
    required this.chairs,
    required this.price,
    required this.tableDesc,
    required this.imagePath,
    required this.reserve,
  });

  factory Tables.fromJson(Map<String, dynamic> json) {
    return Tables(
      id: json['id'],
      tname: json['tname'],
      chairs: json['chairs'],
      price: json['price'],
      tableDesc: json['table_desc'],
      imagePath: json['image_path'],
      reserve: json['reserve'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tname': tname,
      'chairs': chairs,
      'price': price,
      'table_desc': tableDesc,
      'image_path': imagePath,
      'reserve': reserve,
    };
  }
}
