declare @mcn 		char(7)
declare @rec_count 	int
declare @ttl_rec_count	int
select @mcn = '!VAR1!'
select @ttl_rec_count = 0

dm01:
	if exists (select 1 from dm01_fail_req where mcn = @mcn)
		begin
			select @rec_count = count(*) from dm01_fail_req where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm01_fail_req where mcn = @mcn
			print "%1! records deleted from dm01_fail_req for mcn %2!.", @rec_count, @mcn
		end	

dm02:
	if exists (select 1 from dm02_hours where mcn = @mcn) 
		begin
			select @rec_count = count(*) from dm02_hours where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm02_hours where mcn = @mcn
			print "%1! records deleted from dm02_hours for mcn %2!.", @rec_count, @mcn
		end

dm03:
	if exists (select 1 from dm03_jshistory where mcn = @mcn) 
		begin
			select @rec_count = count(*) from dm03_jshistory where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm03_jshistory where mcn = @mcn
			print "%1! records deleted from dm03_jshistory for mcn %2!.", @rec_count, @mcn
		end

dm06:
	if exists (select 1 from dm06_maf_correct where mcn = @mcn)
		begin
			select @rec_count = count(*) from dm06_maf_correct where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm06_maf_correct where mcn = @mcn
			print "%1! records deleted from dm06_maf_correct for mcn %2!.", @rec_count, @mcn
		end

dm07:
	if exists (select 1 from dm07_maf_discrep where mcn = @mcn) 
		begin
			select @rec_count = count(*) from dm07_maf_discrep where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm07_maf_discrep where mcn = @mcn
			print "%1! records deleted from dm07_maf_discrep for mcn %2!.", @rec_count, @mcn
		end

dm09:
	if exists (select 1 from dm09_removed where mcn = @mcn) 
		begin
			select @rec_count = count(*) from dm09_removed where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm09_removed where mcn = @mcn
			print "%1! records deleted from dm09_removed for mcn %2!.", @rec_count, @mcn
		end

dm10:
	if exists (select 1 from dm10_required where mcn = @mcn) 
		begin
			select @rec_count = count(*) from dm10_required where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm10_required where mcn = @mcn
			print "%1! records deleted from dm10_required for mcn %2!.", @rec_count, @mcn
		end

dm12:
	if exists (select 1 from dm12_maf_note where mcn = @mcn) 
		begin
			select @rec_count = count(*) from dm12_maf_note where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm12_maf_note where mcn = @mcn
			print "%1! records deleted from dm12_maf_note for mcn %2!.", @rec_count, @mcn
		end

dm13:
	if exists (select 1 from dm13_maf_trigger where mcn = @mcn) 
		begin
			select @rec_count = count(*) from dm13_maf_trigger where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm13_maf_trigger where mcn = @mcn
			print "%1! records deleted from dm13_maf_trigger for mcn %2!.", @rec_count, @mcn
		end

dm14:
	if exists (select 1 from dm14_in_proc_inspt where mcn = @mcn)
		begin
			select @rec_count = count(*) from dm14_in_proc_inspt where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count	
			delete from dm14_in_proc_inspt where mcn = @mcn
			print "%1! records deleted from dm14_in_proc_inspt for mcn %2!.", @rec_count, @mcn
		end

dm15:
	 if exists (select 1 from dm15_fail_req_hist where ti_mcn = @mcn)
        begin
			select @rec_count = count(*) from dm15_fail_req_hist where ti_mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count	
            delete from dm15_fail_req_hist where ti_mcn = @mcn
            print "%1! records deleted from dm15_fail_req_hist for mcn %2!.", @rec_count, @mcn
        end

dm33:
	if exists (select 1 from dm33_cond_maf_mod where mcn = @mcn)
		begin
			select @rec_count = count(*) from dm33_cond_maf_mod where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm33_cond_maf_mod where mcn = @mcn
			print "%1! records deleted from dm33_cond_maf_mod for mcn %2!.", @rec_count, @mcn
		end

db16:
	if exists (select 1 from db16_db_ext_ima where mcn = @mcn)
		begin
			select @rec_count = count(*) from db16_db_ext_ima where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from db16_db_ext_ima where mcn = @mcn
			print "%1! records deleted from db16_db_ext_ima for mcn %2!.", @rec_count, @mcn
		end

dg19:
	if exists(select 1 from dg19_amsu_apr_req where mcn = @mcn)
		begin
			select @rec_count = count(*) from dg19_amsu_apr_req where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dg19_amsu_apr_req where mcn = @mcn
			print "%1! records deleted from dg19_amsu_apr_req for mcn %2!.", @rec_count, @mcn
		end

de08:
	if exists (select 1 from de08_semathour where mcn = @mcn)
		begin
			select @rec_count = count(*) from de08_semathour where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from de08_semathour where mcn = @mcn
			print "%1! records deleted from de08_semathour for mcn %2!.", @rec_count, @mcn
		end
	
dm04:
	if exists (select 1 from dm04_maf where mcn = @mcn)
		begin
			select @rec_count = count(*) from dm04_maf where mcn = @mcn
			select @ttl_rec_count = @ttl_rec_count + @rec_count
			delete from dm04_maf where mcn = @mcn
			print "%1! records deleted from dm04_maf for mcn %2!.", @rec_count, @mcn
		end

done:
	print "Tables scanned for maf deletion: dm01_fail_req, dm02_hours, dm03_jshistory, dm06_maf_correct, dm07_maf_discrep, dm09_removed, dm10_required, dm12_maf_note, dm13_maf_trigger, dm14_in_proc_inspt, dm15_fail_req_hist, dm33_cond_maf_mod, db16_db_ext_ima, dg19_amsu_apr_req, de08_semathour, dm04_maf."
	print "%1! total records deleted for mcn %2!.", @ttl_rec_count, @mcn

go
