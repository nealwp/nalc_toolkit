select convert(varchar, name) as name 
from sysobjects 
where type = 'P' 
and name like '%!VAR1!%'
order by name
go
