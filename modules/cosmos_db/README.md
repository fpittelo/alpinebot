Azure Cosmos DB Terraform Module
This Terraform module deploys an Azure Cosmos DB account with optional databases and containers. It supports provisioning Cosmos DB accounts with various APIs (SQL, MongoDB, Cassandra, Gremlin, Table) and allows configuring global distribution, consistency levels, and other settings.

Features
Create an Azure Cosmos DB account with a specified API
Optionally create databases and containers
Configure global distribution with multiple write regions
Set consistency levels: Eventual, Consistent Prefix, Session, Bounded Staleness, Strong
Configure throughput: autoscale or manual
Virtual Network (VNet) integration with IP rules and VNet service endpoints
Enable or disable features like multi-master, analytical storage, etc.
Usage
hcl
Copy code
module "cosmosdb" {
  source = "github.com/fpittelo/alpinebot" # Replace with your module source

  name                = az_db_name
  resource_group_name = az_rg_name
  location            = az_location
  offer_type          = "Standard"
  kind                = "MongoDB"

  tags = var.tags
}

Module Inputs
Name	Description	Type	Default	Required
name	The name of the Cosmos DB account.	string	n/a	yes
resource_group_name	The name of the resource group in which to create the Cosmos DB account.	string	n/a	yes
location	The Azure region where the Cosmos DB account should be created.	string	n/a	yes
offer_type	The offer type for the Cosmos DB account (e.g., Standard).	string	"Standard"	no
kind	The kind of Cosmos DB account (e.g., GlobalDocumentDB, MongoDB).	string	"GlobalDocumentDB"	no
consistency_policy	Consistency policy settings for the Cosmos DB account.	object	{}	no
geo_locations	A list of geo-locations where the Cosmos DB account will be replicated.	list(object)	[]	no
enable_multiple_write_locations	Enables multi-master support for the Cosmos DB account.	bool	false	no
databases	A list of databases to create within the Cosmos DB account.	list(object)	[]	no
tags	A mapping of tags to assign to the resource.	map(string)	{}	no
Consistency Policy Object
The consistency_policy object accepts the following keys:

consistency_level - (Required) Consistency level of the Cosmos DB account.
max_interval_in_seconds - (Optional) The maximum lag time (in seconds) for Bounded Staleness.
max_staleness_prefix - (Optional) The maximum lag of operations (in terms of number of operations) for Bounded Staleness.
Geo Locations Object
Each object in the geo_locations list should have:

location - (Required) The Azure region to replicate to.
failover_priority - (Required) The failover priority for the region. 0 is the highest priority.
Databases Object
Each object in the databases list can have:

name - (Required) Name of the database.
throughput - (Optional) Throughput for the database (RU/s).
containers - (Optional) A list of containers within the database.
Containers Object
Each object in the containers list can have:

name - (Required) Name of the container.
partition_key_path - (Required) The path for the partition key.
throughput - (Optional) Throughput for the container (RU/s).
Module Outputs
Name	Description
id	The ID of the Cosmos DB account.
endpoint	The endpoint URL of the Cosmos DB account.
primary_master_key	The primary master key for the Cosmos DB account.
secondary_master_key	The secondary master key for the Cosmos DB account.
connection_strings	A list of connection strings for the Cosmos DB account.
databases	A list of databases created with their IDs.
Requirements
Name	Version
terraform	>= 0.12
azurerm	>= 3.0
Providers
Name	Version
azurerm	>= 3.0
Resources
azurerm_cosmosdb_account - Creates the Cosmos DB account.
azurerm_cosmosdb_sql_database - (Optional) Creates SQL databases.
azurerm_cosmosdb_sql_container - (Optional) Creates SQL containers.
Other resources depending on the API kind (e.g., MongoDB databases and collections).
How to Use This Module
Include the Module

Add the module to your Terraform configuration:

hcl
Copy code
module "cosmosdb" {
  source = "github.com/fpittelo/alpinebot" # Replace with your module source
  # ... (other parameters)
}
Provide Necessary Inputs

Configure the required and optional parameters to customize the Cosmos DB account as needed.

Initialize the Module

Run terraform init to download the module and provider plugins.

Plan and Apply

Execute terraform plan to see the changes that will be made, and terraform apply to create the resources.

License
This project is licensed under the MIT License - see the LICENSE file for details.

Author
Fred
Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements.

Acknowledgments