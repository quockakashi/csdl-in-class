use QUANLYGIAOVIENTHAMGIADETAI
go

--Q27
select COUNT(*) as TongSoGV, SUM(Luong) as TongLuong
from GiaoVien

--Q28
select MaBM, COUNT(*) as TongSoGV, SUM(Luong) as TongLuong
from GIAOVIEN
group by MABM

--Q29
select CD.TENCD, COUNT(*) as SoDT
from CHUDE CD join DETAI DT on (CD.MACD = DT.MACD)
group by CD.MACD, CD.TenCD

--Q30
select GV.HOTEN, COUNT(*) as SoDTTG
from GIAOVIEN GV join (select distinct MaGV, MaDT
						from THAMGIADT TG) TG
on(GV.MAGV = TG.MAGV)
group by GV.MAGV, GV.HOTEN

--Q31
select GV.HOTEN, COUNT(*) as SoDTCN
from GIAOVIEN GV join DETAI DT on (GV.MAGV = DT.GVCNDT)
group by GV.MAGV, GV.HOTEN

--Q32
select GV.HOTEN, COUNT(NT.TEN) as SoNguoiThan
from GIAOVIEN GV left join NGUOI_THAN NT on (GV.MAGV = NT.MAGV)
group by GV.MAGV, GV.HOTEN

--Q33
select GV.HOTEN as GVCoSoDTHon3, COUNT(*) as SoDT
from GIAOVIEN GV join (select distinct MAGV, MADT
						from THAMGIADT) TG
on (GV.MAGV = TG.MAGV)
group by GV.MAGV, GV.HOTEN
having COUNT(*) >= 3

--Q34
select COUNT(*) as SoGV
from GIAOVIEN GV join THAMGIADT TG on (GV.MAGV = TG.MAGV)
join (select MaDT, TenDT
		from DETAI 
		where TENDT = N'Ứng dụng hóa học xanh') DT on (TG.MADT = DT.MADT)
group by GV.MaGV