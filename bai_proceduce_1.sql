use QLTHAMGIADETAI
go


create proc sp_PhanCongCV
	@magv varchar(10),
	@madt varchar(10),
	@sott int
as
begin
	if not exists (select MaGV from GiaoVien where MaGV = @magv)
	begin
		raiserror(N'Không tồn tại giảng viên này', 15, 1)
		return
	end
	if not exists (select * from CongViec where MaDT = @madt and SoTT = @sott)	
	begin
		raiserror(N'Không tồn tại công việc này', 15, 1)
		return
	end
	if (select count(*) from ThamGiaDT where MaGV = @magv and MaDT = @madt) < 3
	begin
		insert into ThamGiaDT(MaGV, MaDT, SoTT) values(@magv, @madt, @sott)
		print(N'Thêm thành công')
	end
	else
		print(N'Giảng viên chỉ được tham gia tối đa 3 công việc trong 1 đề tài')
end
go
exec sp_PhanCongCV '001', '002', 3

--2
select *
go
create proc sp_CapNhapNgayKTDA
	@madt varchar(10),
	@ngketthuc datetime
as
begin
	if not exists (select MaDT from DeTai where MaDT = @madt)
	begin
		raiserror(N'Không tồn tại dự án này', 15, 1)
		return
	end
	declare @ngbatdau datetime
	declare @capql nvarchar(15)
	select @ngbatdau = NgayBD, @capql = CapQL from DeTai where MaDT = @madt
	if(@capql = N'Trường')
	begin
		if @ngketthuc < DATEADD(month, 3, @ngbatdau)
		begin
			print(N'Ngày kết thúc đề tài cấp trường phải kết thức tối thiểu sau 3 tháng')
			return
		end
		if @ngketthuc > DATEADD(month, 6, @ngbatdau)
		begin
			print(N'Ngày kết thúc đề tài cấp trường phải kết tối đa trước 6 tháng')
			return
		end
	end
	if(@capql = 'DHQG')
	begin
		if @ngketthuc < DATEADD(month, 6, @ngbatdau)
		begin
			print(N'Ngày kết thúc đề tài cấp DHQG phải kết thức tối thiểu sau 6 tháng')
			return
		end
		if @ngketthuc > DATEADD(month, 9, @ngbatdau)
		begin
			print(N'Ngày kết thúc đề tài cấp DHQG phải kết thúc tối đa trước 9 tháng')
			return
		end
	end
	if(@capql = N'Nhà nước')
	begin
		if @ngketthuc < DATEADD(month, 12, @ngbatdau)
		begin
			print(N'Ngày kết thúc đề tài cấp trường phải kết thúc tối thiểu sau 12 tháng')
			return
		end
		if @ngketthuc > DATEADD(month, 24, @ngbatdau)
		begin
			print(N'Ngày kết thúc đề tài cấp trường phải kết thúc tối đa trước 24 tháng')
			return
		end
	end
	else
	begin
		update DeTai
		set NgayKT = @ngketthuc
		where MaDT = @madt
		print(N'Cập nhật ngày kết thúc thành công')
	end
end

--3

go
create proc sp_CapNhapGVQLCM
	@magv varchar(10),
	@magvql varchar(10)
as
begin
	if not exists (select MaGV from GiaoVien where MaGV = @magv)
	begin
		raiserror(N'Không tồn tại giáo viên cần được quản lý này', 15, 1)
		return
	end
	if not exists (select MaGV from GiaoVien where MAGV = @magvql)
	begin
		raiserror(N'Không tồn tại giáo viên quản lý này', 15, 1)
		return
	end
	if (select MaBM from GiaoVien where MaGV = @magv) = (select MaBM from GiaoVien where MaGV = @magvql)
	begin
		update GiaoVien
		set GVQLCM = @magvql
		where MaGV = @magv
		print(N'Cập nhật gv quản lý thành công')
	end
	else
		print(N'Hai giáo viên không cùng bộ môn')
end
go
exec sp_CapNhapGVQLCM '001', '002'

--4
go
create proc sp_BoNhiemTruongKhoa
	@truongkhoa varchar(10),
	@makhoa varchar(10)
as
begin
	if not exists (select * from GiaoVien where MaGV = @truongkhoa)
	begin
		raiserror(N'Không tồn tại giáo viên này', 15, 1)
		return
	end
	if not exists (select * from Khoa where MaKhoa = @makhoa)
	begin
		raiserror(N'Không tồn tại khoa này', 15, 1)
		return
	end
	if(select MaKhoa from BoMon
					where MaBM = (select MaBM
									from GiaoVien
									where MaGV = @truongkhoa)) != @makhoa
	begin
		raiserror(N'Người bổ nhiệm phải là người trong khoa', 15, 1)
		return
	end
	if exists (select * from GiaoVien where GVQLCM = @truongkhoa)
	begin
		raiserror(N'Người được bổ nhiêm không là quản lý chuyên môn', 15, 1)
		return
	end
	if exists (select * from BoMon where TruongBM = @truongkhoa)
	begin
		raiserror(N'Người được bổ nhiệm không là trưởng bộ môn', 15, 1)
		return
	end
	update Khoa
	set TruongKhoa = @truongkhoa
	where MaKhoa = @makhoa
	print(N'Cập nhật thành công')
end
go
exec sp_BoNhiemTruongKhoa '001','CNTT'

--05
go
create proc sp_DemSoKQDatCuaDeTai
	@madt varchar(10)
as
begin
	if not exists (select * from DeTai where MaDT = @madt)
	begin
		raiserror(N'Không tồn tại đề tài này',15, 1)
		return
	end
	select count(*) as SL_DAT
	from ThamGiaDT
	where MaDT = @madt and KetQua = N'Đạt'
end
go
exec sp_DemSoKQDatCuaDeTai '001'

--06
go
create proc sp_DemSLCVKhongDat
	@madt varchar(10)
as
begin
	if not exists (select * from DeTai where MaDT = @madt)
	begin
		raiserror(N'Không tồn tại đề tài này',15, 1)
		return
	end
	select count(*) as SL_KHONG_DAT
	from ThamGiaDT
	where MaDT = @madt and KetQua = N'Không đạt'
end
go
exec sp_DemSLCVKhongDat '001'

--07
go
create proc sp_DemSLCVChuaCoKQ
	@madt varchar(10)
as
begin
	if not exists (select * from DeTai where MaDT = @madt)
	begin
		raiserror(N'Không tồn tại đề tài này',15, 1)
		return
	end
	select count(*) as SL_KHONG_DAT
	from ThamGiaDT
	where MaDT = @madt and KetQua is null
end
go
--08
go
create proc sp_KetQuaNghiemThu
	@madt varchar(10)
as
begin
	if not exists (select * from DeTai where MaDT = @madt)
	begin
		raiserror(N'Không tồn tài đề tài này', 15, 1)
		return
	end
	if (select NgayKT from DeTai where MaDT = @madt) is null
	begin
		print(N'Đề tài chưa hoàn thành')
		return
	end
	declare @soluongdat int
	declare @soluongkhongdat int
	declare @soluongchuaht int
	select @soluongdat = COUNT(*) from ThamGiaDT where MaDT = @madt and KetQua = N'Đạt'
	select @soluongkhongdat = COUNT(*) from ThamGiaDT where MaDT = @madt and KetQua = N'Không đạt'
	select @soluongchuaht = COUNT(*) from ThamGiaDT where MaDT = @madt and KetQua is null
	declare @tileht float
	select @tileht = @soluongdat / (@soluongdat + @soluongkhongdat + @soluongchuaht)
	if @tileht = 1
	begin
		print(N'Giỏi')
		return
	end
	if @tileht >= 0.8 and @soluongchuaht = 0
	begin
		print(N'Khá')
		return
	end
	if @tileht >= 0.7 and @soluongchuaht = 0
	begin
		print(N'Trung bình')
		return
	end
	if(@tileht <= 0.5 and @soluongchuaht > 0)
	begin
		print(N'FAILED')
		return
	end
end
go
exec sp_KetQuaNghiemThu '002'