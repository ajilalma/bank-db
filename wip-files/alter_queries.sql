update account set frequency = "MONTHLY" where frequency = "POPLATEK MESICNE";
update account set frequency = "WEEKLY" where frequency = "POPLATEK TYDNE";
update account set frequency = "ISSUANCE_AFTER_TRANS" where frequency = "POPLATEK PO OBRATU";

update trans set type = "CREDIT" where type = "PRIJEM";
update trans set type = "DEBIT" where type = "VYDAJ";

update trans set operation = "CC_DEBIT" where operation = "VYBER KARTOU";
update trans set operation = "CASH_CREDIT" where operation = "VKLAD";
update trans set operation = "OTHER_BNK_DEBIT" where operation = "PREVOD Z UCTU";
update trans set operation = "CASH_DEBIT" where operation = "VYBER";
update trans set operation = "OTHER_BNK_CREDIT" where operation = "PREVOD NA UCET";
update trans set operation = "OTHER_BNK_COLLECT" where operation = "OTHER_BNK_DEBIT";
update trans set operation = "OTHER_BNK_REMIT" where operation = "OTHER_BNK_CREDIT";

update trans set characterization = "INSURANCE" where characterization = "POJISTNE";
update trans set characterization = "PAY_FOR_STATEMENT" where characterization = "SLUZBY";
update trans set characterization = "INTEREST_CREDIT" where characterization = "UROK";
update trans set characterization = "SANC_INT_NEG_BALANCE" where characterization = "SANKC. UROK";

update trans set characterization = "HOUSEHOLD" where characterization = "SIPO";
update trans set characterization = "OLD_AGE_PENSION" where characterization = "DUCHOD";
update trans set characterization = "LOAN_PAY" where characterization = "UVER";


alter table client add column birthdate int(11);
alter table client add column gender text;
alter table client add column name text;

update client set gender = "MALE" where (birth_number - ((birth_number / 10000) * 10000)) <  5000;
update client set gender = "FEMALE" where (birth_number - ((birth_number / 10000) * 10000)) >=  5000;
update client set birth_number = birth_number - 5000 where (birth_number - ((birth_number / 10000) * 10000)) >=  5000;
update client set birthdate = birth_number;
alter table client drop column birth_number;
