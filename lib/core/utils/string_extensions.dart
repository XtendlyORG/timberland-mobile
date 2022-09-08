extension TitleCase on String {

  String toTitleCase(){
    return split(' ').map((e) => e[0].toUpperCase()+e.substring(1)).join(' ');
  }
}