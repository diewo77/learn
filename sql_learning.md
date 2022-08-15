### Text Manipulation
```SQL
SELECT left(fn, 1) as Initial, right([zip-postcode], 3) as PostWalk,
substring(town, 4, 5) as Extract, charindex('@', email) as Place,
substring(email, 1, charindex('@', email) - 1) as PostBox
```

a savoir que substring prend 3 **parametres**: la **colonne**, l'**index de debut** et le **nombre de caracteres à prendre**

```SQL
SELECT mid(email, INSTR(email, '@') - 1) as PostBox, * FROM table;mark
```


### Date func

```SQL
SELECT
month(dateenter) as Month,
year(dateenter) as Year,
day(dateenter) as Day,
/*
hour(dateenter) as Hour,
minute(dateenter) as Minute,
second(dateenter) as Minute
*/
datepart(hh,dateenter) as 'Hour',
datepart(mi,dateenter) as 'Minutes',
datepart(ss,dateenter) as 'Seconds',
FROM datatable
```

les fonctions hour / minute / second marche sur access mais sql server utilise **datepart** 

#### Caculate age
```SQL
SELECT INT((DATE() - day_birth) / 365.25) as age
```

utiliser **getDate()** pour SQL Server, aussi floor a la place de INT

```SQL
SELECT floor( convert(float, (getDate() - day_birth)) / 365.25) as age
```

### Concat
on peut concatener les champ de meme type string

```SQL
SELECT str + ' ' + str2 as conc
```


