from delta.tables import *
from DeltaProcessing import DeltaProcessing
from variables import bronze_dict, silver_dict, gold_list, gold_dict

if __name__ == "__main__":
    delta = DeltaProcessing(landing_zone_bucket = "landing-zone-339713192302", 
                            bronze_bucket = "bronze-zone-339713192302",
                            silver_bucket = "silver-zone-339713192302",
                            gold_bucket= "gold-zone-339713192302")

    for table_name, columns in bronze_dict.items():
        delta.write_to_bronze(
                                prefix = f"mysql/{table_name}/",
                                format = "parquet",
                                cols = [*columns])

    for table_name, query in silver_dict.items():
        delta.write_to_silver(
                                prefix = f"mysql/{table_name}",
                                sql = query,      
                                upsert = False)

    for table_name, query in gold_dict.items():
        delta.write_to_gold(
                                prefix_list = gold_list,
                                prefix = f"delivery/{table_name}",
                                sql = query,
                                upsert = False)
        
print("ETL Job has been executed successfully!")
