declare @ddsn    varchar(9)
declare @org_cd   char(3)
declare @ddsn_suf char(1)

select @ddsn = '!VAR1!'
select @org_cd = '!VAR2!'

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
		set org_cd = @org_cd
		where ddsn = @ddsn
		and ddsn_suf = @ddsn_suf

		print "Updated dr09 org_cd to %1! for ddsn %2!%3!.", @org_cd, @ddsn, @ddsn_suf
		goto dr06
	end
else
	begin
		goto dr14
	end

dr06:

if exists (select 1 from dr06_iou where ddsn = @ddsn)
	begin
		update dr06_iou
		set org_cd = @org_cd
		where ddsn = @ddsn

		print "Updated dr06 org_cd to %1! for ddsn %2!.", @org_cd, @ddsn
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
		set org_cd = @org_cd
		where ddsn = @ddsn
		and ddsn_suf = @ddsn_suf

		print "Updated dr14 org_cd to %1! for ddsn %2!%3!.", @org_cd, @ddsn, @ddsn_suf
		goto done
	end
else
	begin
		print "No record of ddsn %1!%2! on dr09/dr14.", @ddsn, @ddsn_suf
		goto done
	end

done:

go
