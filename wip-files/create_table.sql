

--
-- Table structure for table district
--

DROP TABLE IF EXISTS district;
CREATE TABLE district (
  district_id int(11) DEFAULT NULL,
  district_name text,
  region text,
  count_inhabitants int(11) DEFAULT NULL,
  count_munic_lt_499 int(11) DEFAULT NULL,
  count_munic_lt_2000 int(11) DEFAULT NULL,
  count_munic_lt_10000 int(11) DEFAULT NULL,
  count_munic_gt_10000 int(11) DEFAULT NULL,
  count_cities int(11) DEFAULT NULL,
  ratio_urban_inhabitants float DEFAULT NULL,
  average_salary int(11) DEFAULT NULL,
  unemployment_95 float DEFAULT NULL,
  unemployment_96 float DEFAULT NULL,
  enterpreneurs_per_1000 int(11) DEFAULT NULL,
  crimes_95 int(11) DEFAULT NULL,
  crimes_96 int(11) DEFAULT NULL
);

DROP TABLE IF EXISTS account;
CREATE TABLE account (
  account_id int(11) NOT NULL,
  district_id int(11) DEFAULT NULL,
  frequency text,
  date int(11) DEFAULT NULL,
  PRIMARY KEY (account_id),
  FOREIGN KEY (district_id) REFERENCES district(district_id)
);

--
-- Table structure for table client
--

DROP TABLE IF EXISTS client;
CREATE TABLE client (
  client_id int(11) DEFAULT NULL,
  birth_number int(11) DEFAULT NULL,
  district_id int(11) DEFAULT NULL,
  PRIMARY KEY (client_id),
  FOREIGN KEY (district_id) REFERENCES district(district_id)
);

--
-- Table structure for table disp
--

DROP TABLE IF EXISTS disp;
CREATE TABLE disp (
  disp_id int(11) DEFAULT NULL,
  client_id int(11) DEFAULT NULL,
  account_id int(11) DEFAULT NULL,
  type text,
  PRIMARY KEY (disp_id),
  FOREIGN KEY (client_id) REFERENCES client(client_id),
  FOREIGN KEY (account_id) REFERENCES account(account_id)
);

--
-- Table structure for table card
--

DROP TABLE IF EXISTS card;
CREATE TABLE card (
  card_id int(11) DEFAULT NULL,
  disp_id int(11) DEFAULT NULL,
  type text,
  issued text,
  PRIMARY KEY (card_id),
  FOREIGN KEY (disp_id) REFERENCES disp(disp_id)
);

--
-- Table structure for table loan
--

DROP TABLE IF EXISTS loan;
CREATE TABLE loan (
  loan_id int(11) DEFAULT NULL,
  account_id int(11) DEFAULT NULL,
  date int(11) DEFAULT NULL,
  amount int(11) DEFAULT NULL,
  duration int(11) DEFAULT NULL,
  payments float DEFAULT NULL,
  status text,
  PRIMARY KEY (loan_id),
  FOREIGN KEY (account_id) REFERENCES account(account_id)
);

--
-- Table structure for table order
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  order_id int(11) DEFAULT NULL,
  account_id int(11) DEFAULT NULL,
  bank_to text,
  account_to int(11) DEFAULT NULL,
  amount float DEFAULT NULL,
  characterization text,
  PRIMARY KEY (order_id),
  FOREIGN KEY (account_id) REFERENCES account(account_id)
);

--
-- Table structure for table trans
--

DROP TABLE IF EXISTS trans;
CREATE TABLE trans (
  trans_id int(11) DEFAULT NULL,
  account_id int(11) DEFAULT NULL,
  date int(11) DEFAULT NULL,
  type text,
  operation text,
  amount float DEFAULT NULL,
  balance float DEFAULT NULL,
  characterization text,
  bank text,
  account int(11) DEFAULT NULL,
  PRIMARY KEY (trans_id),
  FOREIGN KEY (account_id) REFERENCES account(account_id)
);