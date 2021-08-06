declare @ddsn	char(8)
declare @iou_type char(2)
select @ddsn = '!VAR1!'
select @iou_type = '!VAR2!'

if not exists (select 1 from dr09_requisition where ddsn = @ddsn)
	begin
		print "ddsn %1! not found on dr09!", @ddsn
		goto done
	end

if (select max(mcc) from dr09_requisition where ddsn = @ddsn) not in ('H','E','X','D','Q','G')
	begin
		print "Cannot create IOU for consumable requisition!"
		goto done
	end

if (select cur_mcn from dr09_requisition where ddsn = @ddsn) <> '' 
	or (select rep_mcn from dr09_requisition where ddsn = @ddsn) <> ''
	begin
		print "ddsn %1! has already been inducted, cannot create IOU!", @ddsn
		goto done
	end

if @iou_type not in ('SO','ER')
	begin
		print "Invalid iou_type: %1!. Valid iou_type arguments are SO or ER.", @iou_type
		goto done
	end

if not exists (select 1 from dr06_iou where ddsn = @ddsn)
	begin
		declare @cur_niin char(9)
		declare @new_iou_qty int

		select @cur_niin = cur_niin
		from dr09_requisition
		where ddsn = @ddsn

		if @iou_type = 'SO'
			begin
				select @new_iou_qty = so_iou_qty + 1
				from ds02_invdata
				where niin = @cur_niin
			end
		else if @iou_type = 'ER'
			begin
				select @new_iou_qty = eriou_qty + 1
                from ds02_invdata
                where niin = @cur_niin
			end

		insert into dr06_iou (org_cd, ddsn, niin, iou_dttm)
		select org_cd, ddsn, cur_niin, getdate()
		from dr09_requisition
		where ddsn = @ddsn

		print "Created dr06 record for %1!.", @ddsn


        if @iou_type = 'SO'
			begin
				update ds02_invdata
				set so_iou_qty = @new_iou_qty
				where niin = @cur_niin
			
				 print "Updated ds02 so_iou_qty to %1! for niin %2!.", @new_iou_qty, @cur_niin
			end
		else if @iou_type = 'ER'
			begin
				update ds02_invdata
				set eriou_qty = @new_iou_qty
				where niin = @cur_niin

				print "Updated ds02 eriou_qty to %1! for niin %2!.", @new_iou_qty, @cur_niin
			end
	end
else
	begin
		print "dr06 record already exists for ddsn %1!!", @ddsn
		goto done
	end

done:

go
