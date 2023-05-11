--Nguyễn Phan Anh Quốc - 21120317
use QLBanHangSieuThi
go

--Q22. Cho biết số lượng khách hàng của từng phái
select GioiTinh, COUNT(*) as SoLuongKH
from KhachHang
group by GioiTinh

--Q23. Cho biết số lượng khách hàng ở từng tỉnh thành
select DiaChi, COUNT(*) as SoLuongKH
from KhachHang 
group by DiaChi

--Q24. Cho biết Tỉnh thành có nhiều khách hàng nhất
select DiaChi as TinhThanhNhieuKHNhat
from KhachHang
group by DiaChi
having COUNT(*) >= all (select COUNT(*)
						from KhachHang
						group by DiaChi)

--Q25. Cho tên, địa chỉ, điện thoại biết khách hàng cao tuổi nhất
select HoTen as KHLonTuoiNhat, DiaChi, DienThoai
from KhachHang
where NamSinh <= all (select NamSinh
						from KhachHang)

--Q26. Cho biết số lượng khách hàng sinh ra trong từng năm
select NamSinh, COUNT(*) as SoLuongKH
from KhachHang
group by NamSinh

--Q27. Cho biết mã khách hàng chưa từng mua hàng
select MaKH as MaKHChuaMuaSP
from KhachHang
except
select distinct MaKH
from HoaDon

--Q28. Cho biết mã khách hàng và tên của nhưng khách hàng chưa từng mua hàng
select KH.HoTen, KH.MaKH
from KhachHang KH join
	(select MaKH
	from KhachHang
	except
	select MaKH
	from HoaDon) KHCM on (KH.MaKH = KHCM.MaKH)


--Q29. Cho biết mã khách hàng và số lần mua của khách đó
select KH.MaKH, COUNT(HD.MaHD) as SoLanMua
from KhachHang KH left join HoaDon HD on(KH.MaKH = HD.MaKH)
group by KH.MaKH

--Q30. Cho biết mã khách hàng, tên và số lần mua hàng của mỗi khách hàng
select KH.MaKH, KH.HoTen, COUNT(HD.MaHD) as SoLanMua
from KhachHang KH left join HoaDon HD on(KH.MaKH = HD.MaKH)
group by KH.MaKH, KH.HoTen

--Q31. Cho biết mã khách hàng của khách hàng nhiều lần nhất
select MaKH as MaKHMuaNhieuNhat
from HoaDon
group by MaKH
having COUNT(*) >=all (select COUNT(*)
						from HoaDon
						group by MaKH)

--Q32. Cho biết mã khách hàng và tên cuẩ những khách hàng mua hàng nhiều nhất
select KH.MaKH as MaKHMuaNhieuNhat, KH.HoTen
from KhachHang KH join HoaDon HD on(KH.MaKH = HD.MaKH)
group by KH.MaKH, KH.HoTen
having COUNT(*) >=all (select COUNT(*)
						from HoaDon
						group by MaKH)