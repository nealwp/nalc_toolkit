declare @mcn	char(7)
select @mcn = '!VAR1!'

declare @init_dttm	datetime

dm04:

if exists (select 1 from dm04_maf where mcn = @mcn)
	begin
		select @init_dttm = (select min(maint_act_dttm) from dm03_jshistory where mcn = @mcn)
			
		if @init_dttm is null 
			begin
				select @init_dttm = maint_act_dttm from dm04_maf where mcn = @mcn
			end
		
		update dm04_maf
		set init_dttm = @init_dttm
		where mcn = @mcn

		print "Updated dm04 init_dttm to %1! for mcn %2!.", @init_dttm, @mcn
		
		goto done
	end
else
	begin
		print "mcn %1! not found on dm04!", @mcn
		
		goto dm18
	end

dm18:

if exists (select 1 from dm18_maf_hist where mcn = @mcn)
	begin
		select @init_dttm = (select min(maint_act_dttm) from dm17_jshist_hist where mcn = @mcn)
		
		update dm18_maf_hist
		set init_dttm = @init_dttm
		where mcn = @mcn

		print "Updated dm18 init_dttm to %1! for mcn %2!", @init_dttm, @mcn

		goto done
	end
else
	begin
		print "mcn %1! not found on dm18!", @mcn
		
		goto done
	end

done:

go
