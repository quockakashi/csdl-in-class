use QLTHAMGIADETAI
go


--Q35
select distinct LUONG as LuongCaoNhat
from GIAOVIEN
where LUONG >= (select MAX(LUONG)
				from GIAOVIEN)

--Q36
select *
from GIAOVIEN
where LUONG >= (select MAX(LUONG)
				from GIAOVIEN)

--Q37
select LUONG as LuongCaoNhatHTTT
from GIAOVIEN
where MABM = 'HTTT' and LUONG >= all (select LUONG
										from GIAOVIEN
										where MABM = 'HTTT')
--Q38
select HOTEN, ROUND(DATEDIFF(D, NGAYSINH, GETDATE()) / 365, 0) as Tuoi
from (select GV.*
		from GIAOVIEN GV join BOMON BM on (GV.MABM = BM.MABM)
		where BM.TENBM = N'Hệ thống thông tin') GV
where DATEDIFF(D, NGAYSINH, GETDATE()) >= 
(select MAX(DATEDIFF(D, NGAYSINH, GETDATE()))
	from (select GV.*
		from GIAOVIEN GV join BOMON BM on (GV.MABM = BM.MABM)
		where BM.TENBM = N'Hệ thống thông tin') GV)


--Q39
select HOTEN, ROUND(DATEDIFF(D, NGAYSINH, GETDATE()) / 365, 0) as Tuoi
from (select GV.*
		from GIAOVIEN GV join BOMON BM on (GV.MABM = BM.MABM)
		where BM.TENBM = N'Công nghệ thông tin') GV
where DATEDIFF(D, NGAYSINH, GETDATE()) <= 
(select MAX(DATEDIFF(D, NGAYSINH, GETDATE()))
	from (select GV.*
		from GIAOVIEN GV join BOMON BM on (GV.MABM = BM.MABM)
		where BM.TENBM = N'Công nghệ thông tin') GV)

--Q40
select GV.HOTEN, K.TENKHOA
from GIAOVIEN GV join BOMON BM on (GV.MABM = BM.MABM)
join KHOA K on (BM.MAKHOA = K.MAKHOA)
where GV.LUONG >= all (select LUONG
						from GIAOVIEN)

--Q41
select GV.*
from GIAOVIEN GV
where LUONG >= all (select LUONG
						from GIAOVIEN
						where MABM = GV.MABM)
--Q42
select DT.TENDT
from (	select *
		from DETAI
		except
		select distinct DT.*
		from GIAOVIEN GV join THAMGIADT TG
		on (GV.MAGV = TG.MADT) join DETAI DT on(TG.MADT = DT.MADT)
		where GV.HOTEN = N'Nguyễn Hoài An') DT

--Q43
select DT.TenDT, GV.HoTen as TenCNDT
from (select MaDT
		from DeTai
		except
		select distinct TG.MaDT
		from GiaoVien GV join ThamGiaDT TG on (GV.MaGV = TG.MaGV)
		where GV.HoTen = N'Nguyễn Hoài An') MDT join DeTai DT
		on(MDT.MaDT = DT.MaDT) join GiaoVien GV on (DT.GVCNDT = GV.MaGV)