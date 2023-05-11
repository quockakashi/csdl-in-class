create database SUPERSEAGAME
go
use SUPERSEAGAME
go

--Tạo bảng và các khóa chính
create table DoiBong
(
	MaDoi varchar(10),
	TenQuocGia nvarchar(30)
	constraint PK_DoiBong primary key (MaDoi)
)

create table TranDau
(
	MaTD varchar(10),
	MaDoi1 varchar(10),
	MaDoi2 varchar(10),
	SanVD nvarchar(50),
	NgayTD datetime,
	ThanhPho nvarchar(50)
	constraint PK_TranDau primary key(MaTD)
)

create table ThamGia
(
	MaTD varchar(10),
	MaDoi varchar(10),
	MaSo varchar(10),
	HoTen nvarchar(50),
	NgaySinh datetime,
	PhutVaoSan int,
	PhutRoiSan int,
	ViTriTD nvarchar(20)
	constraint PK_ThamGia primary key(MaTD, MaDoi, MaSo)
)

-- tạo khóa ngoại
alter table TranDau
add constraint FK_TD_DB
foreign key(MaDoi1)
references DoiBong(MaDoi)

alter table TranDau
add constraint FK_TD_DB_2
foreign key(MaDoi2)
references DoiBong(MaDoi)

alter table ThamGia
add constraint FK_TG_TD
foreign key(MaTD)
references TranDau(MaTD)

alter table ThamGia
add constraint FK_TG_DB
foreign key(MaDoi)
references DoiBong(MaDoi)

--Ràng buộc dữ liệu
alter table ThamGia
add constraint C_TG_ViTri check (ViTriTD in (N'tiền đạo', N'hậu vệ', N'thủ môn', N'tiền vệ'))

alter table ThamGia
add constraint C_TG_PhutVaoSan check (PhutVaoSan >= 0)

alter table ThamGia
add constraint C_TG_PhutRoiSan check (PhutRoiSan >= 0)
--Truy vấn
--Q1
select TG.MaDoi, MaSo, HoTen, NgaySinh
from ThamGia TG join TranDau TD on (TG.MaTD = TD.MaTD)
join (select MaDoi
		from DoiBong
		where TenQuocGia = N'VIỆT NAM') DB1 on (TD.MaDoi1 = DB1.MaDoi)
join (select MaDoi
		from DoiBong
		where TenQuocGia = N'THÁI LAN') DB2 on (TD.MaDoi2 = DB2.MaDoi)
where TG.ViTriTD = N'hậu vệ' and TD.NgayTD = '2022-04-30'

--Q2. Cho biết cầu thủ  đã tham gia nhiều trận nhất
select MaSo, MaDoi, HoTen as TenCTTGNhieuNhat
from ThamGia TG
group by MaSo, MaDoi, HoTen
having COUNT(distinct MaTD) >= all (select COUNT(distinct MaTD)
							from ThamGia 
							group by MaSo, MaDoi)