--21120317 - Nguyễn Phan Anh Quốc
use QLTHAMGIADETAI
go

--Q1
select Hoten, Luong
from GiaoVien
where Phai = N'Nữ'

--Q2
select HoTen, Luong * 1.1 as LuongTang10PT
from GiaoVien

--Q3
select MaGV
from GiaoVien
where HoTen like N'Nguyễn%' and Luong > 2000


--Q4
select GV.HoTen
from GiaoVien GV join BoMon BM on (GV.MaBM = BM.MaBM)
join Khoa K on(BM.MaKhoa = K.MaKhoa)
where K.TenKhoa = N'Công nghệ thông tin'

--Q5
select BM.MaKhoa, BM.TenBM , GV.MaGV as MaTruongPhong, GV.HoTen as TenTruongTrong
from BoMon BM left join GiaoVien GV on (BM.TruongBM = GV.MaGV)

--Q6
select GV.MaGV, GV.HoTen, BM.MaBM, BM.TenBM
from GiaoVien GV left join BoMon BM on (GV.MaBM = BM.MaBM)

--Q7
select DT.MaDT, DT.TenDT, GV.MaGV as MAGVCNDT, GV.HoTen as GVCNDT
from DeTai DT left join GiaoVien GV on  (DT.GVCNDT = GV.MaGV)

--Q8
select K.MaKhoa, K.TenKhoa, GV.MaGV as MaTruongKhoa, GV.HoTen as TenTruongKhoa
from Khoa K left join GiaoVien GV on (K.TruongKhoa = GV.MaGV)

--Q9
select distinct GV.*
from (select GV.*
		from GiaoVien GV, BoMon BM
		where BM.TenBM = N'Vi sinh' and GV.MaBM = BM.MaBM) GV, ThamGiaDT TG
where GV.MaGV = TG.MaGV and TG.MaDT = '006'

--Q10
select DT.MaDT, DT.TenDT, DT.MaCD, DT.GVCNDT, GV.HoTen as TenCNDT, GV.NgaySinh, GV.DiaChi
from (select *
		from DeTai
		where DeTai.CapQL != N'Quốc gia') DT join
		GiaoVien GV on (DT.GVCNDT = GV.MaGV)

--Q11
select GV.MaGV, GV.HoTen, QL.GVQLCM, QL.HoTen
from GiaoVien GV left join GiaoVien QL on (GV.MaGV = QL.GVQLCM)

--Q12
select GV.HoTen
from GiaoVien GV join 
				(select MaGV
				from GiaoVien
				where HoTen = N'Nguyễn Thanh Tùng') GVQL
				on (GV.GVQLCM = GVQL.MaGV)

--Q13
select GV.HoTen
from GiaoVien GV join 
				(select TruongBM
				from BoMon
				where TenBM = N'Hệ thống thông tin') TBM
				on (GV.GVQLCM = TBM.TruongBM)

--Q14
select GV.HoTen
from GiaoVien GV join 
				(select distinct GVCNDT
				from DeTai
				where MaCD = N'QLGD') GVCN
				on (GV.GVQLCM = GVCN.GVCNDT)

--Q15
select CV.TenCV
from CongViec CV join 
					(select MaDT
					from DeTai
					where TenDT = N'HTTT quản lý các trường ĐH') MDT
on (CV.MaDT = MDT.MaDT)
where CV.NgayBD between '2008-03-01' and '2008-03-31'

--Q16
select GV.MaGV, GV.HoTen, QL.GVQLCM, QL.HoTen
from GiaoVien GV left join GiaoVien QL on (GV.MaGV = QL.GVQLCM)

--Q17
select *
from CongViec
where NgayBD between '2007-01-01' and '2007-08-01'

--Q18
select GV.HoTen
from GiaoVien GV join 
					(select BM.MaBM
					from BoMon BM, GiaoVien TTH
					where BM.MaBM = TTH.MaBM and TTH.HoTen = N'Trần Trà Hương') MBM
on GV.MaBM = MBM.MaBM
except 
select HoTen
from GiaoVien
where HoTen = N'Trần Trà Hương'

--Q19
select GV.*
from GiaoVien GV join
					(select distinct BM.TruongBM
					from BoMon BM, DeTai DT
					where BM.TruongBM = DT.GVCNDT) MGV
on (GV.MaGV = MGV.TruongBM)

--Q20
select GV.*
from GiaoVien GV join
					(select distinct BM.TruongBM
					from BoMon BM, Khoa K
					where BM.TruongBM = K.TruongKhoa) MGV
on (GV.MaGV = MGV.TruongBM)

--Q21
select GV.HoTen
from GiaoVien GV join
					(select distinct BM.TruongBM
					from BoMon BM, DeTai DT
					where BM.TruongBM = DT.GVCNDT) MGV
on (GV.MaGV = MGV.TruongBM)

--Q22
select distinct K.TruongKhoa
from Khoa K, DeTai DT
where K.TruongKhoa = DT.GVCNDT

--Q23
select GV.MaGV
from GiaoVien GV join BoMon BM on (GV.MaBM = BM.MaBM)
where BM.TenBM = N'Hệ thống thông tin'
union
select distinct GV.MaGV
from GiaoVien GV join ThamGiaDT TG on (GV.MaGV = TG.MaGV)
where TG.MaDT = '007'

--Q24
select GV.*
from GiaoVien GV join 
				(select GV.MaBM
				from GiaoVien GV, BoMon BM
				where GV.MaGV = '002' and GV.MaBM = BM.MaBM) MBM
on (GV.MaBM = MBM.MaBM)
except
select *
from GiaoVien
where MaGV='002'

--Q25
select distinct GV.*
from GiaoVien GV, BoMon BM
where GV.MaGV = BM.TruongBM

--Q26
select HoTen, Luong
from GiaoVien