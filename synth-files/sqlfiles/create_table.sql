
drop table if exists branch;
create table branch (
    id integer,
    branch_code text,
    name text,
    address text,
    primary key (id)
);

drop table if exists customer;
create table customer (
    id integer,
    first_name text,
    last_name text,
    email text,
    date_of_birth datetime,
    gender text,
    nationality text,
    ssn text,
    branch_id integer,
    create_time  datetime,
    primary key (id)
    foreign key (branch_id) references branch (id)
);

drop table if exists account_type;
create table account_type (
    id integer,
    name text,
    category text,
    primary key (id)
);

drop table if exists account;
create table account (
    id integer,
    customer_id integer,
    account_type_id integer,
    balance real,
    status text,
    primary key (id),
    foreign key (customer_id) references customer (id),
    foreign key (account_type_id) references account_type (id)
);

drop table if exists card;
create table card (
    id integer,
    account_id integer,
    card_number text,
    expiration_month text,
    cvv text,
    pin_hash text,
    status text,
    primary key (id),
    foreign key (account_id) references account (id)
);

drop table if exists loan_type;
create table loan_type (
    id integer,
    loan_type text,
    description text,
    base_interest real,
    base_amount real,
    primary key (id)
);

drop table if exists loan;
create table loan (
    id integer,
    loan_type_id integer,
    account_id integer,
    allocated_amount real,
    interest real,
    start_date datetime,
    due_date datetime,
    primary key (id),
    foreign key (loan_type_id) references loan_type (loan_type_id),
    foreign key (account_id) references account (id)
);

drop table if exists pre_authorized_debit;
create table pre_authorized_debit (
    id integer,
    account_id integer,
    amount real,
    frequency text,
    start_date datetime,
    end_date datetime,
    next_debit_date datetime,
    other_bank_id text,
    other_bank_account_num text,
    status text,
    primary key (id),
    foreign key (account_id) references account (id)
);

drop table if exists `transaction`;
create table `transaction` (
    id text,
    account_id integer,
    category text,
    channel text,
    amount real,
    description text,
    other_bank_id text,
    other_bank_account_num text,
    fees real,
    create_time datetime,
    primary key (id),
    foreign key (account_id) references account (id)
);