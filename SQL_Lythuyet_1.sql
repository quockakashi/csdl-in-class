--21120317 Nguyễn Phan Anh Quốc
use QLBHSIEUTHI
go
--Q1
select MaSP, TenSP, GiaTien, DvTinh
from SanPham
where GiaTien > 100

--Q2
select SP.*
from SanPham SP join 
	(
	select MaLoai
	from LoaiSanPham
	where TenLoai=N'Đồ dùng'
	)
--Q3
select TenSP, GiaTien
from SanPham 
where TenSP like N'Bàn chải%'

--Q4
select TenSP, TenLoai
from SanPham as SP, LoaiSanPham as LSP
where SP.maLoai = LSP.maLoai

--Q5
select SP.TenSP, LSP.TenLoai
from SanPham SP join LoaiSanPham LSP on SP.MaLoai = LSP.MaLoai
where SP.SoLuongTon > 50

--Q6
select *
from SanPham
where DvTinh = N'Túi'

--Q7
select LSP.tenLoai
from SanPham SP join LoaiSanPham LSP on SP.MaLoai = LSP.MaLoai
where SP.tenSP = N'Bột giặt OMO'

--Q8
select TenSP
from SanPham
where GiaTien = MIN(GiaTien)

--Q9
select TenSP
from SanPham
where GiaTien = MAX(GiaTien)


