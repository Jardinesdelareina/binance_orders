import environs
import pandas as pd
from sqlalchemy import create_engine
from binance.client import Client

env = environs.Env()
env.read_env('.env')

DB_USER = env('DB_USER')
DB_PASSWORD = env('DB_PASSWORD')
DB_HOST = env('DB_HOST')
DB_PORT = env('DB_PORT')
DB_NAME = env('DB_NAME')
ENGINE = create_engine(f'postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}')
CLIENT = Client(env('API_KEY'), env('SECRET_KEY'), {'verify': True, 'timeout': 20})


def create_db(ticker):
    df = pd.DataFrame(CLIENT.get_my_trades(symbol=ticker, limit=1000))
    df = df.rename(columns={
        'orderId': 'order_id',
        'quoteQty': 'quote_qty',
        'commissionAsset': 'commission_asset',
        'isBuyer': 'is_buyer',
        'isMaker': 'is_maker'
    })
    df.price = df.price.astype(float)
    df.qty = df.qty.astype(float)
    df.quote_qty = round((df.quote_qty.astype(float)), 4)
    df.commission = round((df.commission.astype(float)), 4)
    df.time = pd.Series(pd.to_datetime(df.time, unit='ms', utc=True)).dt.strftime('%Y-%m-%d %H:%M:%S')
    df.drop('orderListId', axis=1, inplace=True)
    df.drop('id', axis=1, inplace=True)
    df.drop('isBestMatch', axis=1, inplace=True)
    title_table = ticker.lower()
    df.to_sql(name=title_table, con=ENGINE, if_exists='replace', index=False)
    print(f'create table {title_table}')


create_db('BTCUSDT')
