declare @mcn char(7)
declare @maint_act_dttm datetime

select @mcn = '!VAR1!'

if exists (select 1 from dm04_maf where mcn = @mcn)
	begin
	
	select @maint_act_dttm = max(maint_act_dttm) from dm03_jshistory where mcn = @mcn
	
	if exists (select 1 from dm06_maf_correct where mcn = @mcn)
		begin
		update dm06_maf_correct
		set
	        corr_act = '',                  corr_act_2 = '',
       		corr_act_3 = '',                corr_act_4 = '',
       		corr_act_5 = '',                corr_act_6 = '',
       		data_sig = '',                  logs_rec_sig = '',              
       		maint_cntl_sig = '',    		pc_sig = '',
       		pc_signo_dttm = '',             qa_cdi_sig = '',
       		qa_cntl_lv = '',                supr_sig = '',
       		supr_signo_dttm = '', 			wkr_sig = ''
		where mcn = @mcn

		update dm04_maf
		set maint_act_sts = 'M3', maint_act_dttm = @maint_act_dttm, mal_dscrptn_cd = '', act_take_cd = ''
		where mcn = @mcn
		
		delete from dg04_supr_rev where mcn = @mcn
		delete from dg05_prd_ctl_rev where mcn = @mcn
		delete from dg06_log_rec_req where mcn = @mcn
		delete from dg07_coll_duty_ins where mcn = @mcn
		delete from dg12_comp_rep_act where mcn = @mcn
		delete from dg14_data_anal_rev where mcn = @mcn
		delete from dg19_amsu_apr_req where mcn = @mcn
		delete from dg20_pc_apr_req where mcn = @mcn
	
		print " MAF %1! cleared back to worker.", @mcn
		print " Updated dm04 maint_act_sts to M3, maint_act_dttm to %1! for mcn %2!", @maint_act_dttm, @mcn 	
			
		goto done
		end

	end
else
	begin
		if exists (select 1 from dm18_maf_hist where mcn = @mcn)
			begin
				print " mcn %1! must be active to kick back!", @mcn
				goto done
			end
		else
			begin
				print " mcn %1! not found on dm04 or dm18.", @mcn
				goto done
			end
	end 

done:

go
