declare @mcn char(7)
select @mcn = '!VAR1!'

select 'db16_db_ext_ima.mcn', mcn 
from db16_db_ext_ima 
where mcn = @mcn 
 
select 'dd06_td_maf.mcn', mcn 
from dd06_td_maf 
where mcn = @mcn 
 
select 'de08_semathour.mcn', mcn 
from de08_semathour 
where mcn = @mcn 
 
select 'df13_mcn_asgn.mcn_cur', mcn_cur 
from df13_mcn_asgn 
where mcn_cur = @mcn  


select 'dg01_maf_maint_rqm.mcn', mcn 
from dg01_maf_maint_rqm 
where mcn = @mcn 
 
select 'dg03_qa_rev_not.mcn', mcn 
from dg03_qa_rev_not 
where mcn = @mcn 
 
select 'dg04_supr_rev.mcn', mcn 
from dg04_supr_rev 
where mcn = @mcn 
 
select 'dg05_prd_ctl_rev.mcn', mcn 
from dg05_prd_ctl_rev 
where mcn = @mcn 
 
select 'dg06_log_rec_req.mcn', mcn 
from dg06_log_rec_req 
where mcn = @mcn 
 
select 'dg07_coll_duty_ins.mcn', mcn 
from dg07_coll_duty_ins 
where mcn = @mcn 
 
select 'dg12_comp_rep_act.mcn', mcn 
from dg12_comp_rep_act 
where mcn = @mcn 
 
select 'dg13_amsu_ind_disc.mcn', mcn 
from dg13_amsu_ind_disc 
where mcn = @mcn 
 
select 'dg14_data_anal_rev.mcn', mcn 
from dg14_data_anal_rev 
where mcn = @mcn 
 
select 'dg15_mat_rej.mcn', mcn 
from dg15_mat_rej 
where mcn = @mcn 
 
select 'dg16_data_anal_rej.mcn', mcn 
from dg16_data_anal_rej 
where mcn = @mcn 
 
select 'dg17_serno_disc.mcn', mcn 
from dg17_serno_disc 
where mcn = @mcn 
 
select 'dg19_amsu_apr_req.mcn', mcn 
from dg19_amsu_apr_req 
where mcn = @mcn 
 
select 'dg20_pc_apr_req.mcn', mcn 
from dg20_pc_apr_req 
where mcn = @mcn 
 
select 'dg23_mat_conting.mcn', mcn 
from dg23_mat_conting 
where mcn = @mcn 
 
select 'dg32_awp_comp_rels.mcn', mcn 
from dg32_awp_comp_rels 
where mcn = @mcn  


select 'dm01_fail_req.mcn', mcn
from dm01_fail_req
where mcn = @mcn 
 
select 'dm01_fail_req.ti_mcn',
ti_mcn from dm01_fail_req
where ti_mcn = @mcn 
 
select 'dm02_hours.mcn', mcn 
from dm02_hours 
where mcn = @mcn 
 
select 'dm03_jshistory.mcn', mcn 
from dm03_jshistory 
where mcn = @mcn 
 
select 'dm04_maf.cntl_mcn', cntl_mcn 
from dm04_maf 
where cntl_mcn = @mcn 
 
select 'dm04_maf.mcn', mcn 
from dm04_maf 
where mcn = @mcn
 
select 'dm06_maf_correct.mcn', mcn 
from dm06_maf_correct 
where mcn = @mcn 
 
select 'dm07_maf_discrep.mcn', mcn 
from dm07_maf_discrep 
where mcn = @mcn 
 
select 'dm09_removed.mcn', mcn 
from dm09_removed
where mcn = @mcn 
 
select 'dm09_removed.rep_mcn', rep_mcn 
from dm09_removed 
where rep_mcn = @mcn 
 
select 'dm10_required.mcn', mcn 
from dm10_required 
where mcn = @mcn 
 
select 'dm12_maf_note.mcn', mcn 
from dm12_maf_note 
where mcn = @mcn 
 
select 'dm13_maf_trigger.mcn', mcn 
from dm13_maf_trigger 
where mcn = @mcn
 
select 'dm14_in_proc_inspt.mcn', mcn 
from dm14_in_proc_inspt
where mcn = @mcn 


select 'dm15_fail_req_hist', mcn 
from dm15_fail_req_hist 
where mcn = @mcn 
 
select 'dm15_fail_req_hist.ti_mcn', ti_mcn 
from dm15_fail_req_hist 
where ti_mcn = @mcn 
 
select 'dm16_hours_hist.mcn', mcn 
from dm16_hours_hist 
where mcn = @mcn 
 
select 'dm17_jshist_hist.mcn', mcn 
from dm17_jshist_hist 
where mcn = @mcn 
 
select 'dm18_maf_hist.cntl_mcn', cntl_mcn 
from dm18_maf_hist 
where cntl_mcn = @mcn 
 
select 'dm18_maf_hist.mcn', mcn 
from dm18_maf_hist 
where mcn = @mcn 
 
select 'dm19_correct_hist.mcn', mcn 
from dm19_correct_hist 
where mcn = @mcn 
 
select 'dm20_discrep_hist.mcn', mcn 
from dm20_discrep_hist 
where mcn = @mcn 
 
select 'dm21_removed_hist.mcn', mcn 
from dm21_removed_hist 
where mcn = @mcn 
 
select 'dm21_removed_hist.rep_mcn', rep_mcn 
from dm21_removed_hist 
where rep_mcn = @mcn 
 
select 'dm22_note_hist.mcn', mcn 
from dm22_note_hist 
where mcn = @mcn 
 
select 'dm23_in_proc_hist.mcn', mcn 
from dm23_in_proc_hist 
where mcn = @mcn 


select 'dm24_av_3m_rcvry.mcn', mcn 
from dm24_av_3m_rcvry 
where mcn = @mcn 
 
select 'dm25_del_corr_rec.mcn', mcn 
from dm25_del_corr_rec 
where mcn = @mcn 
 
select 'dm30_cond_maf.mcn', mcn 
from dm30_cond_maf 
where mcn = @mcn 
 
select 'dm33_cond_maf_mod.mcn', mcn 
from dm33_cond_maf_mod 
where mcn = @mcn 
 
select 'dm35_trnrd_tm.mcn', mcn 
from dm35_trnrd_tm 
where mcn = @mcn 
 
select 'dm36_cass_oms_mcn_trigger.mcn', mcn 
from dm36_cass_oms_mcn_trigger 
where mcn = @mcn  


select 'dr05_external.mcn', mcn 
from dr05_external 
where mcn = @mcn 
 
select 'dr09_requisition.cur_mcn', cur_mcn 
from dr09_requisition 
where cur_mcn = @mcn 
 
select 'dr09_requisition.mcn', mcn 
from dr09_requisition 
where mcn = @mcn 
 
select 'dr09_requisition.rep_mcn', rep_mcn 
from dr09_requisition 
where rep_mcn = @mcn 
 
select 'dr14_rqn_hist.cur_mcn', cur_mcn 
from dr14_rqn_hist 
where cur_mcn = @mcn 
 
select 'dr14_rqn_hist.mcn', mcn 
from dr14_rqn_hist 
where mcn = @mcn 
 
select 'dr14_rqn_hist.rep_mcn', rep_mcn 
from dr14_rqn_hist 
where rep_mcn = @mcn 
 
select 'dr18_aom_qtr1.cur_mcn', cur_mcn 
from dr18_aom_qtr1 
where cur_mcn = @mcn 
 
select 'dr19_aom_qtr2.cur_mcn', cur_mcn 
from dr19_aom_qtr2 
where cur_mcn = @mcn 
 
select 'dr20_aom_qtr3.cur_mcn', cur_mcn 
from dr20_aom_qtr3 
where cur_mcn = @mcn 
 
select 'dr21_aom_qtr4.cur_mcn', cur_mcn 
from dr21_aom_qtr4 
where cur_mcn = @mcn 
 
select 'dr22_aom_qtr1_hist.cur_mcn', cur_mcn 
from dr22_aom_qtr1_hist 
where cur_mcn = @mcn 
 
select 'dr23_aom_qtr2_hist.cur_mcn', cur_mcn 
from dr23_aom_qtr2_hist 
where cur_mcn = @mcn 
 
select 'dr24_aom_qtr3_hist.cur_mcn', cur_mcn 
from dr24_aom_qtr3_hist 
where cur_mcn = @mcn 
 
select 'dr25_aom_qtr4_hist.cur_mcn', cur_mcn 
from dr25_aom_qtr4_hist 
where cur_mcn = @mcn  


select 'ds03_item.cur_mcn', cur_mcn 'mcn' 
from ds03_item 
where cur_mcn = @mcn 
 
select 'ds03_item.rep_mcn', rep_mcn 
from ds03_item
where rep_mcn = @mcn 
 
select 'dt02_transdata.mcn', mcn 
from dt02_transdata 
where mcn = @mcn 


go
