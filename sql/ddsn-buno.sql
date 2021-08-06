declare @ddsn    varchar(9)
declare @buno   varchar(16)
declare @ddsn_suf char(1)

select @ddsn = '!VAR1!'
select @buno = '!VAR2!'

if char_length(@ddsn) = 9
    begin
        select @ddsn_suf = right(@ddsn, 1)
        select @ddsn = left(@ddsn, 8)
    end
else
    begin
       select @ddsn_suf = ''
    end

dr09:
if exists (select 1 from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf)
	begin
		update dr09_requisition
		set buno_serno = @buno
		where ddsn = @ddsn
		and ddsn_suf = @ddsn_suf

		print "Updated dr09 buno to %1! for ddsn %2!%3!.", @buno, @ddsn, @ddsn_suf
		goto dm04
	end
else
	begin
		goto dr14
	end

dm04:

if exists (select 1 from dm04_maf where ti_ddsn = @ddsn)
	begin
		update dm04_maf
		set buno_serno = @buno
		where ti_ddsn = @ddsn

		print "Updated dm04 buno to %1! for ddsn %2!.", @buno, @ddsn
		goto done
	end
else
	begin
		goto done
	end

dr14:
if exists (select 1 from dr14_rqn_hist where ddsn = @ddsn and ddsn_suf = @ddsn_suf)
	begin
		update dr14_rqn_hist
		set buno_serno = @buno
		where ddsn = @ddsn
		and ddsn_suf = @ddsn_suf

		print "Updated dr14 buno_serno to %1! for ddsn %2!%3!.", @buno, @ddsn, @ddsn_suf
		goto dm18
	end
else
	begin
		print "No record of ddsn %1!%2! on dr09/dr14.", @ddsn, @ddsn_suf
		goto done
	end

dm18:
if exists (select 1 from dm18_maf_hist where ti_ddsn = @ddsn)
	begin
		update dm18_maf_hist
		set buno_serno = @buno
		where ti_ddsn = @ddsn

		print "Updated dm18 buno_serno to %1! for ti_ddsn %2!.", @buno, @ddsn
		goto done
	end
else
	begin
		goto done
	end

done:

go
