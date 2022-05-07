
enum ActionList{
  changeChannel,
  toggleSearchMode,
  upPointer,
  downPointer,
  setSearchResults,
  setLoaded
}

class AppAction{
  var action,payload;
  AppAction({required this.action,this.payload});
}