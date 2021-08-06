declare @mcn	char(7)
select @mcn = '!VAR1!'

if exists (select 1 from dm18_maf_hist where mcn = @mcn)
	begin
		if exists (select 1 from dm21_removed_hist where mcn = @mcn)
			begin
				update dm21_removed_hist
				set	g_cage = e_cage,
					g_part_no = e_part_no,
					g_serno = e_serno,
					g_tm_cy = e_tm_cy,
					e_cage = g_cage,
					e_part_no = g_part_no,
					e_serno = g_serno,
					e_tm_cy = g_tm_cy
				where mcn = @mcn
			
				print " Updated dm21 to swap e_ and g_ records for mcn %1!.", @mcn
				goto done
			end
		else
			begin
				print " mcn %1! not found on dm21!", @mcn
				goto done
			end
	end
else
	begin
		print " mcn %1! not found on dm18!", @mcn
		goto done
	end

done:

go
