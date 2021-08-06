declare @ddsn 	char(8)
select @ddsn = '!VAR1!'

if exists (select 1 from dr09_requisition where ddsn = @ddsn)
	begin
		if exists (select 1 from dm04_maf where ti_ddsn = @ddsn)
			begin
				declare @mcn 	char(7)
				select @mcn = (select mcn from dm04_maf where ti_ddsn = @ddsn)
			
				update dm04_maf
				set buno_serno = str_replace(buno_serno, '-', null)
				where mcn = @mcn
			
				declare @buno_serno	varchar(10)
				select @buno_serno = (select buno_serno from dm04_maf where mcn = @mcn)

				print " Updated dm04 buno_serno to %1! for mcn %2!.", @buno_serno, @mcn
				
				update dr09_requisition
				set buno_serno = @buno_serno
				where ddsn = @ddsn

				print " Updated dr09 buno_serno to %1! for ddsn %2!.", @buno_serno, @ddsn
			end
		else
			begin
				print " mcn for ddsn %1! not found on dm04!", @ddsn
				goto done
			end
	end
else
	begin
		print " ddsn %1! not found on dr09!", @ddsn
		goto done
	end

done:

go	
		
