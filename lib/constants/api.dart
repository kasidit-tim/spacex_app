class SpacexUrl {
  SpacexUrl._();

  static const getAll = "/v5/launches";
  static getById(String id) => "/v5/launches/$id";
}
