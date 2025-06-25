import time
import json
import random
from azure.eventhub import EventHubProducerClient, EventData

# Replace with your actual connection string and hub name
CONNECTION_STR = "Endpoint=sb://rtstocknamespace.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=IrvSVMRPb45i5FIfnxr2oRjOG5tfSxV7Z+AEhNSQ2RY="

EVENT_HUB_NAME = "rtstockhub"

symbols = ['AAPL', 'GOOGL', 'MSFT', 'AMZN', 'TSLA']

producer = EventHubProducerClient.from_connection_string(
    conn_str=CONNECTION_STR,
    eventhub_name=EVENT_HUB_NAME
)

def generate_stock_data():
    stock = random.choice(symbols)
    price = round(random.uniform(100, 1500), 2)
    return {
        "symbol": stock,
        "price": price,
        "timestamp": time.strftime("%Y-%m-%d %H:%M:%S")
    }

while True:
    data = generate_stock_data()
    event_data = EventData(json.dumps(data))
    with producer:
        producer.send_batch([event_data])
        print(f"Sent: {data}")
    time.sleep(2)  # simulate real-time every 2 seconds
