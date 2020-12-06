create trigger CheckAlbumMaxRateDelete
on albums
for delete
as
begin
	declare @maxRate int
	declare	@maxRateAlbums table(alb_id int)
	declare @curRate int

	select @maxRate=max(rate)
	from albums;

	select @curRate=rate
	from deleted;

	insert @maxRateAlbums
	select id
	from albums
	where rate=@maxRate

	if (@curRate=@maxRate)
		begin
			raiserror('Альбом с максимальным рейтингом не может быть удален', 0, 1)
			rollback transaction
		end
	else
		begin
			print('альбом удален')
		end
end


