declare @ddsn char(8)

select @ddsn = '!VAR1!'

if exists (select 1 from dr09_requisition where ddsn = @ddsn)
	begin
		print "DDSN %1! is already active!", @ddsn
	end
else if exists (select 1 from dr14_rqn_hist where ddsn = @ddsn)
	begin
	insert into dr09_requisition (
 		 actl_rcpt_dttm, 		actl_rob_qty, 
 		 adv_cd, 			apl_ael,
		 awdue_dttm, 			awdue_ind,
		 buno_serno, 			cage,
		 cncl_qty, 			cog,
	 	 comp_serno, 			contg_cd,
		 contg_dop, 			contg_ship_dttm, 
		 cur_mcn, 			cur_niin,
		 cur_ti_ddsn, 			ddsn,
		 ddsn_suf, 			def_peb_phase_kit_ddsn,
		 def_peb_phase_kit_ddsn_suf, 	del_ind, 
		 demand_cd, 			dist_cd,
		 dscrp_qty, 			est_ship_dttm,
		 excl_eff_ind, 			fol_up_rmks,
		 fund_cd, 			invc_qty, 
		 iss_pri_dsg, 			issip_qty,
		 issuing_peb_org_cd, 		issuing_peb_wc_cd,
		 jcn, 				last_fol_up_dttm,
		 lis_fg, 			loctn,
		 lsc, 				lsc_dttm,
		 master_phase_kit_ddsn, 	match_set_ind,
		 mcc, 				mcn,
		 media_sts_cd, 			mode_of_ship,
		 mril_print_ind, 		oafm_ddsn,
		 ord_dttm, 			ord_qty,
		 org_cd, 			orig_niin,
		 orig_purp_cd, 			ovrd_cd,
		 part_no, 			peb_pkup_org,
		 pkup_id, 			pod_qty,
		 prim_niin, 			proj_cd,
		 purp_cd, 			ref_loc_use,
		 reord_ddsn, 			rep_mcn,
		 reqd_delv_dttm, 		requisitioner_outstanding_qty,
		 requisitioner_qty, 		requisitioner_ui,
		 rjon, 				rna_fg,
		 rob_dmg_ind, 			rob_qty,
		 rqn_act_dttm, 			rqn_id_cd,
		 rqn_svc_dsg, 			rqn_trans_dttm,
		 rt_id_from, 			rt_id_last_acty,
		 rt_id_to, 			scnd_adv_cd,
		 sgnl_cd, 			smic,
		 spcl_dscrp_fg, 		stk_fg,
		 sts_trans_dttm, 		sup_sts_cd,
		 supadd, 			td_comp_fg,
		 tec, 				tot_rob_qty,
		 ty_rqn_ind, 			unit_price,
		 wc_cd, 			wuc
		)
		select 
			 actl_rcpt_dttm,                actl_rob_qty,
			 adv_cd,                        apl_ael,
			 awdue_dttm,                    awdue_ind,
			 buno_serno,                    cage,
			 cncl_qty,                      cog,
			 comp_serno,                    contg_cd,
			 contg_dop,                     contg_ship_dttm,
			 cur_mcn,                       cur_niin,
			 cur_ti_ddsn,                   ddsn,
			 ddsn_suf,                      def_peb_phase_kit_ddsn,
			 def_peb_phase_kit_ddsn_suf,    del_ind,
			 demand_cd,                     dist_cd,
			 dscrp_qty,                     est_ship_dttm,
			 excl_eff_ind,                  fol_up_rmks,
			 fund_cd,                       invc_qty,
			 iss_pri_dsg,                   issip_qty,
			 issuing_peb_org_cd,            issuing_peb_wc_cd,
			 jcn,                           last_fol_up_dttm,
			 lis_fg,                        loctn,
			 lsc,                           lsc_dttm,
			 master_phase_kit_ddsn,         match_set_ind,
			 mcc,                           mcn,
			 media_sts_cd,                  mode_of_ship,
			 mril_print_ind,                oafm_ddsn,
			 ord_dttm,                      ord_qty,
			 org_cd,                        orig_niin,
			 orig_purp_cd,                  ovrd_cd,
			 part_no,                       peb_pkup_org,
			 pkup_id,                       pod_qty,
			 prim_niin,                     proj_cd,
			 purp_cd,                       ref_loc_use,
			 reord_ddsn,                    rep_mcn,
			 reqd_delv_dttm,                requisitioner_outstanding_qty,
			 requisitioner_qty,             requisitioner_ui,
			 rjon,                          rna_fg,
			 rob_dmg_ind,                   rob_qty,
			 rqn_act_dttm,                  rqn_id_cd,
			 rqn_svc_dsg,                   rqn_trans_dttm,
			 rt_id_from,                    rt_id_last_acty,
			 rt_id_to,                      scnd_adv_cd,
			 sgnl_cd,                       smic,
			 spcl_dscrp_fg,                 stk_fg,
			 sts_trans_dttm,                sup_sts_cd,
			 supadd,                        td_comp_fg,
			 tec,                           tot_rob_qty,
			 ty_rqn_ind,                    unit_price,
			 wc_cd,                         wuc
	 		from dr14_rqn_hist
 			where ddsn = @ddsn
	
			print " ddsn %1! moved from dr14 to dr09.", @ddsn
		end
	else
		begin
			print "ddsn %1! not found on dr14!", @ddsn
		end

if exists (select 1 from dr09_requisition where ddsn = @ddsn)
	begin
		delete from dr14_rqn_hist where ddsn = @ddsn
	end
	
go
