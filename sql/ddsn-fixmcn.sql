declare @ddsn   		char(8)
declare @cur_mcn 		char(7)
declare @rep_mcn 		char(7)
declare @crossed_ddsn	char(8)
declare @eserno			varchar(25)


select @ddsn = '!VAR1!'

if exists (select 1 from dr09_requisition where ddsn = @ddsn)
	begin
		select @cur_mcn = (select cur_mcn from dr09_requisition where ddsn = @ddsn)
		select @rep_mcn = (select rep_mcn from dr09_requisition where ddsn = @ddsn)
		
		if @cur_mcn <> @rep_mcn and @cur_mcn <> '' and @rep_mcn <> ''
		    begin
				goto cross_issue
    		end
		else if @cur_mcn = '' or @rep_mcn = ''
			begin
				goto blank_mcns
			end
		else
			begin
				print " No mismatched/blank mcn's found for ddsn %1!.", @ddsn
				goto done
			end
	end
else
    begin
        print ""
        print " ddsn %1! not found on dr09!", @ddsn
        print ""

        goto done
    end

cross_issue:

if exists (select 1 from dr09_requisition where cur_mcn = @rep_mcn)
	begin
		select @crossed_ddsn = (select ddsn from dr09_requisition where cur_mcn = @rep_mcn)
		
		update dr09_requisition
		set rep_mcn = @cur_mcn
		where ddsn = @ddsn

		print " Updated dr09 rep_mcn to %1! for ddsn %2!", @cur_mcn, @ddsn		

		update dr09_requisition
		set rep_mcn = @rep_mcn
		where ddsn = @crossed_ddsn

		print " Updated dr09 rep_mcn to %1! for ddsn %2!", @rep_mcn, @crossed_ddsn		

		if exists (select 1 from ds03_item where cur_ti_ddsn = @ddsn)
			begin
				update ds03_item
				set rep_mcn = @cur_mcn,
				ti_ddsn = @ddsn
				where cur_ti_ddsn = @ddsn
		
				print " Updated ds03 rep_mcn to %1!, ti_ddsn to %2! for cur_ti_ddsn %3!", @cur_mcn, @ddsn, @ddsn
			end
		else
			begin
				print " No ds03 record exists for cur_ti_ddsn %1!", @ddsn
			end

		if exists (select 1 from ds03_item where cur_ti_ddsn = @crossed_ddsn)
			begin
				update ds03_item
				set rep_mcn = @rep_mcn,
				ti_ddsn = @crossed_ddsn
				where cur_ti_ddsn = @crossed_ddsn

				print " Updated ds03 rep_mcn to %1!, ti_ddsn to %2! for cur_ti_ddsn %3!", @rep_mcn, @crossed_ddsn, @crossed_ddsn
			end
		else
			begin
				print " No ds03 record exists for cur_ti_ddsn %1!", @crossed_ddsn
			end
		
		if exists (select 1 from dm04_maf where mcn = @cur_mcn)
			begin
				update dm04_maf
				set ti_ddsn = @ddsn
				where mcn = @cur_mcn

				print " Updated dm04 ti_ddsn to %1! for mcn %2!", @ddsn, @cur_mcn
			end
		else
			begin
				print " No dm04 record exists for mcn %1!", @cur_mcn
			end		


		if exists (select 1 from dm04_maf where mcn = @rep_mcn)
			begin
				update dm04_maf
				set ti_ddsn = @crossed_ddsn
				where mcn = @rep_mcn

				print " Updated dm04 ti_ddsn to %1! for mcn %2!", @crossed_ddsn, @rep_mcn
			end
		else
			begin
				print " No dm04 record exists for mcn %1!", @rep_mcn
			end
		

		if exists (select 1 from dg12_comp_rep_act where mcn = @cur_mcn)
			begin
				select @eserno = (select e_serno from dm09_removed where mcn = @cur_mcn)

				update dg12_comp_rep_act
				set comp_serno = @eserno
				where mcn = @cur_mcn

				print "Updated dg12 comp_serno to %1! for mcn %2!.", @eserno, @cur_mcn
			end
		else
			begin
				print " No dg12 record exists for mcn %1!", @cur_mcn
			end

		if exists (select 1 from dg12_comp_rep_act where mcn = @rep_mcn)
			begin
				select @eserno = (select e_serno from dm09_removed where mcn = @rep_mcn)
			
				update dg12_comp_rep_act
	            set comp_serno = @eserno
                where mcn = @rep_mcn

				print "Updated dg12 comp_serno to %1! for mcn %2!.", @eserno, @rep_mcn
			end
		else
			begin
				print " No dg12 record exists for mcn %1!", @rep_mcn
			end
	end
else
	begin
		print " No ds03 record exists for ddsn %1!.", @ddsn
	end

goto done	

blank_mcns:

if exists (select 1 from ds03_item where cur_ti_ddsn = @ddsn)
	begin
		select @cur_mcn = (select cur_mcn from ds03_item where cur_ti_ddsn = @ddsn)
		select @rep_mcn = (select rep_mcn from ds03_item where cur_ti_ddsn = @ddsn)

		update dr09_requisition
		set cur_mcn = @cur_mcn,
		 rep_mcn = @rep_mcn
		where ddsn = @ddsn

		print ""
		print " Updated dr09 cur_mcn to %1!, rep_mcn to %2! for ddsn %3!.", @cur_mcn, @rep_mcn, @ddsn
		print ""

		goto done
	end
else
	begin
		print ""
		print " No ds03 record exists for ddsn %1!!", @ddsn
		print ""

		goto done
	end

done:



go
