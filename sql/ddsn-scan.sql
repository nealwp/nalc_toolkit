declare @ddsn    varchar(9)
declare @ddsn_suf char(1)

select @ddsn = '!VAR1!'

if char_length(@ddsn) = 9
    begin
        select @ddsn_suf = right(@ddsn, 1)
        select @ddsn = left(@ddsn, 8)
    end
else
    begin
       select @ddsn_suf = ''
    end


select 'db15_db_ext_imr.ddsn' 'table.column', ddsn 
from db15_db_ext_imr 
where ddsn = @ddsn 
 
select 'db18_aom_xtrct.ddsn', ddsn 
from db18_aom_xtrct 
where ddsn = @ddsn 
 
select 'dg11_msg_rqn_act.ddsn', ddsn 
from dg11_msg_rqn_act 
where ddsn = @ddsn 
 
select 'dg13_amsu_ind_disc.ti_ddsn', ti_ddsn 
from dg13_amsu_ind_disc 
where ti_ddsn = @ddsn 
 
select 'dg15_mat_rej.ddsn', ddsn 
from dg15_mat_rej 
where ddsn = @ddsn 

select 'dg23_mat_conting.ddsn', ddsn 
from dg23_mat_conting 
where ddsn = @ddsn 
 
select 'dg32_awp_comp_rels.ddsn', ddsn 
from dg32_awp_comp_rels 
where ddsn = @ddsn 

select 'di05_df_pndg_rels.ddsn', ddsn 
from di05_df_pndg_rels 
where ddsn = @ddsn 

select 'dl05_peb_cand.ddsn', ddsn 
from dl05_peb_cand 
where ddsn = @ddsn 

select 'dl12_peb_demand.ddsn', ddsn 
from dl12_peb_demand 
where ddsn = @ddsn 
 
select 'dl13_peb_demand_hist.ddsn', ddsn 
from dl13_peb_demand_hist 
where ddsn = @ddsn 

select 'dl19_pebdmd_cand.ddsn', ddsn 
from dl19_pebdmd_cand 
where ddsn = @ddsn 
 
select 'dl22_phase_kit_inv_due.master_phase_kit_ddsn', master_phase_kit_ddsn 
from dl22_phase_kit_inv_due 
where master_phase_kit_ddsn = @ddsn 

select 'dm01_fail_req.ddsn', ddsn 
from dm01_fail_req 
where ddsn = @ddsn 

select 'dm04_maf.ti_ddsn', ti_ddsn 
from dm04_maf 
where ti_ddsn = @ddsn 

select 'dm04_maf.cannib_ddsn', cannib_ddsn 
from dm04_maf 
where cannib_ddsn = @ddsn 

select 'dm04_maf.cur_ti_ddsn', cur_ti_ddsn 
from dm04_maf 
where cur_ti_ddsn = @ddsn 

select 'dm15_fail_req_hist.ddsn', ddsn 
from dm15_fail_req_hist 
where ddsn = @ddsn 

select 'dm18_maf_hist.ti_ddsn', ti_ddsn 
from dm18_maf_hist 
where ti_ddsn = @ddsn 

select 'dm18_maf_hist.cannib_ddsn', cannib_ddsn 
from dm18_maf_hist 
where cannib_ddsn = @ddsn 

select 'dm18_maf_hist.cur_ti_ddsn', cur_ti_ddsn 
from dm18_maf_hist 
where cur_ti_ddsn = @ddsn 

select 'dm27_av_3m_60.ddsn', ddsn 
from dm27_av_3m_60 
where ddsn = @ddsn 

select 'dm32_reqn_xtrct.ddsn', ddsn 
from dm32_reqn_xtrct 
where ddsn = @ddsn 
 
select 'dr01_acthistory.ddsn', ddsn 
from dr01_acthistory 
where ddsn = @ddsn 
 
select 'dr02_action.ddsn', ddsn 
from dr02_action 
where ddsn = @ddsn 
 
select 'dr04_contract.ddsn', ddsn 
from dr04_contract 
where ddsn = @ddsn 
 
select 'dr05_external.ddsn', ddsn 
from dr05_external 
where ddsn = @ddsn 
 
select 'dr06_iou.ddsn', ddsn 
from dr06_iou 
where ddsn = @ddsn 
 
select 'dr07_lschistory.ddsn', ddsn 
from dr07_lschistory 
where ddsn = @ddsn 
 
select 'dr09_requisition.ddsn', ddsn 
from dr09_requisition 
where ddsn = @ddsn 
 
select 'dr09_requisition.oafm_ddsn', oafm_ddsn 
from dr09_requisition 
where oafm_ddsn = @ddsn 
 
select 'dr09_requisition.reord_ddsn', reord_ddsn 
from dr09_requisition 
where reord_ddsn = @ddsn 
 
select 'dr09_requisition.cur_ti_ddsn', cur_ti_ddsn 
from dr09_requisition 
where cur_ti_ddsn = @ddsn 

select 'dr09_requisition.master_phase_kit_ddsn', master_phase_kit_ddsn 
from dr09_requisition 
where master_phase_kit_ddsn = @ddsn 

select 'dr09_requisition.def_peb_phase_kit_ddsn', def_peb_phase_kit_ddsn 
from dr09_requisition 
where def_peb_phase_kit_ddsn = @ddsn 

select 'dr10_stathistory.ddsn', ddsn 
from dr10_stathistory 
where ddsn = @ddsn 
 
select 'dr11_acthist_hist.ddsn', ddsn 
from dr11_acthist_hist 
where ddsn = @ddsn 

select 'dr12_action_hist.ddsn', ddsn 
from dr12_action_hist 
where ddsn = @ddsn 
 
select 'dr13_lschist_hist.ddsn', ddsn 
from dr13_lschist_hist 
where ddsn = @ddsn 

select 'dr14_rqn_hist.ddsn', ddsn 
from dr14_rqn_hist 
where ddsn = @ddsn 

select 'dr14_rqn_hist.oafm_ddsn', oafm_ddsn 
from dr14_rqn_hist 
where oafm_ddsn = @ddsn 

select 'dr14_rqn_hist.reord_ddsn', reord_ddsn 
from dr14_rqn_hist 
where reord_ddsn = @ddsn 

select 'dr14_rqn_hist.cur_ti_ddsn', cur_ti_ddsn 
from dr14_rqn_hist 
where cur_ti_ddsn = @ddsn 

select 'dr14_rqn_hist.master_phase_kit_ddsn', master_phase_kit_ddsn 
from dr14_rqn_hist 
where master_phase_kit_ddsn = @ddsn 

select 'dr14_rqn_hist.def_peb_phase_kit_ddsn', def_peb_phase_kit_ddsn 
from dr14_rqn_hist 
where def_peb_phase_kit_ddsn = @ddsn 

select 'dr15_stshist_hist.ddsn', ddsn 
from dr15_stshist_hist 
where ddsn = @ddsn 

select 'dr16_stk_rqn.ddsn', ddsn 
from dr16_stk_rqn 
where ddsn = @ddsn 

select 'dr17_dto_rqn.ddsn', ddsn 
from dr17_dto_rqn 
where ddsn = @ddsn 

select 'dr18_aom_qtr1.ddsn', ddsn 
from dr18_aom_qtr1 
where ddsn = @ddsn 

select 'dr19_aom_qtr2.ddsn', ddsn 
from dr19_aom_qtr2 
where ddsn = @ddsn 

select 'dr20_aom_qtr3.ddsn', ddsn 
from dr20_aom_qtr3 
where ddsn = @ddsn 

select 'dr21_aom_qtr4.ddsn', ddsn 
from dr21_aom_qtr4 
where ddsn = @ddsn 

select 'dr22_aom_qtr1_hist.ddsn', ddsn 
from dr22_aom_qtr1_hist 
where ddsn = @ddsn 

select 'dr23_aom_qtr2_hist.ddsn', ddsn 
from dr23_aom_qtr2_hist 
where ddsn = @ddsn 

select 'dr24_aom_qtr3_hist.ddsn', ddsn 
from dr24_aom_qtr3_hist 
where ddsn = @ddsn 

select 'dr25_aom_qtr4_hist.ddsn', ddsn 
from dr25_aom_qtr4_hist 
where ddsn = @ddsn 

select 'dr26_peb_req.ddsn', ddsn 
from dr26_peb_req 
where ddsn = @ddsn 

select 'ds03_item.ti_ddsn', ti_ddsn 
from ds03_item 
where ti_ddsn = @ddsn 

select 'ds03_item.cur_ti_ddsn', cur_ti_ddsn 
from ds03_item 
where cur_ti_ddsn = @ddsn 

select 'dt02_transdata.ddsn', ddsn 
from dt02_transdata 
where ddsn = @ddsn 

go

