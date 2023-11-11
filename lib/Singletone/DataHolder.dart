class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();

  DataHolder._internal() {

  }

  void initDataHolder(){

  }

  factory DataHolder(){
    return _dataHolder;
  }
}