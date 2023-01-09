
class SJMSPrint{
    SJMSPrint._();

    static void printWrapped(text) {
      try {
        final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
        pattern.allMatches(text).forEach((match) => print(match.group(0)));
      }catch(e){
        print(text);
      }
    }
}