CREATE DATABASE DB_SieuThi
GO

USE DB_SieuThi
GO

CREATE TABLE NhanVien
(
	ma NVARCHAR(10) PRIMARY KEY,
	ten NVARCHAR(50),
	maLoai NVARCHAR(10),
	maTaiKhoan VARCHAR(10)
)
GO

CREATE TABLE LoaiNV
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenLoai NVARCHAR(50)
)
GO

CREATE TABLE HoaDon
(
	ma NVARCHAR(10) PRIMARY KEY,
	ngay DATETIME,
	tongTien DECIMAL,
	maKhachHang NVARCHAR(10)
)
GO

CREATE TABLE ChiTietHoaDon
(
	maHoaDon NVARCHAR(10) ,
	maMatHang NVARCHAR(10)

	PRIMARY KEY (maHoaDon,maMatHang)
)
GO

CREATE TABLE MatHang
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenMatHang NVARCHAR(50),
	soLuongTon INT,
	donGia DECIMAL,
	maLoaiMatHang NVARCHAR(10),
	donViTinh NVARCHAR(30)

)
GO

CREATE TABLE QuayHang
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenQuay NVARCHAR(50),
	maNhanVien NVARCHAR(10)
	
)
GO

CREATE TABLE QuayHang_MatHang
(
	maQuayHang NVARCHAR(10),
	maMatHang NVARCHAR(10),
	soLuongTon INT

	PRIMARY KEY(maQuayHang,maMatHang)
)
GO

CREATE TABLE QuayHang_HoaDon
(
	maQuayHang NVARCHAR(10),
	maHoaDon NVARCHAR(10),
	tongTien DECIMAL

	PRIMARY KEY (maQuayHang,maHoaDon)
)
GO

CREATE TABLE KhachHang
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenKhachHang NVARCHAR(50),
	maLoai NVARCHAR(10)
)
GO

CREATE TABLE LoaiKH
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenLoaiKhachHang NVARCHAR(50)
)
GO

CREATE TABLE DiemThuong
(
	maKhachHang NVARCHAR(10) PRIMARY KEY,
	diem INT
)
GO

CREATE TABLE UuDai
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenLoaiUuDai NVARCHAR(100),
	mucTongTien DECIMAL, -- Mức tông tiền tối thiểu để đc công điểm
	mucDiem INT, -- Mức điểm tối thiểu để đc giảm giá
	diemCong INT,-- Số điểm cộng khi đạt mức tổng tiền
	giamGia INT CHECK(giamGia >0 AND giamGia <= 100)

)
GO



CREATE TABLE KhoHang
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenKho NVARCHAR(50)
)
GO

CREATE TABLE KhoHang_MatHang
(
	maKhoHang NVARCHAR(10),
	maMatHang NVARCHAR(10),
	soLuongTon INT
)
GO

CREATE TABLE NhapHang
(
	ma NVARCHAR(10) PRIMARY KEY,
	ngayNhap DATETIME,
	tongTien DECIMAL
)
GO

CREATE TABLE ChiTietNhapHang
(
	maNhapHang NVARCHAR(10),
	maMatHang NVARCHAR(10),
	soLuong INT

	PRIMARY KEY(maNhapHang,maMatHang)
	
)
GO

CREATE TABLE XuatHang
(
	ma NVARCHAR(10) PRIMARY KEY,
	ngayXuat DATETIME,
	tongTien DECIMAL
)
GO

CREATE TABLE ChiTietXuatHang
(
	maXuatHang NVARCHAR(10),
	maMatHang NVARCHAR(10),
	maQuayHang NVARCHAR(10),
	soLuong INT,
	
	PRIMARY KEY (maXuatHang,maMatHang,maQuayHang)
)
GO

CREATE TABLE TaiKhoan
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenTaiKhoan VARCHAR(16),
	matKhau VARCHAR(16),
	maLoaiNV NVARCHAR(10)
)
GO

CREATE TABLE LoaiMH
(
	ma NVARCHAR(10) PRIMARY KEY,
	tenLoaiMH NVARCHAR(50)
)
GO

ALTER TABLE dbo.NhanVien ADD FOREIGN KEY (maLoai) REFERENCES dbo.LoaiNV(ma)
ALTER TABLE dbo.HoaDon ADD FOREIGN KEY (maKhachHang) REFERENCES dbo.KhachHang(ma)
ALTER TABLE dbo.ChiTietHoaDon ADD FOREIGN KEY (maHoaDon) REFERENCES dbo.HoaDon(ma)
ALTER TABLE dbo.ChiTietHoaDon ADD FOREIGN KEY (maMatHang) REFERENCES dbo.MatHang(ma)
ALTER TABLE dbo.ChiTietNhapHang ADD FOREIGN KEY(maNhapHang) REFERENCES dbo.NhapHang(ma)
ALTER TABLE dbo.ChiTietNhapHang ADD FOREIGN KEY(maMatHang) REFERENCES dbo.MatHang(ma)
ALTER TABLE dbo.ChiTietXuatHang ADD FOREIGN KEY (maXuatHang)REFERENCES dbo.XuatHang(ma)
ALTER TABLE dbo.ChiTietXuatHang ADD FOREIGN KEY (maMatHang) REFERENCES dbo.MatHang(ma)
ALTER TABLE dbo.ChiTietXuatHang ADD FOREIGN KEY (maQuayHang) REFERENCES dbo.QuayHang(ma)
ALTER TABLE dbo.DiemThuong ADD FOREIGN KEY (maKhachHang) REFERENCES dbo.KhachHang(ma)
ALTER TABLE dbo.QuayHang ADD FOREIGN KEY (maNhanVien) REFERENCES dbo.NhanVien(ma)
ALTER TABLE dbo.QuayHang_MatHang ADD FOREIGN KEY(maQuayHang) REFERENCES dbo.QuayHang(ma)
ALTER TABLE dbo.QuayHang_MatHang ADD FOREIGN KEY(maMatHang)REFERENCES dbo.MatHang(ma)
ALTER TABLE dbo.QuayHang_HoaDon ADD FOREIGN KEY (maQuayHang)REFERENCES dbo.QuayHang(ma)
ALTER TABLE dbo.QuayHang_HoaDon ADD FOREIGN KEY (maHoaDon)REFERENCES dbo.HoaDon(ma)
ALTER TABLE dbo.KhachHang ADD FOREIGN KEY (maLoai) REFERENCES dbo.LoaiKH(ma)
ALTER TABLE dbo.KhoHang_MatHang ADD FOREIGN KEY (maKhoHang) REFERENCES dbo.KhoHang(ma)
ALTER TABLE dbo.KhoHang_MatHang ADD FOREIGN KEY (maMatHang) REFERENCES dbo.MatHang(ma)
ALTER TABLE dbo.TaiKhoan ADD FOREIGN KEY (maLoaiNV) REFERENCES dbo.LoaiNV(ma)
ALTER TABLE dbo.MatHang ADD FOREIGN KEY (maLoaiMatHang) REFERENCES dbo.LoaiMH(ma)
ALTER TABLE dbo.MatHang ADD CHECK(donViTinh = N'Lốc' OR donViTinh = N'Chai' OR	donViTinh = N'Thùng'
OR	donViTinh = N'Túi' OR	donViTinh = N'Bao' OR	donViTinh = N'Bình' OR	donViTinh = N'Hộp'
OR	donViTinh = N'Hũ' OR	donViTinh = N'Gói' OR	donViTinh = N'Kg' )

ALTER TABLE dbo.MatHang ADD CHECK (soLuongTon > 0)
ALTER TABLE dbo.TaiKhoan ADD tenHienThi NVARCHAR(100)
ALTER TABLE	dbo.KhachHang ADD soDienThoai INT

--Loại nhân viên
INSERT INTO dbo.LoaiNV( ma, tenLoai )
VALUES  ( N'L01',N'Quản lý')
INSERT INTO dbo.LoaiNV( ma, tenLoai )
VALUES  ( N'L02',N'Thu ngân')
INSERT INTO dbo.LoaiNV( ma, tenLoai )
VALUES  ( N'L03',N'Thủ kho')

--Tài khoản
INSERT INTO	dbo.TaiKhoan( ma, tenTaiKhoan, matKhau, maLoaiNV )
VALUES  ( N'TK01','NVQL01','admin',N'L01')
INSERT INTO	dbo.TaiKhoan( ma, tenTaiKhoan, matKhau, maLoaiNV )
VALUES  ( N'TK02','NVTN01','admin',N'L02')
INSERT INTO	dbo.TaiKhoan( ma, tenTaiKhoan, matKhau, maLoaiNV )
VALUES  ( N'TK03','NVTK01','admin',N'L03')

--Nhân viên
INSERT INTO	dbo.NhanVien( ma, ten, maLoai, maTaiKhoan )
VALUES  ( N'NV01',N'Lê Thanh Sơn', N'L01','TK01' )
INSERT INTO	dbo.NhanVien( ma, ten, maLoai, maTaiKhoan )
VALUES  ( N'NV02',N'Hoàng Gia Kiệt', N'L02','TK02' )
INSERT INTO	dbo.NhanVien( ma, ten, maLoai, maTaiKhoan )
VALUES  ( N'NV03',N'Bạch Võ Thế Anh', N'L03','TK03' )
GO
--Loại mặt hàng
INSERT INTO	dbo.LoaiMH( ma, tenLoaiMH )
VALUES  ( N'LMH01',N'Bánh kẹo')
INSERT INTO	dbo.LoaiMH( ma, tenLoaiMH )
VALUES  ( N'LMH02',N'Bơ Sữa')
INSERT INTO	dbo.LoaiMH( ma, tenLoaiMH )
VALUES  ( N'LMH03',N'Rau quả')

--Mặt hàng
--Loại bánh kẹo
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH01' ,N'Bánh Quy Koala' ,100 ,20000 ,N'LMH01' ,N'Hộp')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH02' ,N'Kẹo bốn mùa' ,100 ,8000,N'LMH01' ,N'Gói')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH03' ,N'Kẹo đậu đỏ' ,100 ,8000 ,N'LMH01' ,N'Gói')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH04' ,N'Bánh xốp' ,50 ,15000 ,N'LMH01' ,N'Gói')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH05' ,N'Bánh Quy Cosy' ,30 ,50000 ,N'LMH01' ,N'Hộp')
-- Loại Bơ sữa
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH06' ,N'Bơ Tường An hộp nhỏ' ,70 ,5000 ,N'LMH02' ,N'Hộp')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH07' ,N'Bơ Tường An hộp lớn' ,100 ,11000 ,N'LMH02' ,N'Hộp')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH08' ,N'Sữa TH True Milk' ,50 ,26500 ,N'LMH02' ,N'Lốc')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH09' ,N'Sữa Vinamilk' ,30 ,26000 ,N'LMH02' ,N'Lốc')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH10' ,N'Sữa chua Vinamilk' ,20 ,36000 ,N'LMH03' ,N'Lốc')
-- Loại rau quả
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH11' ,N'Cam ấn độ' ,60 ,36500 ,N'LMH03' ,N'Kg')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH12' ,N'Xoài cát hòa lộc' ,30 ,22000 ,N'LMH03' ,N'Kg')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH13' ,N'Lê hàn quốc' ,20 ,35500 ,N'LMH03' ,N'Kg')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH14' ,N'Nho mỹ đen' ,70 ,140000 ,N'LMH03' ,N'Kg')
INSERT INTO dbo.MatHang
        ( ma ,tenMatHang ,soLuongTon ,donGia , maLoaiMatHang ,donViTinh)
VALUES  ( N'MH15' ,N'Nho mỹ xanh' ,60 ,150000 ,N'LMH03' ,N'Kg')




ALTER PROC usp_getNhanVien
@tenNhanVien NVARCHAR(50) = NULL,
@chucVu NVARCHAR(50) = NULL
AS
BEGIN
	IF(@tenNhanVien IS NULL AND @chucVu IS NULL)
		BEGIN
			SELECT dbo.NhanVien.ten 
			AS [Tên nhân viên], dbo.LoaiNV.tenLoai 
			AS [Chức vụ], dbo.TaiKhoan.tenTaiKhoan 
			AS [Tên tài khoản], dbo.TaiKhoan.matKhau 
			AS [Mật khẩu]
			FROM dbo.TaiKhoan, dbo.NhanVien, dbo.LoaiNV
			WHERE	dbo.TaiKhoan.maLoaiNV = dbo.LoaiNV.ma
			AND	dbo.NhanVien.maLoai = dbo.LoaiNV.ma
		END
	ELSE IF(@tenNhanVien IS NULL AND @chucVu IS NOT NULL)
		BEGIN
			SELECT dbo.NhanVien.ten 
			AS [Tên nhân viên], dbo.LoaiNV.tenLoai 
			AS [Chức vụ], dbo.TaiKhoan.tenTaiKhoan 
			AS [Tên tài khoản], dbo.TaiKhoan.matKhau 
			AS [Mật khẩu]
			FROM dbo.TaiKhoan, dbo.NhanVien, dbo.LoaiNV
			WHERE	dbo.TaiKhoan.maLoaiNV = dbo.LoaiNV.ma
			AND	dbo.NhanVien.maLoai = dbo.LoaiNV.ma
			AND	dbo.LoaiNV.tenLoai = @chucVu
		END
	ELSE IF(@chucVu IS NULL AND  @tenNhanVien IS NOT NULL)
		BEGIN
			SELECT dbo.NhanVien.ten 
			AS [Tên nhân viên], dbo.LoaiNV.tenLoai 
			AS [Chức vụ], dbo.TaiKhoan.tenTaiKhoan 
			AS [Tên tài khoản], dbo.TaiKhoan.matKhau 
			AS [Mật khẩu]
			FROM dbo.TaiKhoan, dbo.NhanVien, dbo.LoaiNV
			WHERE	dbo.TaiKhoan.maLoaiNV = dbo.LoaiNV.ma
			AND	dbo.NhanVien.maLoai = dbo.LoaiNV.ma
			AND	dbo.NhanVien.ten = @tenNhanVien
		END
END
GO
-- USP GET LIST HÀNG HÓA
CREATE PROC usp_getListHangHoa
AS
BEGIN
	SELECT dbo.MatHang.ma AS [Mã], dbo.MatHang.tenMatHang AS [Tên mặt hàng], 
	dbo.MatHang.soLuongTon AS [Số lượng], dbo.MatHang.donGia AS [Đơn giá],
	dbo.MatHang.donViTinh AS [Đơn vị tính], dbo.LoaiMH.tenLoaiMH AS [Loại]
	FROM dbo.MatHang,dbo.LoaiMH
	WHERE dbo.MatHang.maLoaiMatHang = dbo.LoaiMH.ma
END
GO

EXEC dbo.usp_getListHangHoa
GO


--USP GET LIST NHÂN VIÊN
CREATE PROC usp_getListNV
AS
BEGIN
	SELECT dbo.NhanVien.ten 
	AS [Tên nhân viên], dbo.LoaiNV.tenLoai 
	AS [Chức vụ], dbo.TaiKhoan.tenTaiKhoan 
	AS [Tên tài khoản], dbo.TaiKhoan.matKhau 
	AS [Mật khẩu]
	FROM dbo.TaiKhoan, dbo.NhanVien, dbo.LoaiNV
	WHERE	dbo.TaiKhoan.maLoaiNV = dbo.LoaiNV.ma
	AND	dbo.NhanVien.maLoai = dbo.LoaiNV.ma
END
GO

EXEC dbo.usp_getListNV
GO

SELECT *
FROM dbo.LoaiNV
GO

CREATE PROC usp_Login
@TenTaiKhoan VARCHAR(16),
@MatKhau VARCHAR(16),
@ChucVu NVARCHAR(50)
AS
BEGIN
	SELECT dbo.TaiKhoan.ma, dbo.TaiKhoan.tenTaiKhoan, dbo.TaiKhoan.matKhau, dbo.LoaiNV.tenLoai 
	FROM dbo.TaiKhoan, dbo.LoaiNV
	WHERE dbo.TaiKhoan.maLoaiNV = dbo.LoaiNV.ma
	AND	dbo.TaiKhoan.tenTaiKhoan =  @TenTaiKhoan
	AND	dbo.TaiKhoan.matKhau = @MatKhau
	AND	dbo.LoaiNV.tenLoai = @ChucVu
END

EXEC dbo.usp_Login @TenTaiKhoan = 'NVQL01' , @MatKhau = 'admin' , @ChucVu = N'Quản lý'



