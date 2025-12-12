from sklearn.preprocessing import LabelEncoder
import pandas as pd	
import numpy as np

def model(dbt, session):
    dbt.config(
        packages=['scikit-learn', 'pandas'], 
        materialized='table'
    )
    # Reference the source table
    # to_df depends on the adapter, it could be to_pandas() or to_spark()
    df = dbt.ref("taxi_data_clean").to_df()
    df['trip_duration'] = np.ceil((df['tpep_dropoff_datetime'].apply(pd.to_datetime) - df['tpep_pickup_datetime'].apply(pd.to_datetime)).dt.total_seconds() / 60.0) 

    # Encode categorical variables
    label_encoder = LabelEncoder()
    df['store_and_fwd_flag_encoded'] = label_encoder.fit_transform(df['store_and_fwd_flag'])

    # Return the transformed DataFrame as a new table
    return df