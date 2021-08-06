declare @ddsn		varchar(9)
declare @ddsn_suf	char(1)
declare @pod_qty    int
select @ddsn = '!VAR1!'

if char_length(@ddsn) = 9
	begin
		select @ddsn_suf = right(@ddsn, 1)
		select @ddsn = left(@ddsn, 8)
		goto handle_suffix_child
	end
else
	begin
		select @ddsn_suf = ''
	end

if exists (select 1 from dr09_requisition where ddsn = @ddsn)
	begin
		if (select count(ddsn) from dr09_requisition where ddsn = @ddsn) > 1
			begin
				goto handle_suffix_mother
			end
		else
			begin
				if (select lsc from dr09_requisition where ddsn = @ddsn) = 'CANCL'
					begin
						update dr09_requisition
						set cncl_qty = 0
						where ddsn = @ddsn
					end

				select @pod_qty = (
					select ord_qty - cncl_qty 
					from dr09_requisition 
					where ddsn = @ddsn
					)

				update dr09_requisition
				set lsc = 'COMPL', pod_qty = @pod_qty, issip_qty = 0, rob_qty = 0
				where ddsn = @ddsn

				print "Updated dr09 lsc to COMPL, pod_qty to %1! for ddsn %2!", @pod_qty, @ddsn	
				goto done
			end
	end
else
	begin
		print "ddsn %1! not found on dr09!.", @ddsn
		goto done
	end

handle_suffix_child:

if exists (select 1 from dr09_requisition where ddsn = @ddsn and ddsn_suf = '')
	begin
		if (select lsc from dr09_requisition where ddsn = @ddsn and ddsn_suf = '') = 'CANCL'
        	begin
            	update dr09_requisition
                set cncl_qty = 0
                where ddsn = @ddsn
				and ddsn_suf = @ddsn_suf
			end

		select @pod_qty = (
        	select ord_qty - cncl_qty
            from dr09_requisition
            where ddsn = @ddsn
			and ddsn_suf = @ddsn_suf
            )

		update dr09_requisition
        set lsc = 'COMPL', pod_qty = @pod_qty, issip_qty = 0, rob_qty = 0
        where ddsn = @ddsn
		and ddsn_suf = @ddsn_suf

        print "Updated dr09 lsc to COMPL, pod_qty to %1! for ddsn %2!%3!", @pod_qty, @ddsn, @ddsn_suf
        goto done
	end
else
	begin
		print "ddsn %1%2 not found on dr09!", @ddsn, @ddsn_suf
		goto done
	end


handle_suffix_mother:

declare @suffix_qty	int
declare @ord_qty	int
declare @cnx_qty	int
declare @lsc_dttm	datetime

select @suffix_qty = (select sum(ord_qty) from dr09_requisition where ddsn = @ddsn and ddsn_suf <> '')
select @ord_qty = (select ord_qty from dr09_requisition where ddsn = @ddsn and ddsn_suf = '')
select @pod_qty = (select sum(pod_qty) from dr09_requisition where ddsn = @ddsn and ddsn_suf <> '')
select @cnx_qty = (select sum(cncl_qty) from dr09_requisition where ddsn = @ddsn and ddsn_suf <> '')
select @lsc_dttm = (select max(lsc_dttm) from dr09_requisition where ddsn = @ddsn)


if (@suffix_qty <> @ord_qty)
	begin
		print "Invalid suffix quantities! Please review and correct manually."
		goto done
	end

if (select count(ddsn) from dr09_requisition where ddsn = @ddsn and ddsn_suf <> '' and lsc not in ('COMPL','CANCL')) > 0
	begin
		print "Suffix records are still outstanding for ddsn %1!. Suffixed records must be COMPL or CANCL before closing mother doc.", @ddsn
		goto done
	end

if (select count(ddsn) from dr09_requisition where ddsn = @ddsn and lsc = 'CANCL') > 0
	begin
		update dr09_requisition
		set lsc = 'XMSUF', 
			lsc_dttm = @lsc_dttm,
			pod_qty = @pod_qty,
			cncl_qty = @cnx_qty,
			rob_qty = 0
		where ddsn = @ddsn
		and ddsn_suf = ''

		print "Updated dr09 lsc to XMSUF, pod_qty to %1!, cncl_qty to %2!, lsc_dttm to %3! for ddsn %4!.", @pod_qty, @cnx_qty, @lsc_dttm, @ddsn
		goto done
	end
else
	begin
		update dr09_requisition
		set lsc = 'CMSUF',
			lsc_dttm = @lsc_dttm,
			pod_qty = @pod_qty,
			cncl_qty = @cnx_qty,
			rob_qty = 0
		where ddsn = @ddsn
		and ddsn_suf = ''
		
		print "Updated dr09 lsc to CMSUF, pod_qty to %1!, cncl_qty to %2!, lsc_dttm to %3! for ddsn %4!.", @pod_qty, @cnx_qty, @lsc_dttm, @ddsn
		goto done
	end

done:

go
