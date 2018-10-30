class User {
  String _UserName;
  String _Password;
  bool _isAdmin;

  User (this._UserName, this._Password, this._isAdmin);

  String get UserName => _UserName;
  set UserName(String value) => _UserName = value;

  bool get isAdmin => _isAdmin;
  set isAdmin(bool value) => _isAdmin = value;

  String get Password => _Password;
  set Password(String value) => _Password = value;

  String toString(){
    return _UserName + ' ' + _Password + ' ' + isAdmin.toString();
  }

}