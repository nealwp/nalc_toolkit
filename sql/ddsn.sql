declare @ddsn char(8)
select @ddsn = '!VAR1!'


if exists (select 1 from dr09_requisition where ddsn = @ddsn)
	begin
		print "dr09:"
		print ""
		select ddsn, ddsn_suf, cur_niin, ord_qty, issip_qty, rob_qty, cncl_qty, pod_qty, lsc, lsc_dttm
		from dr09_requisition
		where ddsn = @ddsn
		print ""
	
		select ddsn, cog, mcc, wuc, tec, buno_serno
		from dr09_requisition
		where ddsn = @ddsn
		print ""
	
		select ddsn, ddsn_suf,  org_cd, wc_cd, sup_sts_cd, rt_id_from, sts_trans_dttm 
		from dr09_requisition
		where ddsn = @ddsn
		print ""
		
		if (select max(mcc) from dr09_requisition where ddsn = @ddsn) in ('H','E','X','D','Q','G')
			begin
				select ddsn, cur_niin, mcn, jcn, cur_mcn, rep_mcn
				from dr09_requisition
				where ddsn = @ddsn
				print ""
			end

		print "dr07:"
		print ""
		select ddsn, lsc, lsc_dttm, ddsn_suf
		from dr07_lschistory
		where ddsn = @ddsn
		order by ddsn_suf, lsc_dttm
		print ""

		print "dr10:"
		print ""
		select ddsn, ddsn_suf, rob_qty, cncl_qty, pod_qty, sts_doc_id, sup_sts_cd, sts_trans_dttm
		from dr10_stathistory
		where ddsn = @ddsn
		order by ddsn_suf, sts_trans_dttm desc
	end
else
	begin
	print "No record for %1! on dr09.", @ddsn
	end  

if exists (select 1 from dr14_rqn_hist where ddsn = @ddsn)
        begin
        print "dr14:"
        print ""
        select ddsn, ddsn_suf, ord_qty, issip_qty, rob_qty, cncl_qty, pod_qty, lsc, lsc_dttm
        from dr14_rqn_hist
        where ddsn = @ddsn
        print ""

		select ddsn, cog, mcc, wuc, tec, buno_serno
	    from dr14_rqn_hist
    	where ddsn = @ddsn
    	print ""

    	select ddsn, org_cd, wc_cd, sup_sts_cd, rt_id_from, sts_trans_dttm
    	from dr14_rqn_hist
    	where ddsn = @ddsn
    	print ""


        if (select max(mcc) from dr14_rqn_hist where ddsn = @ddsn) in ('H','E','X','D','Q','G')
                begin
                select ddsn, cur_niin, mcn, jcn, cur_mcn, rep_mcn
                from dr14_rqn_hist
                where ddsn = @ddsn
                print ""
                end
        end
else
        begin
        print "No record for %1! on dr14.", @ddsn
        end

go
