declare @input_type varchar(4)
declare @input		varchar(9)
select @input_type = '!VAR1!'
select @input = '!VAR2!'


if @input_type = 'ddsn'
	begin

		select ddsn, niin, mcn, sup_trans_cd, trans_data_dttm, last_nm
		from dt02_transdata
		left join du05_personnel
		on dt02_transdata.ssn = du05_personnel.ssn
		where ddsn = @input
		order by trans_data_dttm asc

	end
else if @input_type = 'mcn'
	begin

		select mcn, ddsn, niin, sup_trans_cd, trans_data_dttm, last_nm
        from dt02_transdata
        left join du05_personnel
        on dt02_transdata.ssn = du05_personnel.ssn
        where mcn = @input
        order by trans_data_dttm asc
	
	end
else if @input_type = 'niin'
	begin

		select niin, ddsn, mcn, sup_trans_cd, trans_data_dttm, last_nm
        from dt02_transdata
        left join du05_personnel
        on dt02_transdata.ssn = du05_personnel.ssn
        where niin = @input
        order by trans_data_dttm asc

	end

done:

go
