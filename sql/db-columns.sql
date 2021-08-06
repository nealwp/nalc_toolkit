select pbc_tnam + "." + pbc_cnam
from pbcatcol
where pbc_tnam like '%!VAR1!%'
or pbc_cnam like '%!VAR1!%'
order by pbc_tnam, pbc_cnam
go

