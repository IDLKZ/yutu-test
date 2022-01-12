class GlobalMixin {
  static String truncateText(String text, int length ,[int start = 0]){
    return text.length > length ? text.substring(0, length - 1) + "..." : text;
  }
}