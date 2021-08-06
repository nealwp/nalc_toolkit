declare @ext_arg	varchar(6)
declare @di01_plus15	int

select @ext_arg = '!VAR1!'

select @di01_plus15 = count(*)
from di01_incoming_intfc
where rqst_dttm < dateadd(day, -15, getdate())
and prcsd_ind = 'Y'


if @ext_arg = 'fix'
	begin
		delete from di01_incoming_intfc
		where rqst_dttm < dateadd(day, -15, getdate())	
		and prcsd_ind = 'Y'
		print "%1! processed records deleted from di01.", @@rowcount
		goto done
	end
else if @ext_arg = 'report'
	begin
		select @di01_plus15 = count(*)
		from di01_incoming_intfc
		where rqst_dttm < dateadd(day, -15, getdate())
		and prcsd_ind = 'Y'
		
		print "Processed di01 records > 15 old:    %1!", @di01_plus15
		goto done
	end
else
    begin
        print "Invalid argument!"
        print "Options:"
        print "   db-purgeinterface report"
        print "   db-purgeinterface fix"
        goto done
    end


done:

go
