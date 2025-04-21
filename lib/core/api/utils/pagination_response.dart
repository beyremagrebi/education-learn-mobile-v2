import '../../base/base_model.dart';
import 'from_json.dart';

class PaginatedResponse<Model extends BaseModel> {
  List<Model>? data;
  int? totalData;
  int? totalPages;
  int? currentPage;

  PaginatedResponse({
    this.data,
    this.totalData,
    this.totalPages,
    this.currentPage,
  });

  factory PaginatedResponse.fromMap(
      Map<String, dynamic> map, Model Function(dynamic) fromMap) {
    return PaginatedResponse(
      data: FromJson.modelList(map['data'], fromMap),
      totalData: FromJson.integer(map['totalData']),
      totalPages: FromJson.integer(map['totalPages']),
      currentPage: FromJson.integer(map['currentPage']),
    );
  }
}
