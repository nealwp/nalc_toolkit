declare @ddsn 	varchar(9)
declare @ddsn_suf char(1)
declare	@sts_cd	char(2)
declare @ri		char(3)
declare @sts_dt datetime

select @ddsn = '!VAR1!'
select @sts_cd = '!VAR2!'
select @ri = '!VAR3!'
select @sts_dt = '!VAR4!'

if char_length(@ddsn) = 9
    begin
        select @ddsn_suf = right(@ddsn, 1)
        select @ddsn = left(@ddsn, 8)
    end
else
    begin
       select @ddsn_suf = ''
    end


if exists (select 1 from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf)
	begin
		update dr09_requisition
		set sup_sts_cd = @sts_cd,
		rt_id_from = @ri,
		sts_trans_dttm = @sts_dt
		where ddsn = @ddsn
		and ddsn_suf = @ddsn_suf
	
		print "Updated dr09 sup_sts_cd to %1!, rt_id_from to %2!, and sts_trans_dttm to %3! for ddsn %4!%5!.", @sts_cd, @ri, @sts_dt, @ddsn, @ddsn_suf
	end
else
	begin
		print "ddsn %1! not found on dr09!", @ddsn
	end

done:

go
