TABLE_ORDER_FOR_PROCESSING = [
    'branch',
    'customer',
    'account_type',
    'account',
    'card',
    'loan_type',
    'loan',
    'pre_authorized_debit',
    'transaction'
]

DATA_REFINEMENT_QUERIES = [
    # make sure that the customer is not created before their birth date
    "update customer set create_time = date_of_birth where date_of_birth > create_time",
    # Make sure the account that are linked to a loan record is tagged under the account type 'LOAN'
    "update account set account_type_id = (select at.id from account_type at  where at.category = 'LOAN') where id in (select l.account_id from loan l)",
    # Make sure the account that are NOT linked to a loan record but is wrongly tagged under 'LOAN'is tagged under the account type 'SAVINGS'
    "update account set account_type_id = (select at1.id from account_type at1 where at1.category = 'SAVINGS') where account_type_id = (select at.id from account_type at where at.category = 'LOAN') and id not in (select l.account_id from loan l)",
    # Make sure none of the loan accounts have exceeded the allocated loan amount
    "update account as a set balance = (select l.allocated_amount / 2 from loan l where l.account_id = a.id) where id in (select ac.id from account ac join loan ln on ln.account_id = ac.id where ac.balance > ln.allocated_amount)"
]