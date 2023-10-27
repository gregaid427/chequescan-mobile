import 'package:flutter/cupertino.dart';

class TransactionsData extends ChangeNotifier {

  String? _frontImagelink;
  String? _backImagelink;
  String? _chosenAccount;
  String? _chosenAccountid;
  String? _transferType = "Express";
  String? _accountType;
  String? _bank;
  String? _chequeBank;

  int? _accountNoLength;
  int? _BankNoLength;
  int? _chequeNoLength;

  String? _chequeBankNo;
  String? _chequeAccntNo;
  String? _chequeNo;
  String? _chequeBankName;




  get getfrontImagelink => _frontImagelink;
  get getbackImagelink => _backImagelink;
  get getchosenAccount => _chosenAccount;
  get getchosenAccountid => _chosenAccountid;
  get getTransferType => _transferType;
  get getaccountType => _accountType;
  get getbank => _bank;

  get getChequebank => _chequeBank;
  get getacctNoLength => _accountNoLength;
  get getChequeNoLength => _chequeNoLength;
  get getBankNoLength => _BankNoLength;

  get getchequeBankNo => _chequeBankNo;
  get getchequeAccntNo => _chequeAccntNo;
  get getchequeNo => _chequeNo;
  get getchequeBankName => _chequeBankName;


  void setChequeValues(String chequeBank,String accountNo,String BankNo,String chequeNo){
    _chequeBankName = chequeBank;
    notifyListeners();

    _chequeAccntNo = accountNo;
    notifyListeners();

    _chequeBankNo = BankNo;
    notifyListeners();

    _chequeNo = chequeNo;
    notifyListeners();

    print('cheque values set');

  }



  void setbank(String link){
    _bank = link;
    notifyListeners();

  }
  void setChequeDetails(String chequeBank,int accountNoLength,int BankNoLength,int chequeNoLength){
    _chequeBank = chequeBank;
    notifyListeners();

    _accountNoLength = accountNoLength;
    notifyListeners();

    _BankNoLength = BankNoLength;
    notifyListeners();

    _chequeNoLength = chequeNoLength;
    notifyListeners();

print('cheque details set');

  }

  void setChosenAccountType(String link){
    _accountType = link;
    notifyListeners();

  }

  void setfrontImagelink(String link){
    _frontImagelink = link;
    notifyListeners();

  }

  void setBackImagelink(String link){
    _backImagelink = link;
    notifyListeners();
  }

  void setChosenAccount(String value){
    print('account is set');
    _chosenAccount = value;
    notifyListeners();

  }

  void setChosenAccountid(String value){
    _chosenAccountid = value;
    notifyListeners();

  }

  void setTransferType(String link){
    _transferType = link;
    notifyListeners();
    print('transfer type is set to $_transferType' );
  }

  void setFieldsEmpty() {
     _frontImagelink = "";
     _backImagelink = "";
     _chosenAccount ="";
     _transferType = "Express";
     _accountType ="";
     _bank = "";

  }

}