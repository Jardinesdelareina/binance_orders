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
    df = pd.DataFrame(CLIENT.get_all_orders(symbol=ticker, limit=1000))
    df.drop([
        'clientOrderId', 'orderListId', 'timeInForce', 'icebergQty', 'selfTradePreventionMode',
        'origQuoteOrderQty', 'isWorking', 'stopPrice', 'origQty', 'updateTime', 'workingTime',
        ], axis=1, inplace=True
    )
    df = df.rename(columns={
        'orderId': 'order_id',
        'executedQty': 'execute_qty',
        'updateTime': 'update_time',
        'workingTime': 'working_time',
        'cummulativeQuoteQty': 'cum_qty'
    })
    df.time = pd.Series(pd.to_datetime(df.time, unit='ms', utc=True)).dt.strftime('%Y-%m-%d %H:%M:%S')
    df.price = round(df.price.astype(float), 4)
    df.execute_qty = round(df.execute_qty.astype(float), 6 if ticker == 'BTCUSDT' else 4)
    df.cum_qty = round(df.cum_qty.astype(float), 2)
    title_table = ticker.lower()
    df.to_sql(name=title_table, con=ENGINE, if_exists='replace', index=False)
    print(f'create table {title_table}')


table_names = [
    'BTCUSDT', 'ETHUSDT', 'BNBUSDT', 'XRPUSDT', 'DOTUSDT', 
    'LINKUSDT', 'MATICUSDT', 'AVAXUSDT', 'ZILUSDT', 'VETUSDT'
]

for name in table_names:
    create_db(name)
