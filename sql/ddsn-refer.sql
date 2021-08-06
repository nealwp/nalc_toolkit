declare @ddsn 		varchar(9)
declare @ddsn_suf 	char(1)

declare @issip_qty 	int
declare @canx_qty 	int
declare @rob_qty 	int
declare @pod_qty	int

declare @lsc	varchar(5)

select @ddsn = '!VAR1!'
select @ddsn_suf = ''

if char_length(@ddsn) = 9
	begin
		select @ddsn_suf = right(@ddsn, 1)
		select @ddsn = left(@ddsn, 8)
	end

dr09:

if exists (select 1 from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf)
	begin
		if (select count(ddsn) from dr09_requisition where ddsn = @ddsn) = 1
			begin
				goto not_suffixed
			end
		else
			begin
				goto is_suffixed
			end
	end
else if exists (select 1 from dr14_rqn_hist where ddsn = @ddsn)
    begin
        print " ddsn %1! must be moved from dr14 to dr09 before reinstating!", @ddsn
        goto done
    end
else
    begin
        print " ddsn %1! not found on dr09 or dr14.", @ddsn
    	goto done
	end

not_suffixed:

select 
	@issip_qty = issip_qty, 
	@canx_qty = cncl_qty, 
	@rob_qty = rob_qty,
	@pod_qty = pod_qty,
	@lsc = lsc
from dr09_requisition
where ddsn = @ddsn and ddsn_suf = @ddsn_suf

if @canx_qty > 0
	begin
        update dr09_requisition
        set lsc = 'REFER', cncl_qty = 0
        where ddsn = @ddsn and ddsn_suf = @ddsn_suf
        print " Updated dr09 lsc to REFER, cncl_qty to 0 for ddsn %1!.", @ddsn
		goto done
    end

if @issip_qty > 0
	begin
		update dr09_requisition
		set lsc = 'REFER', issip_qty = 0
		where ddsn = @ddsn and ddsn_suf = @ddsn_suf
		print "Updated dr09 lsc to REFER, issip_qty to 0 for ddsn %1!.", @ddsn
		goto done
	end

if @rob_qty > 0
	begin
		update dr09_requisition
		set lsc = 'REFER', rob_qty = 0
		where ddsn = @ddsn and ddsn_suf = @ddsn_suf
		print "Updated dr09 lsc to REFER, rob_qty to 0 for ddsn %1!.", @ddsn
		goto done
	end

if @pod_qty > 0
	begin
		update dr09_requisition
		set lsc = 'REFER', pod_qty = 0
		where ddsn = @ddsn and ddsn_suf = @ddsn_suf
		print "Updated dr09 lsc to REFER, pod_qty to 0 for ddsn %1!.", @ddsn
		goto done
	end


is_suffixed:

if (select cncl_qty from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf) > 0
	begin
		declare @canx_qty 	int
		select @canx_qty = (select cncl_qty from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf)

		update dr09_requisition
		set lsc = 'REFER', cncl_qty = 0
		where ddsn = @ddsn 
		and ddsn_suf = @ddsn_suf

		print " Updated dr09 lsc to REFER, cncl_qty to 0 for ddsn %1!%2!.", @ddsn, @ddsn_suf
				
		declare @new_canx_qty	int
		select @new_canx_qty = (select cncl_qty - @canx_qty from dr09_requisition where ddsn = @ddsn and ddsn_suf = '')

		update dr09_requisition
		set lsc = 'OSSUF', cncl_qty = @new_canx_qty
		where ddsn = @ddsn 
		and ddsn_suf = ''

		print " Updated dr09 lsc to OSSUF, cncl_qty to %1! for ddsn %2!.", @new_canx_qty, @ddsn
	end
else
	begin
		print " ddsn %1!%2! is not cancelled, exiting script...", @ddsn, @ddsn_suf
		goto done
	end
	
	
done:

go

