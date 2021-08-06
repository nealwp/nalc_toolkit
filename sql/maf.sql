declare @mcn	char(7)
declare @eqlln	char(80)

select @eqlln = replicate("__", 40)
select @mcn = '!VAR1!'

if exists (select 1 from dm04_maf where mcn = @mcn)
	begin
		print "%1!", @eqlln
		print ""
		print "dm04_maf:"
		print ""
		select mcn, jcn, cntl_mcn, ti_ddsn, cur_ti_ddsn, niin, maint_act_sts, maint_act_dttm
		from dm04_maf 
		where mcn = @mcn
		print "" 
		print ""

		select mcn, org_cd, wc_cd, ty_maf_cd, maint_trans_cd, act_take_cd, buno_serno, wuc, tec
		from dm04_maf 
		where mcn = @mcn
		print ""
		print ""

		select mcn, init_dttm, tot_awm_hrs, tot_emt_hrs, tot_man_hrs
 		from dm04_maf
		where mcn = @mcn
		print "%1!", @eqlln
		print ""
		print "dm09_removed:"
		print ""
		select mcn, e_cage, e_part_no, e_serno, e_tm_cy
		from dm09_removed
		where mcn = @mcn
		print ""
		print ""

		select mcn, g_cage, g_part_no, g_serno, g_tm_cy
		from dm09_removed
		where mcn = @mcn
		print "%1!", @eqlln

		print ""
		print "dm03_jshistory:"
		print ""
		
		select * from dm03_jshistory where mcn = @mcn order by maint_act_dttm desc	
		print "%1!", @eqlln
		print ""

		print "dm06_maf_correct:"
		print ""
		
		select mcn, wkr_sig, qa_cdi_sig, supr_sig, pc_sig, logs_rec_sig, data_sig
		from dm06_maf_correct
		where mcn = @mcn
		print ""
		print ""

		select left(corr_act, 100) as corrective_action
		from dm06_maf_correct
		where mcn = @mcn
       	print ""
		print ""
			
		select apprv_dttm
		from dm06_maf_correct
		where mcn = @mcn
		print "%1!", @eqlln
		print ""

		print "dm01_fail_req"
		print ""

		select dm01.ddsn, dr09.cur_niin, dm01.fail_qty, dm01.xref_ind, dm01.ord_dttm, dm01.actl_rcpt_dttm, dr09.lsc, dr09.lsc_dttm
		from dm01_fail_req dm01
		left join dr09_requisition dr09
			on dm01.ddsn = dr09.ddsn
		where dm01.mcn = @mcn
		and dr09.ddsn_suf = ''
		print "%1!", @eqlln
        print ""
	end
else if exists (select 1 from dm18_maf_hist where mcn = @mcn)
	begin
		print "%1!", @eqlln
        print ""
        print "dm18_maf_hist:"
        print ""
        select mcn, jcn, cntl_mcn, ti_ddsn, cur_ti_ddsn, niin, maint_act_sts, maint_act_dttm
        from dm18_maf_hist
        where mcn = @mcn
        print ""
        print ""

        select mcn, org_cd, wc_cd, ty_maf_cd, maint_trans_cd, act_take_cd, buno_serno, wuc, tec
        from dm18_maf_hist
        where mcn = @mcn
        print ""
        print ""

        select mcn, init_dttm, tot_awm_hrs, tot_emt_hrs, tot_man_hrs
        from dm18_maf_hist
        where mcn = @mcn
        print "%1!", @eqlln
        print ""
        print "dm21_removed_hist:"
        print ""
        select mcn, e_cage, e_part_no, e_serno, e_tm_cy
        from dm21_removed_hist
        where mcn = @mcn
        print ""
        print ""

        select mcn, g_cage, g_part_no, g_serno, g_tm_cy
        from dm21_removed_hist
        where mcn = @mcn
        print "%1!", @eqlln

        print ""
        print "dm17_jshist_hist:"
        print ""

		select * from dm17_jshist_hist where mcn = @mcn order by maint_act_dttm desc
        print "%1!", @eqlln
        print ""

        print "dm19_correct_hist:"
        print ""

        select mcn, wkr_sig, qa_cdi_sig, supr_sig, pc_sig, logs_rec_sig, data_sig
        from dm19_correct_hist
        where mcn = @mcn
        print ""
        print ""

        select left(corr_act, 100) as corrective_action
        from dm19_correct_hist
        where mcn = @mcn
        print ""
        print ""

        select apprv_dttm
        from dm19_correct_hist
        where mcn = @mcn
        print "%1!", @eqlln
        print ""

        print "dm15_fail_req_hist"
        print ""

        select dm15.ddsn, dr14.cur_niin, dm15.fail_qty, dm15.xref_ind, dm15.ord_dttm, dm15.actl_rcpt_dttm, dr14.lsc, dr14.lsc_dttm
        from dm15_fail_req_hist dm15
        left join dr14_rqn_hist dr14
            on dm15.ddsn = dr14.ddsn
        where dm15.mcn = @mcn
        and dr14.ddsn_suf = ''
        print "%1!", @eqlln
        print ""

	end
else
	begin
		print "mcn %1! not found on dm04 or dm18.", @mcn
	end

go
