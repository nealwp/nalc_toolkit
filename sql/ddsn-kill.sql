declare @ddsn 	 varchar(9)
declare @ddsn_suf char(1)

select @ddsn = '!VAR1!'

if char_length(@ddsn) = 9
	begin
    	select @ddsn_suf = right(@ddsn, 1)
        select @ddsn = left(@ddsn, 8)
    end
else
    begin
       select @ddsn_suf = ''
    end

ds03_check:
if exists (select 1 from ds03_item where cur_ti_ddsn = @ddsn or ti_ddsn = @ddsn)
	begin
		print " ds03 record exists for ddsn %1!. Req kill cancelled!", @ddsn
		goto done
	end

dm04_check:
if exists (select 1 from dm04_maf where cur_ti_ddsn = @ddsn or ti_ddsn = @ddsn)
	begin
		print " ddsn %1! is tied to an active maf. Req kill cancelled!", @ddsn
		goto done
	end

repairable_check:
if exists (select 1 from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf and mcc in ('H','E','X','D','Q','G'))
	begin
		print " ddsn %1! is repairable requisition. Req kill cancelled!", @ddsn
		goto done
	end

suffix_check:
if @ddsn_suf = '' and (select count(ddsn) from dr09_requisition where ddsn = @ddsn) > 1
	begin
		print " Cannot kill ddsn %1! while suffixed records exist. Req kill cancelled!", @ddsn
		goto done
	end

dr09:
if exists (select 1 from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf)
	begin
		delete from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf
		print " Deleted dr09 record for ddsn %1!%2!.", @ddsn, @ddsn_suf
		goto dr10
	end
else
	begin
		print " ddsn %1!%2! not found on dr09!", @ddsn, @ddsn_suf
		goto done
	end

dr10:
if exists (select 1 from dr10_stathistory where ddsn = @ddsn and ddsn_suf = @ddsn_suf)
	begin
		delete from dr10_stathistory where ddsn = @ddsn and ddsn_suf = @ddsn_suf
		print "Deleted dr10 records for ddsn %1!%2!.", @ddsn, @ddsn_suf
		goto done
	end

done:

go
