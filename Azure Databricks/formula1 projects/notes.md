# Let's start
il faudra comprendre comment marche la formula1
il y un site ergast.com/mrd pour avoir les données

## Project Requirements
- *Data Ingestion requirements:*
  - Ingest all 8 files into the data lake
  - Ingested deta must have the schema applied
  - Ingested data must have audit columns
  - Ingested data must be sored in columnar format (i.e. Parquet)
  - Must be able to analyze the ingested data via SQL
  - Ingestion logic must be able to handle incremental load
- *Data Transformation requirements:*
  - Join the key information required for reportinf to create a new table
  - Join the key information requiredfor analysis to create a new table
  - Transformed tables must have audit columns
  - must be able to analyze the transformed data via SQL
  - Transformed data must be stored in columnar format (i.e. Parquet)
  - Transformation logic must be able to handle incremental load
- *Reporting requirements:*
  - Driver Standings
  - Constructor Standings
- *Analysis requirements:*
  - Dominant Drivers
  - Dominant Teams
  - Visualize the outputs
  - Create databricks Dashboards
- *Scheduling requirements:*
  - Scheduled to run every Sundat at 10pm (22h)
  - Ablity to monitor pipelines
  - Ablity to re-run failed pipelines
  - ABility to set-up alerts on failures
- *Other Non-Functional requirements:*
  - Ability to delete individual records
  - Ability to see history and tome travel
  - Ability to roll back to a previous version

## Solution Architecture Overview

ergast API -> Adls Raw layer -> Ingest with databricks -> ADLS ingested layer -> Transform with databricks -> adls presentation layer -> Analyze with databricks -> Dashboards

We'll use azure data factory to implement the desired result

il faut prendre en considération que l'architecture peu varier d'une personne à une autre et cela selon le concept et la vision de la personne
![](2022-08-15-01-28-04.png)

il y a aussi: https://docs.microsoft.com/en-us/azure/architecture/
par exemple 
![](2022-08-15-01-36-14.png)

