class ApiEndpoints {
  /// The endpoint to get all the data
  final String getAll;

  /// The endpoint to get data by id
  final String getById;

  /// The endpoint to add data
  final String add;

  /// The endpoint to update data
  final String update;

  /// The endpoint to delete data
  final String delete;

  /// The key of the data in the json response
  final String? getAllDataKey;
  final String? getByIdDataKey;
  final String? addDataKey;
  final String? updateDataKey;

  const ApiEndpoints({
    this.getAll = '/',
    this.getById = '/by-id',
    this.add = '/',
    this.update = '/',
    this.delete = '/',
    this.getAllDataKey,
    this.getByIdDataKey,
    this.addDataKey,
    this.updateDataKey,
  });
}
