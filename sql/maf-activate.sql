declare @mcn	char(7)
select @mcn = '!VAR1!'

move_dm18:

if exists (select 1 from dm04_maf where mcn = @mcn)
	begin
		print ' dm04 record already exists for mcn %1!!', @mcn
		goto move_dm15
	end

if exists (select 1 from dm18_maf_hist where mcn = @mcn)
	begin
		print ' Re-activating mcn %1!...', @mcn
		
		insert into dm04_maf 
		(
			niin, 			mcn,			jcn,    		wrk_pri_cd,
			act_take_cd,   	mal_dscrptn_cd,	wh_disc_cd,    	ty_maint,
			pos_cd,    		sys_rsn,		sft_engr_serno, maint_act_sts,
			ei_cd,			td_cd,			td_basic_no,	td_kit_no,
			td_intrm_cd,	td_rev_ltr,		td_amend,		td_part_no,
			chk_test_fg,	cur_ti_ddsn,	cntl_mcn,    	eqp_sts_cd,
			fid_cd,    		inspt_jcn,		buno_serno,    	icrl_ovrd_fg,
			awp_loctn,    	ty_maf_cd,		wuc,    		wc_cd,
			tec,    		se_mtr,			org_cd,    		apprvl_fg,
			matl_delv_pt,   ti_ddsn,		cage_se_comp,   part_no,
			onsite_ndi_fg,  clsout_fg,		trblsh_fg,    	awp_clsout_fg,
			comp_rep_fg,   	inv_cd,			ovrd_td_fg,    	ti_maf_fg,
			maint_lv_cd,    itm_prc,		maint_act_dttm, init_dttm,
			maint_trans_cd, bcm_hist,		cannib_dttm,   	tot_awm_hrs,
			tot_emt_hrs,    tot_man_hrs,	cannib_ddsn,    del_ind,
			cage_eng_comp,  xref_ind
		)
		select
			niin,    		mcn,			jcn,    		wrk_pri_cd,
			act_take_cd,    mal_dscrptn_cd,	wh_disc_cd,    	ty_maint,
			pos_cd,    		sys_rsn,		sft_engr_serno, maint_act_sts,
			ei_cd,    		td_cd,			td_basic_no,    td_kit_no,
			td_intrm_cd,    td_rev_ltr,		td_amend,    	td_part_no,
			chk_test_fg,    cur_ti_ddsn,	cntl_mcn,    	eqp_sts_cd,
			fid_cd,    		inspt_jcn,		buno_serno,    	icrl_ovrd_fg,
			awp_loctn,    	ty_maf_cd,		wuc,    		wc_cd,
			tec,    		se_mtr,			org_cd,    		apprvl_fg,
			matl_delv_pt,   ti_ddsn,		cage_se_comp,   part_no,
			onsite_ndi_fg,  clsout_fg,		trblsh_fg,    	awp_clsout_fg,
			'Y',    		inv_cd,			ovrd_td_fg,    	ti_maf_fg,
			maint_lv_cd,    itm_prc,		maint_act_dttm, init_dttm,
			maint_trans_cd, bcm_hist,		cannib_dttm,    tot_awm_hrs,
			tot_emt_hrs,   	tot_man_hrs,	cannib_ddsn,    del_ind,
			cage_eng_comp,  xref_ind
		from dm18_maf_hist 
		where mcn = @mcn
		
		print ' dm18 record for mcn %1! moved to dm04.', @mcn
	end
else 
	begin
		print ' mcn %1! not found on dm18!', @mcn
		goto move_dm15
	end

move_dm15:

if exists (select 1 from dm01_fail_req where mcn = @mcn)
	begin
		print ' dm01 record already exists for mcn %1!!', @mcn
		goto move_dm16
	end

if exists (select 1 from dm15_fail_req_hist where mcn = @mcn)
	begin
		insert into dm01_fail_req 
		(
			mcn,    		act_take_cd,	ref_loc_use,    ddsn,
			awp_fg,    		ref_symb,		fail_part_fg,   fail_cage,
			fail_part_no,   mal_dscrptn_cd,	ty_itm_ind,    	matl_index,
			repl_reqd_fg,   ovrd_cgpn_fg,	ti_crit_fg,    	ti_maf_fg,
			proj_cd,    	scnd_adv_cd,	cannib_fg,    	actl_rcpt_dttm,
			fail_qty,    	xref_ind,		iss_pri_dsg,    ord_dttm,
			ti_mcn,    		reqd_cage,		reqd_part_no,   ovrd_reqd_cgpn_fg,
			end_itm_rep_fg, reord_xref_ind,	ord_otcpn_fg
		)
		select
			mcn,    		act_take_cd,	ref_loc_use,    ddsn,
			awp_fg,    		ref_symb,		fail_part_fg,   fail_cage,
			fail_part_no,   mal_dscrptn_cd,	ty_itm_ind,    	matl_index,
			repl_reqd_fg,   ovrd_cgpn_fg,	ti_crit_fg,    	ti_maf_fg,
			proj_cd,    	scnd_adv_cd,	cannib_fg,    	actl_rcpt_dttm,
			fail_qty,    	xref_ind,		iss_pri_dsg,    ord_dttm,
			ti_mcn,    		reqd_cage,		reqd_part_no,   ovrd_reqd_cgpn_fg,
			end_itm_rep_fg, reord_xref_ind,	ord_otcpn_fg
		from dm15_fail_req_hist 
		where mcn = @mcn
		
		delete from dm15_fail_req_hist where mcn = @mcn
		
		print ' dm15 records moved to dm01 for mcn %1!.', @mcn
	end
else 
	begin
		print ' mcn %1! not found on dm15!', @mcn
		goto move_dm16
	end

move_dm16:

if exists (select 1 from dm02_hours where mcn = @mcn)
	begin
		print ' dm02 record for mcn %1! already exists!', @mcn
		goto move_dm17
	end

if exists (select 1 from dm16_hours_hist where mcn = @mcn)
	begin
		insert into dm02_hours 
		(
			mcn,    last_nm,		toolbx_no,  init_3,
			shift,	create_dttm,	hrs_wrk
		)
		select
			mcn,    last_nm,		toolbx_no,  init_3,
			shift,	create_dttm,	hrs_wrk
		from dm16_hours_hist 
		where mcn = @mcn
		
		delete from dm16_hours_hist where mcn = @mcn
		
		print ' dm16 records moved to dm02 for mcn %1!.', @mcn
	end
else
	begin
		print ' mcn %1! not found on dm16!', @mcn
		goto move_dm17
	end

move_dm17:

if exists (select 1 from dm03_jshistory where mcn = @mcn)
	begin
		print 'dm03 record for mcn %1! already exists!', @mcn
		goto move_dm19
	end

if exists (select 1 from dm17_jshist_hist where mcn = @mcn)
	begin
		insert into dm03_jshistory 
		(
			mcn, maint_act_sts, maint_act_dttm
		)
		select mcn, maint_act_sts, maint_act_dttm
		from dm17_jshist_hist 
		where mcn = @mcn
		
		delete from dm17_jshist_hist where mcn = @mcn
		
		print 'dm17 records for mcn %1! moved to dm03.', @mcn
	end
else
	begin
		print ' mcn %1! not found on dm17!', @mcn
		goto move_dm19
	end

move_dm19:

if exists (select 1 from dm06_maf_correct where mcn = @mcn)
	begin
		print 'dm06 record for mcn %1! already exists!', @mcn
		goto move_dm20
	end

if exists (select 1 from dm19_correct_hist where mcn = @mcn)
	begin
		insert into dm06_maf_correct 
		(
			mcn,    			logs_reqd_fg,		qa_cntl_lv,    	corr_act,
			wkr_sig,    		logs_rec_sig,		maint_cntl_sig, qa_cdi_sig,
			supr_sig,    	   	data_sig,			pc_sig,    		apprv_dttm,
			supr_signo_dttm,   	pc_signo_dttm
		)
		select
			mcn,			  	logs_reqd_fg,		qa_cntl_lv,	    corr_act,
			wkr_sig,		  	logs_rec_sig,		maint_cntl_sig, qa_cdi_sig,
			supr_sig,		  	data_sig,			pc_sig,		    apprv_dttm,
			supr_signo_dttm,	pc_signo_dttm
		from dm19_correct_hist 
		where mcn = @mcn
		
		delete from dm19_correct_hist where mcn = @mcn
		
		print ' dm19 record for mcn %1! moved to dm06.', @mcn
	end
else
	begin
		print 'mcn %1! not found on dm19!', @mcn
		goto move_dm20
	end

move_dm20:

if exists (select 1 from dm07_maf_discrep where mcn = @mcn)
	begin
		print 'dm07 record for mcn %1! already exists!', @mcn
		goto move_dm21
	end
	
if exists (select 1 from dm20_discrep_hist where mcn = @mcn)
	begin
		insert into dm07_maf_discrep 
		(
			mcn, dscrp,	dscrp_2, dscrp_3, dscrp_4, dscrp_5,	dscrp_6, int_by
		)
		select
			mcn, dscrp,	dscrp_2, dscrp_3, dscrp_4, dscrp_5,	dscrp_6, int_by
		from dm20_discrep_hist 
		where dm20_discrep_hist.mcn = @mcn
		
		delete from dm20_discrep_hist where mcn = @mcn
		
		print ' dm20 records for mcn %1! moved to dm07.', @mcn
	end
else
	begin
		print 'mcn %1! not found on dm20!'
		goto move_dm21
	end

move_dm21:

if exists (select 1 from dm09_removed where mcn = @mcn)
	begin
		print 'dm09 record already exists for mcn %1!!', @mcn
		goto move_dm22
	end

if exists (select 1 from dm21_removed_hist where mcn = @mcn)
	begin
		insert into dm09_removed 
		(
			mcn,    	   e_part_no,		e_serno,    	e_cage,
			e_tm_cy,       e_tm_cy_1,		e_tm_cy_2,    	g_cage,
			g_part_no,     g_serno,			g_tm_cy,    	g_tm_cy_1,
			g_tm_cy_2,     ref_loc_use,		itm_cfg_fg,     repl_reqd_fg,
			ovrd_cfgmt_fg, ovrd_cpnrm_fg,	ovrd_otcpn_fg,  ord_more_part_fg,
			icrl_ovrd_fg,  ovrd_cpni_fg,	ovrd_eqpi_fg,   rep_mcn,
			rem_itm_dttm
		)
		select
			mcn,    		e_part_no,		e_serno,    	e_cage,
			e_tm_cy,    	e_tm_cy_1,		e_tm_cy_2,    	g_cage,
			g_part_no,    	g_serno,		g_tm_cy,    	g_tm_cy_1,
			g_tm_cy_2,    	ref_loc_use,	itm_cfg_fg,   	repl_reqd_fg,
			ovrd_cfgmt_fg,	ovrd_cpnrm_fg,	ovrd_otcpn_fg,  ord_more_part_fg,
			icrl_ovrd_fg,   ovrd_cpni_fg,	ovrd_eqpi_fg,   rep_mcn,
			rem_itm_dttm
		from dm21_removed_hist 
		where mcn = @mcn
		
		delete from dm21_removed_hist where mcn = @mcn
		
		print ' dm21 record for mcn %1! moved to dm09.', @mcn
	end
else
	begin
		print 'mcn %1! not found on dm21!', @mcn
		goto move_dm22
	end

move_dm22:

if exists (select 1 from dm12_maf_note where mcn = @mcn)
	begin
		print ' dm12 record for mcn %1! already exists!', @mcn
		goto move_dm23
	end

if exists (select 1 from dm22_note_hist where mcn = @mcn)
	begin
		insert into dm12_maf_note 
		(
			mcn, orignr, subj, maf_note, note_dttm
		)
		select mcn, orignr, subj, maf_note, note_dttm
		from dm22_note_hist 
		where mcn = @mcn
		
		delete from dm22_note_hist where mcn = @mcn
		
		print ' dm22 record for mcn %1! moved to dm12.', @mcn
	end
else
	begin
		print 'mcn %1! not found on dm22!', @mcn
		goto move_dm23
	end

move_dm23:

if exists (select 1 from dm14_in_proc_inspt where mcn = @mcn)
    begin
        print 'dm14 record for mcn %1! already exists!', @mcn
        goto done
    end

if exists (select 1 from dm23_in_proc_hist where mcn = @mcn)
    begin
        insert into dm14_in_proc_inspt
        (
			 init_dttm, inspt_by, inspt_dscrptn, inspt_dttm, inspt_title, mcn, step
        )
        select init_dttm, inspt_by, inspt_dscrptn, inspt_dttm, inspt_title, mcn, step
        from dm23_in_proc_hist
        where mcn = @mcn

        delete from dm23_in_proc_hist where mcn = @mcn

        print ' dm23 records for mcn %1! moved to dm14.', @mcn
    end
else
    begin
        print 'mcn %1! not found on dm23!', @mcn
        goto done
    end

done:

if exists (
		select 1 
		from dm04_maf dm04 
		join dm18_maf_hist dm18 
		on dm04.mcn = dm18.mcn 
		where dm04.mcn = @mcn
	)
	begin
		delete from dm18_maf_hist where mcn = @mcn
		print ' mcn %1! has been moved to active maf tables.', @mcn
	end
	
go

