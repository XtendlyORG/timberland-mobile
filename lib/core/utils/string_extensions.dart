extension TitleCase on String {

  String toTitleCase(){
    return this.split(' ').map((e) => e[0].toUpperCase()+e.substring(1)).join(' ');
  }
}