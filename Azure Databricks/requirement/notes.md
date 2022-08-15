# Spark

- Easier then hadoop
- faster
- In memory proicesseing engine
- Distributed computing plateform
- unified engine which supports **SQL**, streaming, ML and graph processing

![](2022-08-10-11-06-47.png)

# Databricks
creer par la société de Spark pour facilité l'intégration et l'utilisation de Spark

![](2022-08-10-11-14-16.png)

Aussi il faut savoir que Databricks est disponible dans toute les plateforme:
- AWS
- Azure
- Google Cloud

L'intégration sur Azure est plus importante que sur les autres service ( It's a first party service on azure )

![](2022-08-10-14-14-54.png)

## Azure Databricks Architectures

![](2022-08-11-14-02-30.png)

![](2022-08-11-14-30-33.png)

# Cluster configuration

## Cluster mode

![](2022-08-13-12-01-38.png)

## Datavricks rutime

![](2022-08-13-12-02-23.png)

## Auto termination 

![](2022-08-13-12-02-53.png)

## Auto scalling

![](2022-08-13-12-04-33.png)

## Cluster VM Type / Size

![](2022-08-13-12-03-55.png)

## Cluster pool

![](2022-08-13-12-31-30.png)

Pour la minimum IDLE meme si on spécifie l'**auto termination** elle continuera à tourner et à a consommer des **DBU**

# Databricks Notebooks
Dans cet partie on va voir les differente section 
- What's a Notebook
- Creating a Notebook
- Magic commands
- Databricks utilities

## Magic commands
- %sql pour executer du sql 
- %scala pour faire du scala
- %md pour utiliser les markdown
- %fs pour utiliser le **File system**; par exemple ls pour afficher les listes dbfs
- %sh pour executer des commandes shell: par exmple **ps** pour lister les process en cours

## Databricks utilities
- file system utilities: access Databricks file system
- Notebook Workflow utilities: appeler un notebook depuis un autre et les enchainer
- Widget utilities: gives more access for example a data factory pipeline parameters to the notebook
- Secrets utilities: access secret values 
- Library utilities: pour installer des package dans le scope du notebook ( deprecated on utilise a ça place %pip )

### Utiliser les enfants et les executer dans le notebook principale

```python
dbutils.widgets.text('input', "Empty", "Send the parameter value")
input_val = dbutils.widgets.get('input')
print(input_val)
```
- sans oublier d'envoyer le code de exit sinon le programme continue a tourner en attendant le timeout

```python
dbutils.notebook.exit(100)
```

- et dans le fichier principale il faudra lancer 

```python
dbutils.notebook.run('./databricks_child', 10, {'input': "Called from main notebook"})
```
- On a envoyer la variable input qui sera utiliser dans le widget text 

- On peut installer des modules avec la commande ```%pip install pandas```

# Databrick mount
![](2022-08-14-16-32-32.png)

## Databricks file system

![](2022-08-14-16-33-55.png)

### Benefits
- Access data without requiring credentials
- Access files using file semantics rather than storage URLs (e.g. /mnt/storage1)
- Stores files to object storage (e.g. Azure Blob), so you get all the benefits from Azure
- the defaut DBFS is called root 

### Mounting Azure Storage
- Create Azure Storage Account (Data Lake Gen2)
- Create Azure service principal
- Provide required access to the service principal
- Create the mount using the service principal

### Creation de datalake storage Gen2
**Il ne faut pas oublier d'activer data hierarchie sinon on aura la Gen1**

Aprés cela on enregistre l'application dans Azure active directory

Aprés on va sur *Certificats & secrets* 
- secret value: cEW8Q~gOONE4KlhzHWpuGpwtHh9AXQHrbPOocb2C

Aprés on va sur *acess control* et on donne un role pour le storage dans le service app précédament creer 
- That means is that the service principle that we've created now has access to the storage account

![](2022-08-14-23-40-43.png)
![](2022-08-14-23-41-14.png)
![](2022-08-14-23-41-30.png)


````
ID d'application (client)
:
393e8c45-f619-4af6-bf72-fc4cc0dae1ce
ID de l'objet
:
36154a39-e2f1-4f3e-bc9a-5b0725993d5d
ID de l'annuaire (locataire)
:
4ddd0abb-7ec4-43cd-a42e-aa709f0c7fde

````

## Mounting Azure data lake storage gen 2
un exemple que j'ai trouver en ligne https://www.mssqltips.com/sqlservertip/6931/mount-azure-data-lake-storage-gen2-account-databricks/

```python
storage_account_name = "foormula1dltaki"
client_id = "393e8c45-f619-4af6-bf72-fc4cc0dae1ce"
tenant_id = "4ddd0abb-7ec4-43cd-a42e-aa709f0c7fde"
client_secret = "cEW8Q~gOONE4KlhzHWpuGpwtHh9AXQHrbPOocb2C"
```

```python
configs = {"fs.azure.account.auth.type": "OAuth",
           "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
           "fs.azure.account.oauth2.client.id": f"{client_id}",
           "fs.azure.account.oauth2.client.secret": f"{client_secret}",
           "fs.azure.account.oauth2.client.endpoint": f"https://login.microsoftonline.com/{tenant_id}/oauth2/token"}
```
- on mount le container 
```python
container_name = "raw"
#dbutils.fs.unmount(f"/mnt/{storage_account_name}/{container_name}")
dbutils.fs.mount(
    source=f"abfss://{container_name}@{storage_account_name}.dfs.core.windows.net/",
    mount_point=f"/mnt/{storage_account_name}/{container_name}",
    extra_configs = configs)
```

- Creer la fonction pour mount azure data lake storage

```python
def mount_adls(container_name, storage_account_name, configs):
    dbutils.fs.mount(
        source=f"abfss://{container_name}@{storage_account_name}.dfs.core.windows.net/",
        mount_point=f"/mnt/{storage_account_name}/{container_name}",
        extra_configs = configs)
```


## Secret Scope

- Databricks backed Secret Scope
- Azure Key-vault backed Secret Scope: the recomended one because we can share the keys with multiple services not simply databricks
    - notebooks / jobs: Get secrets using dbutils.secrets.get 
    - Databricks secret scope: Create Databricks secret scope
    - Azure Key-Vault: Add secrets to the key vault

![](2022-08-15-00-29-58.png)

![](2022-08-15-00-30-39.png)
![](2022-08-15-00-30-47.png)

dans le lien de databricks on dois mettre secrets/createScope
![](2022-08-15-00-33-18.png)
Comme ç on accede à un menu qui nous permet d'ajouter les clé ajouté

![](2022-08-15-00-34-24.png)
pour les informations requise on les trouvent dans 
![](2022-08-15-00-34-58.png)
![](2022-08-15-00-35-13.png)

vault uri représente DNS Name

à la plac eon aura ça: 
```python
storage_account_name = "foormula1dltaki"
client_id = dbutils.secrets.get("formula1-scope", 'databricks-app-client-id')
tenant_id = dbutils.secrets.get("formula1-scope", 'databricks-app-tenant-id')
client_secret = dbutils.secrets.get("formula1-scope", 'databricks-app-client-secret')
```