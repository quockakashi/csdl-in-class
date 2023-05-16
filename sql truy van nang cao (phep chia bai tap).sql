use QLTHAMGIADETAI
go

--Q58
select GV.HOTEN
from GIAOVIEN GV
where not exists (
					select MACD
					from CHUDE
					except 
					select CD.MACD
					from CHUDE CD join DETAI DT
					on (CD.MACD = DT.MADT) join THAMGIADT TG
					on (TG.MADT = DT.MADT)
					where TG.MAGV = GV.MAGV)


select HOTEN
from GIAOVIEN GV
where not exists (
					select *
					from CHUDE CD
					where not exists (
								select *
								from THAMGIADT TG join DETAI DT
								on (TG.MADT = DT.MADT)
								where GV.MAGV = TG.MAGV and DT.MACD = CD.MACD))

select HOTEN
from GIAOVIEN GV join THAMGIADT TG
on (GV.MAGV = TG.MAGV) join DETAI DT
on (TG.MADT = DT.MADT) join CHUDE CD
on (CD.MACD = DT.MACD)
group by TG.MAGV, GV.HOTEN
having COUNT(distinct CD.MACD) = (
									select COUNT(distinct MACD)
									from CHUDE CD)
--Q59

select TENDT
from DETAI DT
where not exists (
		select MAGV
		from GIAOVIEN GV join BOMON BM
		on (GV.MABM = BM.MABM)
		where BM.TENBM = N'Hệ thống thông tin'
		except
		select MAGV
		from THAMGIADT TG
		where TG.MADT = DT.MADT)


select TENDT
from DETAI DT
where not exists (
		select *
		from GIAOVIEN GV join BOMON BM
		on (GV.MABM = BM.MABM)
		where BM.TENBM = N'Hệ thống thông tin'
		and not exists (
				select *
				from THAMGIADT TG
				where TG.MADT = DT.MADT
				and GV.MAGV = TG.MAGV))


select DT.TenDT
from DeTai DT, ThamGiaDT TG, GiaoVien GV
where DT.MaDT = TG.MaDT and TG.MaGV = GV.MaGV
and GV.MaBM = 'HTTT'
group by TG.MaDT, DT.TenDT
having count(distinct GV.MaGV) = 
	(
		select count(MaGV)
		from GiaoVien
		where MaBM = 'HTTT')

--60

select DT.TenDT
from DeTai DT
where not exists(	select MaGV
					from GiaoVien GV, BoMon BM
					where GV.MaBM = BM.MaBM and BM.TenBM = N'Hệ thống thông tin'
					except
					select TG.MaGV
					from ThamGiaDT TG
					where TG.MaDT = DT.MaDT)

select DT.TenDT
from DeTai DT
where not exists (	select MaGV
					from GiaoVien GV, BoMon BM
					where GV.MaBM = BM.MaBM and BM.TenBM = N'Hệ thống thông tin'
					and not exists(	select MaDT
									from ThamGiaDT TG
									where TG.MaDT = DT.MaDT and GV.MaGV = TG.MaGV))

select DT.TenDT
from DeTai DT, GiaoVien GV, BoMon BM, ThamGiaDT TG
where DT.MaDT = TG.MaDT and GV.MaGV = TG.MaGV and GV.MaBM = BM.MaBM
and BM.TenBM= N'Hệ thống thông tin'
group by TG.MaDT, DT.TenDT
having COUNT(distinct TG.MaGV) = (	select COUNT(*)
									from GiaoVien GV2, BoMon BM2
									where GV2.MaBM = BM2.MaBM and BM2.TenBM = N'Hệ thống thông tin')
--61
select GV.MaGV, GV.HoTen
from GiaoVien GV
where not exists (	select DT.MaDT
					from ChuDe CD, DeTai DT
					where CD.MaCD = DT.MaCD and CD.MaCD = 'QLGD'
					except
					select MaDT
					from ThamGiaDT
					where MaGV = GV.MaGV)

select GV.MaGV, GV.HoTen
from GiaoVien GV
where not exists (	select *
					from ChuDe CD, DeTai DT
					where CD.MaCD = DT.MaCD and CD.MaCD = 'QLGD'
					and not exists (	select *
										from ThamGiaDT TG
										where TG.MaGV = GV.MaGV and TG.MaDT = DT.MaDT))


select GV.MaGV, GV.HoTen
from GiaoVien GV, DeTai DT, ThamGiaDT TG
where GV.MaGV = TG.MaGV and DT.MaDT = TG.MaDT
and DT.MaCD = 'QLGD'
group by GV.MaGV, GV.HoTen
having COUNT(distinct DT.MaDT) = (	select COUNT(*)
									from DeTai DT2
									where DT2.MaCD = 'QLGD')
									

--62
select GV.HoTen
from GiaoVien GV
where GV.HoTen != N'Trần Trà Hương'
and not exists(	select TG.MaDT
				from ThamGiaDT TG, GiaoVien GV2
				where TG.MaGV = GV2.MaGV and GV2.HoTen = N'Trần Trà Hương'
				except
				select TG2.MaDT
				from ThamGiaDT TG2
				where TG2.MaGV = GV.MaGV)


select GV.HoTen
from GiaoVien GV
where GV.HoTen != N'Trần Trà Hương'
and not exists(	select *
				from ThamGiaDT TG, GiaoVien GV2
				where TG.MaGV = GV2.MaGV and GV2.HoTen = N'Trần Trà Hương'
				and not exists(	select *
								from ThamGiaDT TG2
								where TG2.MaGV = GV.MaGV and TG2.MaDT = TG.MaDT))


select GV.HoTen
from GiaoVien GV join ThamGiaDT TG on (GV.MaGV = TG.MaGV)
join (	select TG2.MaDT
		from ThamGiaDT TG2 join GiaoVien GV2
		on (TG2.MaGV = GV2.MaGV)
		where GV2.HoTen = N'Trần Trà Hương') TTH
on (TTH.MaDT = TG.MaDT)
where GV.HoTen != N'Trần Trà Hương'
group by GV.MaGV, GV.HoTen
having COUNT(distinct TG.MaDT) = (	select COUNT(distinct DT.MaDT)
									from ThamGiaDT DT join GiaoVien GV
									on (DT.MaGV = GV.MaGV)
									where GV.HoTen = N'Trần Trà Hương')



--63
select DT.TenDT
from DeTai DT
where not exists(	select GV.MaGV
					from GiaoVien GV, BoMon BM
					where GV.MaBM = BM.MaBM and BM.TenBM = N'Hóa hữu cơ'
					except
					select TG.MaGV
					from ThamGiaDT TG
					where TG.MaDT = DT.MaDT)


select DT.TenDT
from DeTai DT
where not exists(	select *
					from GiaoVien GV, BoMon BM
					where GV.MaBM = BM.MaBM and BM.TenBM = N'Hóa hữu cơ'
					and not exists(	select *
									from ThamGiaDT TG
									where TG.MaDT = DT.MaDT and GV.MaGV = TG.MaGV))

select DT.TenDT
from DeTai DT, ThamGiaDT TG, GiaoVien GV, BoMon BM
where DT.MaDT = TG.MaDT and TG.MaGV = GV.MaGV and GV.MaBM = BM.MaBM
and BM.TenBM = N'Hóa hữu cơ'
group by DT.MaDT, DT.TenDT
having COUNT(distinct GV.MaGV) = (	select COUNT(GV.MaGV)
									from GiaoVien GV join BoMon BM
									on (GV.MaBM = BM.MaBM)
									where BM.TenBM = N'Hóa hữu cơ')

--64
select GV.HoTen
from GiaoVien GV
where not exists(	select CV.MaDT, CV.SoTT
					from CongViec CV
					where CV.MaDT = '006'
					except
					select TG.MaDT, TG.SoTT
					from ThamGiaDT TG
					where TG.MaGV = GV.MaGV)


select GV.HoTen
from GiaoVien GV
where not exists(	select *
					from CongViec CV
					where CV.MaDT = '006'
					and not exists(	select *
									from ThamGiaDT TG
									where TG.MaGV = GV.MaGV and TG.MaDT = CV.MaDT and TG.SoTT = CV.SoTT))

select GV.HoTen
from GiaoVien GV, CongViec CV, ThamGiaDT TG
where GV.MaGV = TG.MaGV and TG.MaDT = CV.MaDT and TG.SoTT = CV.SoTT and TG.MaDT = '006'
group by GV.MaGV, GV.HoTen
having COUNT(CV.SoTT) = (	select COUNT(*)
							from CongViec CV
							where CV.MaDT = '006')

--65
select distinct TG.MaGV
from ThamGiaDT TG
where not exists(	select DT.MaDT
					from DeTai DT, ChuDe CD
					where DT.MaCD = CD.MaCD and CD.MaCD = N'Ứng dụng công nghệ'
					except
					select TG2.MaDT
					from ThamGiaDT TG2
					where TG2.MaGV = TG.MaGV)


select distinct TG.MaGV
from ThamGiaDT TG
where not exists(	select *
					from DeTai DT, ChuDe CD
					where DT.MaCD = CD.MaCD and CD.MaCD = N'Ứng dụng công nghệ'
					and not exists(	select *
									from ThamGiaDT TG2
									where TG2.MaDT = DT.MaDT and TG2.MaGV = TG.MaGV))


select TG.MaGV
from ThamGiaDT TG, DeTai DT, ChuDe CD
where TG.MaDT = DT.MaDT and DT.MaCD = CD.MaCD and CD.TenCD = N'Ứng dụng công nghệ'
group by TG.MaGV
having COUNT(distinct DT.MaDT) = (	select COUNT(*)
									from DeTai DT, ChuDe CD
									where DT.MaCD = CD.MaCD and CD.TenCD = N'Ứng dụng công nghệ')


--66
select GV.HoTen
from GiaoVien GV
where GV.HoTen != N'Trần Trà Hương' and not exists(	select DT.MaDT
					from DeTai DT, GiaoVien GV2
					where DT.GVCNDT = GV2.MaGV and GV2.HoTen = N'Trần Trà Hương'
					except
					select TG.MaDT
					from ThamGiaDT TG
					where TG.MaGV = GV.MaGV)

select GV.HoTen
from GiaoVien GV
where GV.HoTen != N'Trần Trà Hương' and not exists(	
					select *
					from DeTai DT, GiaoVien GV2
					where DT.GVCNDT = GV2.MaGV and GV2.HoTen = N'Trần Trà Hương'
					and not exists(
									select *
									from ThamGiaDT TG
									where TG.MaGV = GV.MaGV and TG.MaDT = DT.MaDT))


select GV.HoTen
from GiaoVien GV join ThamGiaDT TG on (GV.MaGV = TG.MaGV)
join (	select DT.MaDT
		from DeTai DT join GiaoVien GV2
		on (DT.GVCNDT = GV2.MaGV)
		where GV2.HoTen = N'Trần Trà Hương') TTH
on (TTH.MaDT = TG.MaDT)
where GV.HoTen != N'Trần Trà Hương'
group by GV.MaGV, GV.HoTen
having COUNT(distinct TG.MaDT) = (	select COUNT(distinct DT.MaDT)
									from DeTai DT join GiaoVien GV
									on (DT.GVCNDT = GV.MaGV)
									where GV.HoTen = N'Trần Trà Hương')


--67
select DT.TenDT
from DeTai DT
where not exists(	select GV.MaGV
					from GiaoVien GV, BoMon BM
					where GV.MaBM = BM.MaBM and BM.MaKhoa = 'CNTT'
					except
					select TG.MaGV
					from ThamGiaDT TG
					where TG.MaDT = DT.MaDT)

select DT.TenDT
from DeTai DT
where not exists(	select *
					from GiaoVien GV, BoMon BM
					where GV.MaBM = BM.MaBM and BM.MaKhoa = 'CNTT'
					and not exists(	select *
									from ThamGiaDT TG
									where TG.MaDT = DT.MaDT and TG.MaGV = GV.MaGV))

select DT.TenDT
from DeTai DT, ThamGiaDT TG, GiaoVien GV, BoMon BM
where DT.MaDT = TG.MaDT and TG.MaGV = GV.MaGV and GV.MaBM = BM.MaBM and BM.MaKhoa = 'CNTT'
group by DT.MaDT, DT.TenDT
having COUNT(distinct GV.MaGV) = (	select COUNT(*)
									from GiaoVien GV, BoMon BM
									where GV.MaBM = BM.MaBM and BM.MaKhoa = 'CNTT')


--68
select GV.HoTen
from GiaoVien GV
where not exists(	select CV.MaDT, CV.SoTT
					from CongViec CV, DeTai DT
					where CV.MaDT = DT.MaDT and DT.TenDT = N'Nghiên cứu tế bào gốc'
					except
					select TG.MaDT, TG.SoTT
					from ThamGiaDT TG
					where TG.MaGV = GV.MaGV)


select GV.HoTen
from GiaoVien GV
where not exists(	select *
					from CongViec CV, DeTai DT
					where CV.MaDT = DT.MaDT and DT.TenDT = N'Nghiên cứu tế bào gốc'
					and not exists(	select *
									from ThamGiaDT TG
									where TG.MaGV = GV.MaGV and TG.MaDT = CV.MaDT and TG.SoTT = CV.SoTT))

select GV.HoTen
from GiaoVien GV, CongViec CV, ThamGiaDT TG, DeTai DT
where GV.MaGV = TG.MaGV and TG.MaDT = CV.MaDT and TG.SoTT = CV.SoTT and TG.MaDT = DT.MaDT and DT.TenDT = N'Nghiên cứu tế bào gốc'
group by GV.MaGV, GV.HoTen
having COUNT(CV.SoTT) = (	select COUNT(*)
							from CongViec CV, DeTai DT
							where CV.MaDT = DT.MaDT and DT.TenDT = N'Nghiên cứu tế bào gốc')


--69
select GV.MaGV, GV.HoTen
from GiaoVien GV
where not exists (	select DT.MaDT
					from DeTai DT
					where DT.KinhPhi > 100
					except
					select MaDT
					from ThamGiaDT
					where MaGV = GV.MaGV)

select GV.MaGV, GV.HoTen
from GiaoVien GV
where not exists (	select *
					from DeTai DT
					where DT.KinhPhi > 100
					and not exists (	select *
										from ThamGiaDT TG
										where TG.MaGV = GV.MaGV and TG.MaDT = DT.MaDT))


select GV.MaGV, GV.HoTen
from GiaoVien GV, DeTai DT, ThamGiaDT TG
where GV.MaGV = TG.MaGV and DT.MaDT = TG.MaDT and DT.KinhPhi > 100
group by GV.MaGV, GV.HoTen
having COUNT(distinct DT.MaDT) = (	select COUNT(*)
									from DeTai DT2
									where DT2.KinhPhi > 100)

--70
									
select DT.TenDT
from DeTai DT
where not exists(	select GV.MaGV
					from GiaoVien GV, BoMon BM, Khoa K
					where GV.MaBM = BM.MaBM and BM.MaKhoa = K.MaKhoa and K.TenKhoa = N'Sinh học'
					except
					select TG.MaGV
					from ThamGiaDT TG
					where TG.MaDT = DT.MaDT)

select DT.TenDT
from DeTai DT
where not exists(	select *
					from GiaoVien GV, BoMon BM, Khoa K
					where GV.MaBM = BM.MaBM and BM.MaKhoa = K.MaKhoa and K.TenKhoa = N'Sinh học'
					and not exists(	select *
									from ThamGiaDT TG
									where TG.MaDT = DT.MaDT and TG.MaGV = GV.MaGV))

select DT.TenDT
from DeTai DT, ThamGiaDT TG, GiaoVien GV, BoMon BM, Khoa K
where DT.MaDT = TG.MaDT and TG.MaGV = GV.MaGV and GV.MaBM = BM.MaBM and BM.MaKhoa = K.MaKhoa and K.TenKhoa = N'Sinh học'
group by DT.MaDT, DT.TenDT
having COUNT(distinct GV.MaGV) = (	select COUNT(*)
									from GiaoVien GV, BoMon BM, Khoa K
									where GV.MaBM = BM.MaBM and BM.MaKhoa = K.MaKhoa and K.TenKhoa = N'Sinh học')

--71
select GV.MaGV, GV.HoTen, GV.NgaySinh
from GiaoVien GV
where not exists(	select CV.MaDT, CV.SoTT
					from CongViec CV, DeTai DT
					where CV.MaDT = DT.MaDT and DT.TenDT = N'Ứng dụng hóa học xanh'
					except
					select TG.MaDT, TG.SoTT
					from ThamGiaDT TG
					where TG.MaGV = GV.MaGV)


select GV.MaGV, GV.HoTen, GV.NgaySinh
from GiaoVien GV
where not exists(	select *
					from CongViec CV, DeTai DT
					where CV.MaDT = DT.MaDT and DT.TenDT = N'Ứng dụng hóa học xanh'
					and not exists(	select *
									from ThamGiaDT TG
									where TG.MaGV = GV.MaGV and TG.MaDT = CV.MaDT and TG.SoTT = CV.SoTT))

select GV.MaGV, GV.HoTen, GV.NgaySinh
from GiaoVien GV, CongViec CV, ThamGiaDT TG, DeTai DT
where GV.MaGV = TG.MaGV and TG.MaDT = CV.MaDT and TG.SoTT = CV.SoTT and TG.MaDT = DT.MaDT and DT.TenDT = N'Ứng dụng hóa học xanh'
group by GV.MaGV, GV.HoTen, GV.NgaySinh
having COUNT(CV.SoTT) = (	select COUNT(*)
							from CongViec CV, DeTai DT
							where CV.MaDT = DT.MaDT and DT.TenDT = N'Ứng dụng hóa học xanh')

select GV.MaGV, GV.HoTen, BM.TenBM, GVQL.HoTen as HoTenGVQL
from GiaoVien GV left join GiaoVien GVQL on (GV.GVQLCM = GVQL.MaGV) join BoMon BM on (GV.MaBM = BM.MaBM)
where not exists(	select DT.MaDT
					from DeTai DT, ChuDe CD
					where DT.MaCD = CD.MaCD and CD.TenCD = N'Nghiên cứu phát triển'
					except
					select TG.MaDT
					from ThamGiaDT TG
					where TG.MaGV = GV.MaGV)


select GV.MaGV, GV.HoTen, BM.TenBM, GVQL.HoTen as HoTenGVQL
from GiaoVien GV left join GiaoVien GVQL on (GV.GVQLCM = GVQL.MaGV) join BoMon BM on (GV.MaBM = BM.MaBM)
where not exists(	select *
					from DeTai DT, ChuDe CD
					where DT.MaCD = CD.MaCD and CD.TenCD = N'Nghiên cứu phát triển'
					and not exists(	select TG.MaDT
									from ThamGiaDT TG
									where TG.MaGV = GV.MaGV and DT.MaDT = TG.MaDT))


select GV.MaGV, GV.HoTen, BM.TenBM, GVQL.HoTen as HoTenGVQL
from GiaoVien GV left join GiaoVien GVQL on (GV.GVQLCM = GVQL.MaGV) join BoMon BM on (GV.MaBM = BM.MaBM), ThamGiaDT TG, ChuDe CD, DeTai DT
where GV.MaGV = TG.MaGV and TG.MaDT = DT.MaDT and DT.MaCD = CD.MaCD and CD.TenCD = N'Nghiên cứu phát triển'
group by GV.MaGV, GV.HoTen, BM.TenBM, GVQL.HoTen
having COUNT(distinct DT.MaDT) = (select COUNT(*)
									from DeTai DT, ChuDe CD
									where DT.MaCD = CD.MaCD and CD.TenCD = N'Nghiên cứu phát triển')

					