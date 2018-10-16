Apache Sqoop efficiently transfers bulk data between Apache Hadoop and structured datastores such as relational databases. Sqoop helps offload certain tasks (such as ETL processing) from the EDW to Hadoop for efficient execution at a much lower cost. Sqoop can also be used to extract data from Hadoop and export it into external structured datastores. Sqoop works with relational databases such as Teradata, Netezza, Oracle, MySQL, Postgres, and HSQLDB

YARN coordinates data ingest from Apache Sqoop and other services that deliver data into the Enterprise Hadoop cluster.


Parameter Files: 
A) env_variables.json
B) tables.json

Data Ingestion Scripts: 
A) load_hdfs_to_hive.py
B) sqoop_oracle_hdfs_incremental.py
C) sqoop_oracle_hdfs.py