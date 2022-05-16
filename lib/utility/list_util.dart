class ListUtil {
  static bool isEmpty(List? object) {
    return object == null || object.isEmpty;
  }
static bool isNotEmpty(List? object) {
    return !isEmpty(object);
  }
}
