declare @mcn 		char(7)
declare @aimd_loctn char(6)
declare @eserno		varchar(25)

select @mcn = '!VAR1!'
select @aimd_loctn = '!VAR2!'

if @aimd_loctn = '!VAR2!'
	begin
		select @aimd_loctn = ''
	end

dm04:

if exists (select 1 from dm04_maf where mcn = @mcn)
	begin
		if (select ty_maf_cd from dm04_maf where mcn = @mcn) in ('D','SD','SI')
			begin
				goto dm09
			end
		else
			begin
				print " mcn %1! is not a D/SD/SI maf, cannot create DIFM!", @mcn
				goto done
			end	
	end
else
	begin
		if exists (select 1 from dm18_maf_hist where mcn = @mcn)
			begin
				print " mcn %1! must be reactivated before DIFM can be created!", @mcn
				goto done
			end
		else
			begin
				print " mcn %1! not found on dm04 or dm18, cannot create DIFM!", @mcn
				goto done
			end
	end

dm09:

if exists (select 1 from dm09_removed where mcn = @mcn)
	begin
		select @eserno = (select e_serno from dm09_removed where mcn = @mcn)
		goto ds03
	end
else
	begin
		print " No dm09_removed item exists for mcn %1!! comp_serno set to 0000.", @mcn
		select @eserno = '0000'
		goto ds03
	end

ds03:

if not exists (select 1 from ds03_item where cur_mcn = @mcn or rep_mcn = @mcn)
	begin
		insert into ds03_item (
        	aimd_loctn,     bal_cd,
        	bal_dttm,       comp_serno,
        	csp_allow,      csp_allow_cd,
        	cur_mcn,        cur_mgmt_cd,
        	cur_purp_cd,    cur_ti_ddsn,
        	est_rtn_dttm,   itm_dttm,
        	itm_qty,        niin,
        	org_cd,        	orgin_cd,
        	par_uic,        pkup_id,
        	prv_mgmt_cd,    prv_purp_cd,
        	ref,        	rep_mcn,
        	rmks_50_itm,	so_dmg_ind,
        	ti_ddsn,        wc_cd
		)
		select 
			@aimd_loctn,			'DF',
			init_dttm,				@eserno,
			0,						'',
			mcn,					'SO',
			'W',					cur_ti_ddsn,
			'Jan  1 1900 12:00AM',	init_dttm,
			1,						niin,
			'',					    '',
    		'',					    '',
    		'',					    '',
    		'',						mcn,
			'',						'',
			ti_ddsn,				wc_cd
		from dm04_maf
		where mcn = @mcn

		print " Created ds03 DIFM record for mcn %1!.", @mcn
		goto ds02
	end
else
	begin
		print " ds03 record already exists for mcn %1!!", @mcn
		goto done
	end

ds02:

declare @niin 			char(9)
declare @ds03_difm_qty 	int
declare @ds03_acbal		int

select @niin = niin from dm04_maf where mcn = @mcn
select @ds03_difm_qty = count(*) from ds03_item where niin = @niin and bal_cd = 'DF'
select @ds03_acbal = (select sum(itm_qty) from ds03_item where ds03_item.niin = @niin and cur_mgmt_cd in ('SO','ER','OW'))


if not (select difm_qty from ds02_invdata where niin = @niin) = @ds03_difm_qty
	begin
		update ds02_invdata
		set difm_qty = @ds03_difm_qty, acct_qty = @ds03_acbal
		where niin = @niin
		
		print " Updated ds02 difm_qty to %1!, acct_qty to %2! for niin %3!.", @ds03_difm_qty, @ds03_acbal, @niin
		goto done
	end
else
	begin
		print " ds02 difm_qty for niin %1! is already correct.", @niin
		goto done
	end

done:

go
