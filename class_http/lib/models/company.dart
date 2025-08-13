class Company {
  String name;
  String catchPhrase;
  String bs;

  Company.info(Map<String, dynamic> companyMap)
      : name = companyMap["name"],
        catchPhrase = companyMap["catchPhrase"],
        bs = companyMap["bs"];
}
