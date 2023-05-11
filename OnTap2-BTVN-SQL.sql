drop database QUANLYDULICH
go
create database QUANLYDULICH
go
use QUANLYDULICH
go

--Creating tables and their primary keys
create table TINH_TP
(
	QuocGia varchar(10),
	MaTinhThanh varchar(10),
	TenTT nvarchar(30),
	SoDan int,
	DienTich float,
	DiemDLUaThichNhat varchar(10)
	constraint PK_TINH_TP primary key(MaTinhThanh, QuocGia)
)

create table QUOCGIA
(
	MaQG varchar(10),
	TenQG nvarchar(30),
	ThuDo varchar(10)
	constraint PK_QUOCGIA primary key(MaQG)
)

create table DIEM_DL
(
	MaDiaDiem varchar(10),
	TenDiaDiem nvarchar(50),
	TinhTP varchar(10),
	QuocGia varchar(10),
	DacDiem nvarchar(100)
	constraint PK_DIEM_DL primary key(MaDiaDiem, TinhTP, QuocGia)
)

--Create foreign keys
alter table TINH_TP
add constraint FK_TTP_QG
foreign key(QuocGia)
references QUOCGIA(MaQG)

alter table TINH_TP
add constraint FK_TTP_DDL
foreign key(DiemDLUaThichNhat, MaTinhThanh, QuocGia)
references DIEM_DL(MaDiaDiem, TinhTP, QuocGia)

alter table QUOCGIA
add constraint FK_QG_TTP
foreign key(ThuDo, MaQG)
references TINH_TP(MaTinhThanh, QuocGia)

alter table DIEM_DL
add constraint FK_DDL_TTP
foreign key(TinhTP, QuocGia)
references TINH_TP(MaTinhThanh, QuocGia)

alter table DIEM_DL
add constraint FK_DDL_QG
foreign key(QuocGia)
references QUOCGIA(MaQG)

--Create other biddings
alter table TINH_TP
add constraint CHK_TTP_SoDan
check (SoDan > 0)

alter table TINH_TP
add constraint CHK_TTP_DienTich
check (DienTich > 0)

alter table QUOCGIA
add constraint UQ_QG_TenQG
unique (TenQG)

--insert values
insert into QUOCGIA(MaQG, TenQG)
values('QG001', N'Việt Nam')
insert into QUOCGIA(MaQG, TenQG)
values('QG002', N'Nhật Bản')

insert into TINH_TP(QuocGia, MaTinhThanh, TenTT, SoDan, DienTich)
values('QG001', 'TT001', N'Hà Nội', 2500000, 927.39)
insert into TINH_TP(QuocGia, MaTinhThanh, TenTT, SoDan, DienTich)
values('QG001', 'TT002', N'Huế', 5344000, 5009)
insert into TINH_TP(QuocGia, MaTinhThanh, TenTT, SoDan, DienTich)
values('QG002', 'TT001', 'Tokyo', 12084000, 2187)
insert into TINH_TP(QuocGia, MaTinhThanh, TenTT, SoDan, DienTich)
values('QG002', 'TT002', 'Osaka', 18000000, 22196)

insert into DIEM_DL(MaDiaDiem, TenDiaDiem, TinhTP, QuocGia, DacDiem)
values('DD001', N'Văn Miếu', 'TT001', 'QG001', N'Di tích cổ')
insert into DIEM_DL(MaDiaDiem, TenDiaDiem, TinhTP, QuocGia, DacDiem)
values('DD001', N'Hoàng Lăng', 'TT002', 'QG001', N'Di tích cổ')
insert into DIEM_DL(MaDiaDiem, TenDiaDiem, TinhTP, QuocGia, DacDiem)
values('DD001', N'Núi Fuji', 'TT001', 'QG002', N'Núi lửa ngưng hoạt động cao nhất Nhật Bản')
insert into DIEM_DL(MaDiaDiem, TenDiaDiem, TinhTP, QuocGia, DacDiem)
values('DD001', 'Minami', 'TT002', 'QG002', N'quê hương của cây cầu Shinsaibashi')
insert into DIEM_DL(MaDiaDiem, TenDiaDiem, TinhTP, QuocGia, DacDiem)
values('DD002', N'Lâu đài Osaka', 'TT002', 'QG002', N'Chứa bảo tàng thông tin lịch sử của lâu đài và Toyotomi Hideyoshi')

-- update foreign keys
update QUOCGIA
set ThuDo = 'TT001'
where MaQG = 'QG001'
update QUOCGIA
set ThuDo = 'TT001'
where MaQG = 'QG002'

update TINH_TP
set DiemDLUaThichNhat = 'DD001'
where QuocGia = 'QG001' and MaTinhThanh='TT001'
update TINH_TP
set DiemDLUaThichNhat='DD001'
where QuocGia='QG001' and MaTinhThanh='TT002'
update TINH_TP
set DiemDLUaThichNhat='DD001'
where QuocGia='QG002' and MaTinhThanh='TT001'
update TINH_TP
set DiemDLUaThichNhat='DD001'
where QuocGia='QG002' and MaTinhThanh='TT002'
