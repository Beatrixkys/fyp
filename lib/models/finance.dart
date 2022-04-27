class AccountsData {
  final String accountid;
  final String name;
  final int amount;

  AccountsData(
      {required this.accountid, required this.name, required this.amount});
}

class RecordsData {
  final String recordid;
  final String name;
  final int amount;
  final String accname;
  final String recordtype;
  final String recordcategory;

  RecordsData(
      {required this.recordid,
      required this.name,
      required this.amount,
      required this.accname,
      required this.recordtype,
      required this.recordcategory});
}
