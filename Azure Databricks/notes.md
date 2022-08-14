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