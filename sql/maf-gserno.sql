declare @mcn char(7)
declare @newserno varchar(15)

select @mcn = '!VAR1!'
select @newserno = '!VAR2!'

if exists (select 1 from dm09_removed where mcn = @mcn)
	begin
	
		update dm09_removed
		set g_serno = @newserno
		where mcn = @mcn

		print " Updated dm09 g_serno to %1! for mcn %2!.", @newserno, @mcn
		goto done
	end
else
	begin
		print " MCN %1! not found on dm09!", @mcn
		goto dm21
	end

dm21:
if exists (select 1 from dm21_removed_hist where mcn = @mcn)
	begin
		update dm21_removed_hist
		set g_serno = @newserno
		where mcn = @mcn

		print " Updated dm21 g_serno to %1! for mcn %2!.", @newserno, @mcn
		goto done
	end
else
	begin
		print " MCN %1! not found on dm21!", @mcn
		goto done
	end

done:

go
