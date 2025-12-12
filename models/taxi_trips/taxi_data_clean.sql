SELECT 
VendorID, tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count, trip_distance, RatecodeID, payment_type, store_and_fwd_flag, fare_amount, extra, tip_amount, tolls_amount, improvement_surcharge, total_amount, congestion_surcharge, Airport_fee, cbd_congestion_fee
FROM {{ source('taxi_data_source', 'raw_taxi_data') }}
WHERE 
    RatecodeID IN (1, 2, 3, 4, 5, 6, 7, 8)
    AND store_and_fwd_flag IN ('Y', 'N') 
    AND passenger_count > 1 
    AND tpep_pickup_datetime < tpep_dropoff_datetime
LIMIT 10