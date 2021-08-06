declare @ddsn	char(8)
select @ddsn = '!VAR1!'

if exists (select 1 from dr06_iou where ddsn = @ddsn)
	begin
		declare @niin 	char(9)
		select @niin = (select niin from dr06_iou where ddsn = @ddsn)

		declare @new_iou_qty	int
		select @new_iou_qty = (select so_iou_qty - 1 from ds02_invdata where niin = @niin) 

		delete from dr06_iou 
		where ddsn = @ddsn

		update ds02_invdata
		set so_iou_qty = so_iou_qty - 1
		where niin = @niin
		
		print ""
		print " Deleted dr06 record for ddsn %1!.", @ddsn
		print " Set ds02 so_iou_qty to %1! for niin %2!.", @new_iou_qty, @niin
		print ""

		goto done	
	end
else
	begin
		print ""
		print " No iou record exists on dr06 for ddsn %1!.", @ddsn
		print ""
		
		goto done
	end

done:

go
