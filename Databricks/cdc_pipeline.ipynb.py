# Databricks notebook source
# Get widget arguments passed from ADF
dbutils.widgets.text("table_name", "")
dbutils.widgets.text("landing_path", "")
dbutils.widgets.text("target_path", "")

table_name = dbutils.widgets.get("table_name")
landing_path = dbutils.widgets.get("landing_path")
target_path = dbutils.widgets.get("target_path")

print(f"Running CDC merge for table: {table_name}")
print(f"Landing Path: {landing_path}")
print(f"Target Path: {target_path}")


# COMMAND ----------

dbutils.widgets.text("table_name", "")
dbutils.widgets.text("landing_path", "")
dbutils.widgets.text("target_path", "")


# COMMAND ----------

# Define JDBC URL and connection properties
jdbc_url = "jdbc:sqlserver://"localhost".database.windows.net:1433;database=management"

connection_properties = {
    "user": "sa",  # usually like sam123
    "password": "K@mi",  # SQL login password
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}


# COMMAND ----------

# Replace with your values
mount_point = "/mnt/cdc"
container_name = "cdc-input"
storage_account_name = "cpfstorage"
access_key = "*****************"  

if not any(mount.mountPoint == mount_point for mount in dbutils.fs.mounts()):
    dbutils.fs.mount(
        source=f"wasbs://{source}@{cpfstorage}.blob.core.windows.net/",
        mount_point=mount_point,
        extra_configs={f"fs.azure.sas.{container_name}.{storage_account_name}.blob.core.windows.net":access_key}
    )
else:
    print(f"{mount_point} is already mounted.")


# COMMAND ----------

display(dbutils.fs.ls("/mnt/cdc"))


# COMMAND ----------

jdbc_url = "jdbc:sqlserver://localhost.database.windows.net:1433;database=management"
properties = {
    "user": "sa",
    "password": "*******",
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}

# Load Customer table
customer_df = spark.read.jdbc(url=jdbc_url, table="dbo.Customer", properties=properties)

# Save as Delta
customer_df.write.format("delta").mode("overwrite").save("/mnt/cdc/customer")


# COMMAND ----------

jdbc_url = "jdbc:sqlserver://localhost.database.windows.net:1433;database=management"
properties = {
    "user": "sa",
    "password": "*******",
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}

# Load Customer table
customer_df = spark.read.jdbc(url=jdbc_url, table="dbo.Orders", properties=properties)

# Save as Delta
customer_df.write.format("delta").mode("overwrite").save("/mnt/cdc/orders")


# COMMAND ----------

jdbc_url = "jdbc:sqlserver://localhost.database.windows.net:1433;database=management"
properties = {
    "user": "user-name",
    "password": "*****",
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}

# Load Customer table
customer_df = spark.read.jdbc(url=jdbc_url, table="dbo.product", properties=properties)

# Save as Delta
customer_df.write.format("delta").mode("overwrite").save("/mnt/cdc/product")


# COMMAND ----------

jdbc_url = "jdbc:sqlserver://localhost.database.windows.net:1433;database=management"
properties = {
    "user": "user-name",
    "password": "******",
    "driver": "com.microsoft.sqlserver.jdbc.SQLServerDriver"
}

# Load Customer table
customer_df = spark.read.jdbc(url=jdbc_url, table="dbo.Inventory", properties=properties)

# Save as Delta
customer_df.write.format("delta").mode("overwrite").save("/mnt/cdc/Inventory")


# COMMAND ----------

# Mount only if not already mounted
mount_point = "/mnt/cdc"

if not any(mount.mountPoint == mount_point for mount in dbutils.fs.mounts()):
    dbutils.fs.mount(
        source="wasbs://"container-name"@"storage-account-name".blob.core.windows.net/",
        mount_point=mount_point,
        extra_configs={"fs.azure.account.key."storage-account-name".blob.core.windows.net": "Access-key"}
    )
else:
    print(f"{mount_point} is already mounted.")