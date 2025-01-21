import sqlite3
import json
from db_data_insertion.constants import TABLE_ORDER_FOR_PROCESSING, DATA_REFINEMENT_QUERIES

def insert_data(dataJsonFilePath):
    try:
        with sqlite3.connect('./makeathondb') as conn, open(dataJsonFilePath) as dataJson:
            data = json.load(dataJson)
            print('Starting to insert data to the db')
            for table_name in TABLE_ORDER_FOR_PROCESSING:
                dataForTable = data[table_name]
                if not dataForTable:
                    raise Exception('table not found: {0}'.format(table_name))
                print('processing table {0}; number of records: {1}'.format(table_name, len(dataForTable)))
                for singleRow in dataForTable:
                    keys = singleRow.keys()
                    columns = ', '.join(keys)
                    placeholders = ', '.join([':' + key for key in keys])
                    sql = f"INSERT INTO `{table_name}` ({columns}) VALUES ({placeholders})"
                    run_sqlite_query(conn=conn, sql=sql, params=singleRow)

            print('Starting inserted data refinement')
            for query in DATA_REFINEMENT_QUERIES:
                print(f'running: {query}')
                run_sqlite_query(conn=conn, sql=query, params={})
    except sqlite3.Error as Error:
        print('Error occured - ',  Error)
    finally:
        if conn:
            conn.close()
            print('db connection closed')

def run_sqlite_query(conn, sql, params):
    cur = conn.cursor()
    cur.execute(sql, params)
    conn.commit()
    return cur.lastrowid