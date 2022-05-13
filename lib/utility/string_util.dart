class StringUtil {
  static bool isEmpty(String? object) {
    return object == null || object.isEmpty;
  }
static bool isNotEmpty(String? object) {
    return !isEmpty(object);
  }
}
