use QLTHAMGIADETAI
-- phép chia
-- tìm các giảng viên tham gia tất cả đề tài
--R: ThamGiaDT (MAGV, MADT)
--S: DeTai(MADT)
--KQ: MAGV

-- Xét từng MAGV i trong R, sao cho
-- tìm các đề tài mà gv i chưa tham gia
-- nếu tìm thấy: gv i không tham gia tất cả đề tài
-- nếu không tìm thấy: gv i tham gia tất cả
select MaGV
from ThamGiaDT R
where not exists (
    select MaDT from DeTai
    except
    select MaDT from ThamGiaDT TG where TG.MaGV = R.MaGV
)
--ds các đề tài mà gv i chưa tham gia ds
--c1: except
-- tìm ds các madt S
--except
--ds các madt và gvi đã tham gia

--cách 2: dùng not exit
SELECT MaGV
FROM ThamGiaDT R
WHERE NOT exists (
            select MaDT from DeTai S
            where not exists (
                        select MaDT
                        from ThamGiaDT TG 
                        where tg.MaGV = R.MaGV AND
                        tg.MaDT = s.MaDT
            )
)

--Tìm ds các gv (maGv, HoTen) tham gia tất cả đề tài cấp trường

--C1
select r.MaGV, HoTen
from ThamGiaDT R join GiaoVien gv on gv.MaGV = R.MaGV
where not exists(
    select MaDT from DeTai where CapQL = N'Trường'
    except
    select MaDT from ThamGiaDT tg where tg.MaGV = R.MaGV
)

--C4: group by having
--với mỗi gv có tham gia đề tài (R)
--Đếm số đề tài cấp trường tham gia của mỗi gv này
-- đếm số đề tài cấp trường
select MaGV
from ThamGiaDT TG join DeTai DT on(TG.MaDT = DT.MaDT)
where CapQL = N'Trường'
group by TG.MaGV
having COUNT(distinct TG.MADT) = (select COUNT(*)
					from DeTai
					group by CapQL
					having CapQL=N'Trường')
--Q58. Cho biết tên giáo viên tham gia đề tài đủ tất cả chủ đề
--R: ThamgiaDT(MAGV, MaDT)
--S: Tất cả chủ đề (DeTai(MaDT, MaCD))
--KQ: MaGV

select MaGV
from ThamGiaDT R
where not exists(
		select MaCD from ChuDe S
		except
		select MaCD from ThamGiaDT TG join DeTai DT on TG.MaDT = DT.MaDT
		where TG.MaGV = R.MaGV)

select R.MaGV, HoTen
from ThamGiaDT R join GiaoVien GV on R.MaGV = GV.MaGV
where not exists(
		select MaCD from ChuDe S
		where not exists (
			select MaCD from ThamGiaDT TG join DeTai DT on TG.MaDT = DT.MaDT
			where TG.MaGV = R.MaGV and S.MaCD = DT.MaCD))

-- Với mỗi bộ môn, cho biết lương trung bình của bộ môn
-- Gom nhóm (GiaoVien)
-- AVG(Luong) mỗi nhóm
-- MaBM Luong TB
