declare @mcn 		char(7)
declare @newpartno 	varchar(32)
declare @newniin 	char(9)
declare @oldpartno  varchar(32)
declare @oldcage    char(5)
declare @newcage    char(5)
declare @oldfgc     char(4)
declare @newfgc     char(4)

select @mcn = '!VAR1!'
select @newpartno = '!VAR2!'

if exists (select 1 from dm04_maf where mcn = @mcn)
	begin
		if exists (select 1 from dm09_removed where mcn = @mcn)
			begin

				select @oldpartno = (select e_part_no from dm09_removed where mcn = @mcn)

				select @oldcage = (select e_cage from dm09_removed where mcn = @mcn)

				select @newcage = (select max(cage) from dp01_cagepn where part_no = @newpartno)

				select @oldfgc = (
					select fgc
        			from ds05_niin ds05
        			join dp01_cagepn dp01 on ds05.niin = dp01.niin
       				where dp01.part_no = @oldpartno and dp01.cage = @oldcage
						)

				select @newfgc = (
					select fgc
        			from ds05_niin ds05
        			join dp01_cagepn dp01 on ds05.niin = dp01.niin
        			where dp01.part_no = @newpartno and dp01.cage = @newcage
						)

				declare @dm04fgc    char(4)
				select @dm04fgc = (
					select fgc 
					from ds05_niin ds05
					join dm04_maf dm04 on ds05.niin = dm04.niin
					where dm04.mcn = @mcn
						)


				if ((@oldfgc like @newfgc) or (@dm04fgc like @newfgc))
					begin

						select @newniin = (
							select max(niin) 
							from dp01_cagepn 
							where part_no = @newpartno
								)
						
						update dm04_maf
						set niin = @newniin
						where mcn = @mcn

						print "Updated dm04 niin to %1! for mcn %2!.", @newniin, @mcn
					
						update dm09_removed
        				set e_part_no = @newpartno
        				where mcn = @mcn

			 			print "Updated dm09 e_part_no to %1! for mcn %2!.", @newpartno, @mcn
						goto ds03
					end
				else
					begin
						print "fgc's do not match. Current fgc: %1!. New fgc: %2!. No changes made.", @dm04fgc, @newfgc
						goto done
					end
			end
		else
			begin
				print "No dm09 record exists for mcn %1!.", @mcn
				goto done
			end
	end
else
	begin
		print "No record for mcn %1! found on dm04!", @mcn
		goto dm18	
	end	

dm18:

if exists (select 1 from dm18_maf_hist where mcn = @mcn)
    begin
        if exists (select 1 from dm21_removed_hist where mcn = @mcn)
            begin

                select @oldpartno = (select e_part_no from dm21_removed_hist where mcn = @mcn)
                select @oldcage = (select e_cage from dm21_removed_hist where mcn = @mcn)
                select @newcage = (select max(cage) from dp01_cagepn where part_no = @newpartno)

                select @oldfgc = (
                    select fgc
                    from ds05_niin ds05
                    join dp01_cagepn dp01 on ds05.niin = dp01.niin
                    where dp01.part_no = @oldpartno and dp01.cage = @oldcage
                        )

                select @newfgc = (
                    select fgc
                    from ds05_niin ds05
                    join dp01_cagepn dp01 on ds05.niin = dp01.niin
                    where dp01.part_no = @newpartno and dp01.cage = @newcage
                        )

                declare @dm18fgc    char(4)
                select @dm18fgc = (
                    select fgc
                    from ds05_niin ds05
                    join dm18_maf_hist dm18 on ds05.niin = dm18.niin
                    where dm18.mcn = @mcn
                        )

			if ((@oldfgc like @newfgc) or (@dm18fgc like @newfgc))
                    begin

                        select @newniin = (
                            select max(niin)
                            from dp01_cagepn
                            where part_no = @newpartno
                                )

                        update dm18_maf_hist
                        set niin = @newniin
                        where mcn = @mcn

                        print "Updated dm18 niin to %1! for mcn %2!.", @newniin, @mcn

                        update dm21_removed_hist
                        set e_part_no = @newpartno
                        where mcn = @mcn

                        print "Updated dm21 e_part_no to %1! for mcn %2!.", @newpartno, @mcn
                        goto ds03
                    end
                else
                    begin
                        print "fgc's do not match. Current fgc: %1!. New fgc: %2!. No changes made.", @dm18fgc, @newfgc
                        goto done
                    end
            end
        else
            begin
                print "No dm21 record exists for mcn %1!.", @mcn
                goto done
            end
    end
else
    begin
        print "No record for mcn %1! found on dm18!", @mcn
        goto done
	end	

ds03:

if (select maint_trans_cd from dm04_maf where mcn = @mcn) in ('30','31','32') and
	(select cur_ti_ddsn from dm04_maf where mcn = @mcn) is not null
	begin
		if exists (select 1 from ds03_item where cur_mcn = @mcn and bal_cd like 'DF')
  			begin
				update ds03_item
        		set niin = @newniin
        		where cur_mcn = @mcn

				print "Updated ds03 niin to %1! for cur_mcn %2!.", @newniin, @mcn
    			goto done
    		end
	end
else
	begin
		print "mcn %1! is not Supply related. No ds03 changes made.", @mcn
		goto done
	end

done:

go

