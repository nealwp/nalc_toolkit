declare @ddsn 		varchar(9)
declare @lsc_dttm 	datetime
declare @ddsn_suf	char(1)

select @ddsn = '!VAR1!'
select @lsc_dttm = '!VAR2! !VAR3!'

if char_length(@ddsn) = 9
	begin
		select @ddsn_suf = right(@ddsn, 1)
		select @ddsn = left(@ddsn, 8)
	end
else
	begin
		select @ddsn_suf = ''
	end

dr09:

if exists (select 1 from dr09_requisition where ddsn = @ddsn and ddsn_suf = @ddsn_suf)
	begin
		if (select max(lsc_dttm) from dr07_lschistory where ddsn = @ddsn and ddsn_suf = @ddsn_suf) <= @lsc_dttm
			or (select max(lsc_dttm) from dr07_lschistory where ddsn = @ddsn and ddsn_suf = @ddsn_suf) is null
			begin
				update dr09_requisition
				set lsc_dttm = @lsc_dttm, actl_rcpt_dttm = @lsc_dttm
				where ddsn = @ddsn
				and ddsn_suf = @ddsn_suf

				print "Updated dr09 lsc_dttm and actl_rcpt_dttm to %1! for ddsn %2!%3!.", @lsc_dttm, @ddsn, @ddsn_suf
				goto dm01 
			end
		else
			begin
				print "ddsn %1!%2!: dr09 lsc_dttm cannot be older than latest dr07 entry!", @ddsn, @ddsn_suf
				goto done
			end
	end
else
	begin
		goto dr14
	end

dm01:

if exists (select 1 from dm01_fail_req where ddsn = @ddsn) and @ddsn_suf = ''
	begin
		update dm01_fail_req
		set actl_rcpt_dttm = @lsc_dttm
		where ddsn = @ddsn
	
		print "Updated dm01 actl_rcpt_dttm to %1! for ddsn %2!.", @lsc_dttm, @ddsn
		goto dr10
	end
else
	begin
		goto dr10
	end 

dr10:

if exists (select 1 from dr10_stathistory where ddsn = @ddsn and ddsn_suf = @ddsn_suf and sts_doc_id = 'POD')
	begin
		update dr10_stathistory
		set sts_trans_dttm = @lsc_dttm
		where ddsn = @ddsn
		and ddsn_suf = @ddsn_suf
		and sts_doc_id = 'POD'

		print "Updated dr10 sts_trans_dttm to %1! for POD on ddsn %2!%3!.", @lsc_dttm, @ddsn, @ddsn_suf
		goto done
	end
else
	begin
		goto done
	end 

dr14:

if exists (select 1 from dr14_rqn_hist where ddsn = @ddsn and ddsn_suf = @ddsn_suf)
	begin
		if (select max(lsc_dttm) from dr13_lschist_hist where ddsn = @ddsn and ddsn_suf = @ddsn_suf) <= @lsc_dttm
			or (select max(lsc_dttm) from dr13_lschist_hist where ddsn = @ddsn and ddsn_suf = @ddsn_suf) is null
			begin
				update dr14_rqn_hist
				set lsc_dttm = @lsc_dttm, actl_rcpt_dttm = @lsc_dttm
				where ddsn = @ddsn
				and ddsn_suf = @ddsn_suf

				print "Updated dr14 lsc_dttm and actl_rcpt_dttm to %1! for ddsn %2!%3!.", @lsc_dttm, @ddsn, @ddsn_suf
        		goto dm15
			end
		else
			begin
				print "ddsn %1!%2!: dr14 lsc_dttm cannot be older than latest dr13 entry!", @ddsn, @ddsn_suf
                goto done
			end
	end
else
	begin
		print "ddsn %1!%2! not found.", @ddsn, @ddsn_suf
		goto done
	end

dm15:

if exists (select 1 from dm15_fail_req_hist where ddsn = @ddsn)
    begin
        update dm15_fail_req_hist
        set actl_rcpt_dttm = @lsc_dttm
        where ddsn = @ddsn

        print "Updated dm15 actl_rcpt_dttm to %1! for ddsn %2!.", @lsc_dttm, @ddsn
        goto dr15
    end
else
    begin
        goto dr15
    end

dr15:

if exists (select 1 from dr15_stshist_hist where ddsn = @ddsn and ddsn_suf = @ddsn_suf and sts_doc_id = 'POD')
    begin
        update dr15_stshist_hist
        set sts_trans_dttm = @lsc_dttm
        where ddsn = @ddsn
        and ddsn_suf = @ddsn_suf
        and sts_doc_id = 'POD'

        print "Updated dr15 sts_trans_dttm to %1! for POD on ddsn %2!%3!.", @lsc_dttm, @ddsn, @ddsn_suf
   		goto done
	end
else
    begin
        goto done
    end

done:

go

