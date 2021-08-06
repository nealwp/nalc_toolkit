declare @mcn char(7)
declare @newserno varchar(15)

select @mcn = '!VAR1!'
select @newserno = '!VAR2!'

if exists (select 1 from dm09_removed where mcn = @mcn)
	begin
	
		update dm09_removed
		set e_serno = @newserno
		where mcn = @mcn

		print " Updated dm09 e_serno to %1! for mcn %2!.", @newserno, @mcn
		goto ds03
	end
else
	begin
		print " MCN %1! not found on dm09!", @mcn
		goto done
	end

ds03:
if (select maint_trans_cd from dm04_maf where mcn = @mcn) in ('30','31','32') and
	(select cur_ti_ddsn from dm04_maf where mcn = @mcn) is not null
	begin
		if exists (select 1 from ds03_item where cur_mcn = @mcn and bal_cd like 'DF') 
           	begin
				update ds03_item
               	set comp_serno = @newserno
               	where cur_mcn = @mcn
				and bal_cd = 'DF'
		               
				print " Updated ds03 comp_serno to %1! for mcn %2!.", @newserno, @mcn
				goto dg12
			end
		else
			begin
				print " No record found on ds03."
				goto done
			end

dg12:
		if exists (select mcn from dg12_comp_rep_act where mcn = @mcn)
			begin
				update dg12_comp_rep_act
           		set comp_serno = @newserno
           		where mcn = @mcn

				print " Updated dg12 comp_serno to %1! for mcn %2!.", @newserno, @mcn
				goto done
			end
		else
			begin
				print " No record found on dg12."
				goto done
			end
	end

done:

go
