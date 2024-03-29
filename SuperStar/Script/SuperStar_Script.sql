CREATE DATABASE SuperStar
GO
USE SuperStar

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funcLaySoLuongTonCuaTangPham]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[funcLaySoLuongTonCuaTangPham]
(@matangpham int)
returns int
as
	begin
		return (select SoLuongConLai from TANG_PHAM where MaTangPham = @matangpham)
	end
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatTrangThaiDonDatHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[spCapNhatTrangThaiDonDatHang]
@maddh int,
@madaily int,
@trangthai int
as
	begin
		UPDATE    DON_DAT_HANG
		SET       TrangThai = @trangthai, MaDaiLy = @madaily
		where MaDDH = @maddh
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DANH_MUC_SAN_PHAM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DANH_MUC_SAN_PHAM](
	[Ma] [int] IDENTITY(1,1) NOT NULL,
	[TenLoaiSanPham] [nvarchar](50) NULL,
 CONSTRAINT [PK_DANH_MUC_SAN_PHAM] PRIMARY KEY CLUSTERED 
(
	[Ma] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TRANG_THAI]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TRANG_THAI](
	[MaTrangThai] [int] IDENTITY(1,1) NOT NULL,
	[TrangThai] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_TRANG_THAI] PRIMARY KEY CLUSTERED 
(
	[MaTrangThai] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TAI_KHOAN]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TAI_KHOAN](
	[MaTaiKhoan] [int] IDENTITY(1,1) NOT NULL,
	[TenTaiKhoan] [varchar](20) NOT NULL,
	[MatKhau] [varchar](20) NOT NULL,
	[AnhDaiDien] [varchar](50) NOT NULL,
	[LoaiTK] [int] NOT NULL,
 CONSTRAINT [PK_TAI_KHOAN] PRIMARY KEY CLUSTERED 
(
	[MaTaiKhoan] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [IX_TAI_KHOAN] UNIQUE NONCLUSTERED 
(
	[TenTaiKhoan] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [tr_MatKhau]
on [dbo].[TAI_KHOAN]
for insert, update
as
	begin
		declare @matkhau varchar(20)
		set @matkhau = null
		select @matkhau = MatKhau from inserted
		if( len(@matkhau) < 6 or len(@matkhau) > 20 )
		begin 
			raiserror (N'Mật khẩu từ  6 đến 20 ký tự',1,1) 
			rollback
		end 
	end

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [tr_TenTaiKhoan]
on [dbo].[TAI_KHOAN]
for insert, update
as
	begin
		declare @tentaikhoan varchar(20)
		set @tentaikhoan = null
		select @tentaikhoan = TenTaiKhoan from inserted
		if( len(@tentaikhoan) < 6 or len(@tentaikhoan) > 20 )
		begin 
			raiserror (N'Tên tài khoản từ  6 đến 20 ký tự',1,1) 
			rollback
		end 
	end

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayTaiKhoanTheoTen]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[spLayTaiKhoanTheoTen]
@tentaikhoan varchar(20) 
as
	begin
		select * from TAI_KHOAN where TenTaiKhoan like @tentaikhoan
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayTaiKhoanTheoMa]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--10. Lấy tài khoản theo mã
create proc [dbo].[spLayTaiKhoanTheoMa]
@mataikhoan int
as
	begin
		select * from TAI_KHOAN where MaTaiKhoan = @mataikhoan
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spDoiMatKhau]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE proc [dbo].[spDoiMatKhau]
@mataikhoan int,
@matkhau varchar(20)
as
	begin
		UPDATE    TAI_KHOAN
		SET       MatKhau = @matkhau
		WHERE	MaTaiKhoan = @mataikhoan
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLaySanPhamTheoMa]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--7. Lấy thông tin sản phẩm theo mã
CREATE proc [dbo].[spLaySanPhamTheoMa]
@masanpham int
as
	begin
		select * from SAN_PHAM where MaSanPham = @masanpham
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSSanPhamTheoTen]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

--8. Lấy thông tin sản phẩm theo tên
CREATE proc [dbo].[spLayDSSanPhamTheoTen]
@tensanpham nvarchar(50)
as
	begin
		select * from SAN_PHAM where TenSanPham like @tensanpham
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSSanPhamTheoDonGia]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--9.Lấy sản phẩm theo đơn giá trong khoảng 
create proc [dbo].[spLayDSSanPhamTheoDonGia]
@giamin float,
@giamax float
as
	begin
		select * from SAN_PHAM where DonGia >= @giamin and DonGia <= @giamax
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SAN_PHAM](
	[MaSanPham] [int] IDENTITY(1,1) NOT NULL,
	[TenSanPham] [nvarchar](50) NOT NULL,
	[SoLuongSP] [int] NOT NULL,
	[SoLuongTon] [int] NOT NULL,
	[DonGia] [float] NOT NULL,
	[DiemThuong] [int] NOT NULL,
	[ThoiGianBD_Ban] [datetime] NOT NULL,
	[ThoiGianKT_Ban] [datetime] NOT NULL,
	[ThoiGianBD_NhanHang] [datetime] NULL,
	[ThoiGianKT_NhanHang] [datetime] NULL,
	[MaNguoiNhap] [int] NOT NULL,
	[MaDanhMuc] [int] NOT NULL,
	[HinhAnh] [varchar](50) NOT NULL,
	[ThongTinChiTiet] [varchar](50) NOT NULL,
 CONSTRAINT [PK_SAN_PHAM] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DON_DAT_HANG]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DON_DAT_HANG](
	[MaDDH] [int] IDENTITY(1,1) NOT NULL,
	[NgayDat] [datetime] NOT NULL,
	[SoLuongDat] [int] NOT NULL,
	[TrangThai] [int] NOT NULL,
	[MaKhachHang] [int] NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[MaDaiLy] [int] NOT NULL,
	[NgayNhanHang] [datetime] NULL,
	[ThanhTien] [float] NOT NULL,
 CONSTRAINT [PK_DON_DAT_HANG] PRIMARY KEY CLUSTERED 
(
	[MaDDH] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CHI_TIET_DDH]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CHI_TIET_DDH](
	[MaDDH] [int] NOT NULL,
	[MaTangPham] [int] NOT NULL,
	[SoLuong] [int] NOT NULL,
 CONSTRAINT [PK_CHI_TIET_DDH] PRIMARY KEY CLUSTERED 
(
	[MaDDH] ASC,
	[MaTangPham] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QUAN_LY]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QUAN_LY](
	[MaQuanLy] [int] NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[SoDienThoai] [varchar](50) NOT NULL,
 CONSTRAINT [PK_QUAN_LY] PRIMARY KEY CLUSTERED 
(
	[MaQuanLy] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[KHACH_HANG]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[KHACH_HANG](
	[MaKhachHang] [int] NOT NULL,
	[HoTen] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[SoDienThoai] [varchar](50) NOT NULL,
 CONSTRAINT [PK_KHACH_HANG] PRIMARY KEY CLUSTERED 
(
	[MaKhachHang] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DAI_LY]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DAI_LY](
	[MaDaiLy] [int] NOT NULL,
	[TenDaiLy] [nvarchar](50) NOT NULL,
	[DiaChi] [nvarchar](100) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[SoDienThoai] [varchar](50) NOT NULL,
	[NguoiDaiDien] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_DAI_LY] PRIMARY KEY CLUSTERED 
(
	[MaDaiLy] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TANG_PHAM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TANG_PHAM](
	[MaTangPham] [int] IDENTITY(1,1) NOT NULL,
	[TenTangPham] [nvarchar](50) NOT NULL,
	[DiemThuongYC] [int] NOT NULL,
	[SoLuongTP] [int] NOT NULL,
	[SoLuongToiDa] [int] NOT NULL,
	[SoLuongConLai] [int] NOT NULL,
	[MaSanPham] [int] NOT NULL,
	[HinhAnh] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TANG_PHAM] PRIMARY KEY CLUSTERED 
(
	[MaTangPham] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH02_1_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE proc [dbo].[TH02_1_spHuyDonDatHang_b]
@maddh int
as
begin
	set transaction isolation level read uncommitted
	--set transaction isolation level repeatable read -- giải quyết
	begin tran

		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			rollback tran
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				
			end		
	commit tran
end










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spHuyDonDatHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[spHuyDonDatHang]
@maddh int
as
	begin
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			return -1
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				return 1
			end		
	end



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH02_1_spHuyDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH02_1_spHuyDonDatHang_a]
@maddh int
as
begin
	begin tran
	set transaction isolation level read uncommitted -- đọc dữ liệu rác
	--set transaction isolation level repeatable read --

		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			rollback tran
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
			end	
		waitfor delay ''00:00:10''
	rollback tran
end








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH03_1_spHuyDonDatHang_b2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE proc [dbo].[TH03_1_spHuyDonDatHang_b2]
@maddh int
as

begin tran
	begin
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			rollback tran
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

waitfor delay ''00:00:05''
rollback tran

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
			end	

	
	end











' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH03_1_spHuyDonDatHang_b1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE proc [dbo].[TH03_1_spHuyDonDatHang_b1]
@maddh int
as

begin tran
set transaction isolation level read uncommitted -- mất dữ liệu cập nhật
--set transaction isolation level read committed
	begin
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			rollback tran
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
			end	
	
	end

commit tran










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH03_2_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH03_2_spHuyDonDatHang_b]
@maddh int
as

begin tran
set transaction isolation level read uncommitted -- mất dữ liệu cập nhật
--set transaction isolation level serializable --deadlock

	begin
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		waitfor delay ''00:00:05''

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			rollback tran
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
			end	

		waitfor delay ''00:00:05''
	
	end

commit tran











' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH12_2_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH12_2_spHuyDonDatHang_b]
@maddh int
as
	
	begin tran
	set transaction isolation level serializable
	--fix
	--set transaction isolation level repeatable read
		
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			return -1
		else	
			begin
				--waitfor delay ''00:00:05''
				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh
				--waitfor delay ''00:00:05''
				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp
				
				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while (@@fetch_status = 0)
					begin
						
						declare @slton int
						waitfor delay ''00:00:05''
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)
						waitfor delay ''00:00:05''
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				--return 1
			end		
		
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH11_2_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH11_2_spHuyDonDatHang_b]
@maddh int
as
	
	begin tran
	set transaction isolation level serializable

		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			return -1
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while (@@fetch_status = 0)
					begin
						waitfor delay ''00:00:05'' 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				--return 1
			end		
		
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH12_1_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[TH12_1_spHuyDonDatHang_b]
@maddh int
as
	begin tran
		set transaction isolation level read uncommitted
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			return -1
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				--return 1
			end		
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH11_1_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH11_1_spHuyDonDatHang_b]
@maddh int
as
	
	begin tran
	set transaction isolation level read uncommitted

		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			return -1
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while (@@fetch_status = 0)
					begin 
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				--return 1
			end		
	
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH10_1_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





create proc [dbo].[TH10_1_spHuyDonDatHang_b]
@maddh int
as
	begin tran 
		set transaction isolation level read uncommitted
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham
		
		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			return -1
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
					
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)
						
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				return 1
			end		
	commit tran




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH10_2_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE proc [dbo].[TH10_2_spHuyDonDatHang_b]
@maddh int
as
	begin tran 
		set transaction isolation level serializable
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham
		
		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			return -1
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp
				waitfor delay ''00:00:05''
				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
					
						declare @slton int
						set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)
						
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham
						waitfor delay ''00:00:05''

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				--return 1
			end		
	commit tran






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDanhMucSanPham]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[spLayDanhMucSanPham]
as
begin
	select * from DANH_MUC_SAN_PHAM
end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH18_1_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE proc [dbo].[TH18_1_spHuyDonDatHang_b]
@maddh int
as
	begin
		BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			BEGIN
				ROLLBACK
				return -1
			END
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6 
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						--set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)
						select @slton = SoLuongConLai 
						from TANG_PHAM 
						where MaTangPham = @matangpham

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				COMMIT
				return 1
			end		
		COMMIT
	end





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH02_2_spHuyDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'









CREATE proc [dbo].[TH02_2_spHuyDonDatHang_a]
@maddh int
as
begin tran
set transaction isolation level read uncommitted --lost update
--set transaction isolation level repeatable read

	begin
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

waitfor delay ''00:00:05''

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			rollback tran
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

--waitfor delay ''00:00:05''

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						select @slton = SoLuongConLai 
						from TANG_PHAM 
						where MaTangPham = @matangpham
waitfor delay ''00:00:05''

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

--waitfor delay ''00:00:01''


						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
			end	
	
	end

commit tran










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH18_2_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





create proc [dbo].[TH18_2_spHuyDonDatHang_b]
@maddh int
as
	begin
		BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			BEGIN
				ROLLBACK
				return -1
			END
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6 
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						--set @slton = dbo.funcLaySoLuongTonCuaTangPham(@matangpham)
						select @slton = SoLuongConLai 
						from TANG_PHAM 
						where MaTangPham = @matangpham
						
						waitfor delay ''00:00:10''
							
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
				COMMIT
				return 1
			end		
		COMMIT
	end






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH02_2_spHuyDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'









CREATE proc [dbo].[TH02_2_spHuyDonDatHang_b]
@maddh int
as

begin tran
set transaction isolation level read uncommitted --lost update
--set transaction isolation level repeatable read

	begin
		declare @sltonsp int, @masp int , @slspHuy int, @matangpham int, @soluong int, @tinhtrang int
		
		select @sltonsp = sp.SoLuongTon, @masp = ddh.MaSanPham, 
				@slspHuy = ddh.SoLuongDat, @tinhtrang = ddh.TrangThai 
		from SAN_PHAM sp, DON_DAT_HANG ddh 
		where ddh.MaDDH = @maddh and sp.MaSanPham = ddh.MaSanPham

waitfor delay ''00:00:05''

		if(@tinhtrang in (select MaTrangThai from TRANG_THAI where TrangThai like ''%Hủy%'')
)
			rollback tran
		else	
			begin

				UPDATE    DON_DAT_HANG
				SET       TrangThai = 6
				where MaDDH = @maddh

				UPDATE    SAN_PHAM
				SET       SoLuongTon = @sltonsp + @slspHuy
				where MaSanPham = @masp

--waitfor delay ''00:00:05''

				declare curDSChiTietDDHCanXoa cursor
				for select MaTangPham, SoLuong from CHI_TIET_DDH
							where MaDDH = @maddh
				open curDSChiTietDDHCanXoa
				fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
				while @@fetch_status = 0
					begin 
						declare @slton int
						select @slton = SoLuongConLai 
						from TANG_PHAM 
						where MaTangPham = @matangpham
waitfor delay ''00:00:05''

						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @soluong
						where MaTangPham = @matangpham

--waitfor delay ''00:00:01''

						delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
						fetch next from curDSChiTietDDHCanXoa into @matangpham, @soluong
					end
				close curDSChiTietDDHCanXoa
				deallocate curDSChiTietDDHCanXoa
			end	
	
	end

commit tran










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSDonDatHangTheoMaDaiLy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--3. Lấy ds đơn đặt hàng theo mã đại lý
-- Ngọc Hà
create proc [dbo].[spLayDSDonDatHangTheoMaDaiLy]
@madaily int
as
	begin
		select * from dbo.DON_DAT_HANG where  MaDaiLy = @madaily
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatTinhTrangDonDatHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--5. cập Nhật tình trạng đơn đặt hàng
-- Ngọc Hà
create proc [dbo].[spCapNhatTinhTrangDonDatHang]
@maddh int,
@trangthai int
as
	begin
		UPDATE    DON_DAT_HANG
		SET			TrangThai = @trangthai
		where MaDDH = @maddh
	end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSDonDatHangTheoNgayDat]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--13. Tìm kiếm đơn đặt hàng theo ngày đặt mua trong khoảng
create proc [dbo].[spLayDSDonDatHangTheoNgayDat]
@ngaybatdau datetime,
@ngayketthuc datetime
as
	begin
		select * from DON_DAT_HANG  ddh where datediff(d,ddh.NgayDat, @ngaybatdau) <= 0 and datediff(d,ddh.NgayDat, @ngayketthuc) >=0
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatNgayNhanHangCuaDDH]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--6. Cập nhật ngày nhận hàng
-- Ngọc Hà
create proc [dbo].[spCapNhatNgayNhanHangCuaDDH]
@maddh int,
@ngaynhanhang datetime
as
	begin
		UPDATE    DON_DAT_HANG
		SET			NgayNhanHang = @ngaynhanhang
		where MaDDH = @maddh
	end' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH01_1_spThemDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE proc [dbo].[TH01_1_spThemDonDatHang_a]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as
begin
	begin tran
	set transaction isolation level read uncommitted
	
		declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
		select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
				@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
				@soluongton = SoLuongTon
		from SAN_PHAM sp where MaSanPham = @masanpham

		if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
			(@ngaydat between @thoigianbdban and @thoigianktban) and 
			(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
			(@soluongdat <= @soluongton))
			begin	
				INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
				VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
				if(@@error = 0)
					update SAN_PHAM
					set SoLuongTon = (@soluongton - @soluongdat)
					where MaSanPham = @masanpham
			end
		else
			begin
				rollback tran
				return -1	
			end

	waitfor delay ''00:00:10''
	rollback tran		
end








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDonDatHangTheoMaDDH]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--4. Lấy ds đơn đặt hàng theo mã đơn đặt hàng
-- Ngọc Hà
create proc [dbo].[spLayDonDatHangTheoMaDDH]
@maddh int
as
	begin
		select * from dbo.DON_DAT_HANG where  MaDDH = @maddh
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH01_2_spThemDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH01_2_spThemDonDatHang_b]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as
begin	
	set transaction isolation level read uncommitted --lost update
	--set transaction isolation level repeatable read --dead lock
	begin tran

	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	waitfor delay ''00:00:10''

	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
	begin	
		INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
		VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
		if(@@error = 0)
			update SAN_PHAM
			set SoLuongTon = (@soluongton - @soluongdat)
			where MaSanPham = @masanpham
	end
	else
		BEGIN
		ROLLBACK TRAN
		return -1	
		END

	commit tran	
end








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH01_1_spThemDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'









CREATE proc [dbo].[TH01_1_spThemDonDatHang_b]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as

begin
	set transaction isolation level read uncommitted
	begin tran
	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
		begin	
			INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
			VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
			if(@@error = 0)
				update SAN_PHAM
				set SoLuongTon = (@soluongton - @soluongdat)
				where MaSanPham = @masanpham
		end
	else
		BEGIN
		ROLLBACK TRAN
		return -1	
		END

	commit

end











' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH01_2_spThemDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH01_2_spThemDonDatHang_a]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as
begin	
	set transaction isolation level read uncommitted --lost update
	--set transaction isolation level repeatable read --dead lock
	begin tran

	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	waitfor delay ''00:00:10''

	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
	begin	
		INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
		VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
		if(@@error = 0)
			update SAN_PHAM
			set SoLuongTon = (@soluongton - @soluongdat)
			where MaSanPham = @masanpham
	end
	else
		BEGIN
			ROLLBACK
			return -1		
		END
	commit tran
end








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spThemDonDatHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[spThemDonDatHang]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as
begin
	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
	begin	
		INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
		VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
		if(@@error = 0)
			update SAN_PHAM
			set SoLuongTon = (@soluongton - @soluongdat)
			where MaSanPham = @masanpham
	end
	else
		return -1		
end
return



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH03_1_spThemDonDatHang_a2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'








CREATE proc [dbo].[TH03_1_spThemDonDatHang_a2]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as

set transaction isolation level read uncommitted
--set transaction isolation level read committed
begin tran
begin
	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
	begin	
		INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
		VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
		if(@@error = 0)
			update SAN_PHAM
			set SoLuongTon = (@soluongton - @soluongdat)
			where MaSanPham = @masanpham
	end
	else
		return -1	
end
commit tran









' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH03_1_spThemDonDatHang_a1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'










CREATE proc [dbo].[TH03_1_spThemDonDatHang_a1]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as

begin tran
begin
	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
	begin	
		INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
		VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
		if(@@error = 0)
			update SAN_PHAM
			set SoLuongTon = (@soluongton - @soluongdat)
			where MaSanPham = @masanpham
	end
	else
	begin
		rollback tran
		return -1
	end

waitfor delay ''00:00:05''

end

rollback tran










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH03_2_spThemDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'












CREATE proc [dbo].[TH03_2_spThemDonDatHang_a]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as

begin tran
set transaction isolation level read uncommitted -- mất dữ liệu cập nhật
--set transaction isolation level serializable --deadlock

begin
	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	waitfor delay ''00:00:05''


	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
	begin	
		INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
		VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
		if(@@error = 0)
			update SAN_PHAM
			set SoLuongTon = (@soluongton - @soluongdat)
			where MaSanPham = @masanpham
	end

	else
	begin
		rollback tran
		return -1
	end

waitfor delay ''00:00:05''

end

commit tran












' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSDonDatHangTheoMaSanPham]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--1. Lấy ds đơn đặt hàng theo mã sản phẩm
-- Ngọc Hà
create proc [dbo].[spLayDSDonDatHangTheoMaSanPham]
@masanpham int
as
	begin
		select * from dbo.DON_DAT_HANG where MaSanPham = @masanpham
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSDonDatHangTheoMaKhachHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--2. Lấy ds đơn đặt hàng theo mã khách hàng
-- Ngọc Hà
create proc [dbo].[spLayDSDonDatHangTheoMaKhachHang]
@makhachhang int
as
	begin
		select * from dbo.DON_DAT_HANG where  MaKhachHang = @makhachhang
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH13_2_spThemDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH13_2_spThemDonDatHang_b]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
	

)
as
	begin tran
	set transaction isolation level serializable
	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
	begin	
		INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
		VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
		if(@@error = 0)
			waitfor delay ''00:00:05''
			update SAN_PHAM
			set SoLuongTon = (@soluongton - @soluongdat)
			where MaSanPham = @masanpham
	end
	else
		rollback tran		
commit tran
--return
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH14_3_spThemDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH14_3_spThemDonDatHang_b]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as
	begin tran
		set transaction isolation level repeatable read
		declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
		select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
				@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
				@soluongton = SoLuongTon
		from SAN_PHAM sp where MaSanPham = @masanpham
		waitfor delay ''00:00:05''
		if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
			(@ngaydat between @thoigianbdban and @thoigianktban) and 
			(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
			(@soluongdat <= @soluongton))
		begin	
			INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
			VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
			if(@@error = 0)
				
				update SAN_PHAM
				set SoLuongTon = (@soluongton - @soluongdat)
				where MaSanPham = @masanpham
		end
		else
			rollback tran		
	commit tran
--return
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH13_1_spThemDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH13_1_spThemDonDatHang_b]
(
	@ngaydat datetime,
	@soluongdat int,
	@trangthai int, 
	@makhachhang int,
	@masanpham int,
	@madaily int,
	@thanhtien float,
	@ngaynhanhang datetime
)
as
	begin tran
	set transaction isolation level read uncommitted
	declare @soluongton int, @thoigianbdban datetime, @thoigianktban datetime, @thoigianbdnhanhang datetime, @thoigianktnhanhang datetime
	select	@thoigianbdban = sp.ThoiGianBD_Ban, @thoigianktban = sp.ThoiGianKT_Ban,
			@thoigianbdnhanhang = sp.ThoiGianBD_NhanHang, @thoigianktnhanhang = sp.ThoiGianKT_NhanHang,
			@soluongton = SoLuongTon
	from SAN_PHAM sp where MaSanPham = @masanpham

	if(datediff(SS,@ngaydat,@ngaynhanhang) > 0 and
		(@ngaydat between @thoigianbdban and @thoigianktban) and 
		(@ngaynhanhang between @thoigianbdnhanhang and @thoigianktnhanhang) and
		(@soluongdat <= @soluongton))
	begin	
		INSERT INTO DON_DAT_HANG (NgayDat, SoLuongDat, TrangThai, MaKhachHang, MaSanPham, MaDaiLy, NgayNhanHang, ThanhTien)
		VALUES     (@ngaydat,@soluongdat,@trangthai,@makhachhang,@masanpham,@madaily,@ngaynhanhang,@thanhtien)
		if(@@error = 0)
			update SAN_PHAM
			set SoLuongTon = (@soluongton - @soluongdat)
			where MaSanPham = @masanpham
	end
	else
		rollback tran		
commit tran
--return
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatThongTinTaiKhoanQuanLy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE proc [dbo].[spCapNhatThongTinTaiKhoanQuanLy]
(
	@maquanly int,
	@hoten nvarchar(50),
	@diachi nvarchar(100),
	@sodienthoai varchar(12)
)
as
begin
	update QUAN_LY
	set HoTen = @hoten, DiaChi = @diachi, SoDienThoai = @sodienthoai
	where MaQuanLy = @maquanly
end
return

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayThongTinQuanLyTheoMa]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--5. Lấy thông tin quản lý theo mã
create proc [dbo].[spLayThongTinQuanLyTheoMa]
@maquanly int
as
	begin
		select * from QUAN_LY where MaQuanLy = @maquanly
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSQuanLyTheoTen]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--6. Lấy thông tin quản lý theo tên
create proc [dbo].[spLayDSQuanLyTheoTen]
@hoten nvarchar(50)
as
	begin
		select * from QUAN_LY where HoTen like @hoten
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatThongTinTaiKhoanKhachHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE proc [dbo].[spCapNhatThongTinTaiKhoanKhachHang]
(
	@makhachhang int,
	@hoten nvarchar(50),
	@diachi nvarchar(100),
	@sodienthoai varchar(12)
)
as
begin
	update KHACH_HANG
	set HoTen = @hoten, DiaChi = @diachi, SoDienThoai = @sodienthoai
	where MaKhachHang = @makhachhang
end
return

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayKhachHangTheoMa]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--3. Lấy thông tin khách hàng theo mã
create proc [dbo].[spLayKhachHangTheoMa]
@makhachhang int
as
	begin
		select * from KHACH_HANG where MaKhachHang = @makhachhang
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSKhachHangTheoTen]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--4. Lấy thông tin khách hàng theo tên
create proc [dbo].[spLayDSKhachHangTheoTen]
@hoten nvarchar(50)
as
	begin
		select * from KHACH_HANG where HoTen like @hoten
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayThongTinDaiLyTheoMa]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--Lấy thông tin 
--1. Lấy thông tin đại lý theo mã
create proc [dbo].[spLayThongTinDaiLyTheoMa]
@madaily int
as
	begin
		select * from DAI_LY where MaDaiLy = @madaily
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayThongTinDaiLyTheoTen]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--2. Lấy thông tin đại lý theo tên
create proc [dbo].[spLayThongTinDaiLyTheoTen]
@tendaily nvarchar(50)
as
	begin
		select * from DAI_LY where TenDaiLy like @tendaily
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spXoaDaiLy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- Vũ

--Xoá đại lý
CREATE proc [dbo].[spXoaDaiLy]
@madaily int
as
begin
	delete from DAI_LY where MaDaiLy = @madaily
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatThongTinTaiKhoanDaiLy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[spCapNhatThongTinTaiKhoanDaiLy]
(
	@madaily int, 
	@tendaily nvarchar(50),
	@diachi nvarchar(100),
	@email varchar(50),
	@sodienthoai varchar(50),
	@nguoidaidien nvarchar(50)
)
as
begin
	update DAI_LY
	set TenDaiLy = @tendaily, DiaChi = @diachi, Email = @email, SoDienThoai = @sodienthoai, NguoiDaiDien = @nguoidaidien
	where MaDaiLy = @madaily
end
return



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spThemDaiLy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- Vũ
--Thêm đại lý
CREATE proc [dbo].[spThemDaiLy]
(
	@madaily int,
	@tendaily nvarchar(50),
	@diachi nvarchar(50),
	@email varchar(50),
	@sodienthoai varchar(50),
	@nguoidaidien nvarchar(50)
)
as
begin
	INSERT INTO DAI_LY (MaDaiLy, TenDaiLy, DiaChi, Email, SoDienThoai, NguoiDaiDien)
	VALUES     (@madaily,@tendaily,@diachi,@email,@sodienthoai,@nguoidaidien)
end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spThemTaiKhoan]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[spThemTaiKhoan]
(
	@tentaikhoan varchar(20),
	@matkhau varchar(20),
	@anhdaidien varchar (50),
	@loaitk int
)
as
	begin
		INSERT INTO TAI_KHOAN
                      (TenTaiKhoan, MatKhau, AnhDaiDien, LoaiTK)
		VALUES     (@tentaikhoan,@matkhau,@anhdaidien,@loaitk)
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatSanPham]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE proc [dbo].[spCapNhatSanPham]
@masanpham int,
@tensanpham varchar(50),
@soluongsp int,
@soluongton int,
@dongia int,
@diemthuong int ,
@thoigianbd_ban datetime,
@thoigiankt_ban datetime,
@thoigianbd_nhanhang datetime,
@thoigiankt_nhanhang datetime,
@manguoinhap int,
@hinhanh varchar(50),
@madanhmuc int,
@thongtinchitiet varchar(50)
as
	begin
		UPDATE    SAN_PHAM
		SET       TenSanPham = @tensanpham, SoLuongSP = @soluongsp, SoLuongTon = @soluongton, DonGia = @dongia, DiemThuong = @diemthuong, 
                  ThoiGianBD_Ban = @thoigianbd_ban, ThoiGianKT_Ban = @thoigiankt_ban, ThoiGianBD_NhanHang = @thoigianbd_nhanhang, 
                  ThoiGianKT_NhanHang = @thoigiankt_nhanhang, MaNguoiNhap = @manguoinhap,
				  HinhAnh = @hinhanh, ThongTinChiTiet = @thongtinchitiet, MaDanhMuc = @madanhmuc
		WHERE	MaSanPham = @masanpham
	end




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spThemSanPham]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[spThemSanPham]
@tensanpham varchar(50),
@soluongsp int,
@soluongton int,
@dongia int,
@diemthuong int ,
@thoigianbd_ban datetime,
@thoigiankt_ban datetime,
@thoigianbd_nhanhang datetime,
@thoigiankt_nhanhang datetime,
@manguoinhap int,
@madanhmuc int, 
@hinhanh varchar(50),
@thongtinchitiet varchar(50)
as
	begin
		INSERT INTO SAN_PHAM
                      (TenSanPham, SoLuongSP, SoLuongTon, DonGia, DiemThuong, 
						ThoiGianBD_Ban, ThoiGianKT_Ban, 
						ThoiGianBD_NhanHang, ThoiGianKT_NhanHang, MaNguoiNhap,
						MaDanhMuc, HinhAnh, ThongTinChiTiet)
		VALUES     (@tensanpham,@soluongsp,@soluongton,@dongia,@diemthuong,
					@thoigianbd_ban,@thoigiankt_ban,
					@thoigianbd_nhanhang, @thoigiankt_nhanhang,@manguoinhap,
					@madanhmuc, @hinhanh, @thongtinchitiet)
	end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH13_1_spCapNhatSoLuongSanPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH13_1_spCapNhatSoLuongSanPham_a]
@masanpham int,
@soluongsp int
as
	begin tran 
	declare @slbandau int
	declare @slton int
	select @slbandau = SoLuongSP, @slton = SoLuongTon from SAN_PHAM where MaSanPham = @masanpham
	if(@slbandau > @soluongsp)
		begin
		raiserror (N''Chỉ được tăng số lượng!'',1,16)
		rollback tran
		end
	else
		UPDATE    SAN_PHAM
		SET       SoLuongTon = @slton + @soluongsp - @slbandau, SoLuongSP = @soluongsp
		WHERE MaSanPham = @masanpham
	waitfor delay ''00:00:10''
rollback tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSSanPhamHetThoiHanMuaHoacHetHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--minh đức

create proc [dbo].[spLayDSSanPhamHetThoiHanMuaHoacHetHang]

as
	begin
		SELECT * 
		FROM SAN_PHAM
		WHERE SoLuongTon <= 0 OR datediff(d, ThoiGianKT_Ban, GETDATE()) <= 0
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatSoLuongBanDauSP]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--minh đức
create proc [dbo].[spCapNhatSoLuongBanDauSP]
@masanpham int,
@soluongsp int

as
	begin
	declare @slbandau int
	declare @slton int

	select @slbandau = SoLuongSP, @slton = SoLuongTon 
	from SAN_PHAM 
	where MaSanPham = @masanpham

	if(@slbandau > @soluongsp)
		begin
		raiserror (N''Chỉ được tăng số lượng!'',1,16)
		rollback tran
		end
	else
		UPDATE    SAN_PHAM
		SET       SoLuongTon = @slton + @soluongsp - @slbandau, SoLuongSP = @soluongsp
		WHERE MaSanPham = @masanpham
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spXoaSanPham]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--minh đức

create proc [dbo].[spXoaSanPham]
@masanpham int

as
	begin
		DELETE FROM SAN_PHAM WHERE MaSanPham = @masanpham
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSSanPhamConThoiHanMuaVaConHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--minh đức
create proc [dbo].[spLayDSSanPhamConThoiHanMuaVaConHang]

as
	begin
		SELECT * 
		FROM SAN_PHAM
		WHERE SoLuongTon > 0 AND datediff(d, ThoiGianKT_Ban, GETDATE()) > 0
		ORDER BY ThoiGianBD_Ban DESC
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH13_2_spCapNhatSoLuongSanPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[TH13_2_spCapNhatSoLuongSanPham_a]
@masanpham int,
@soluongsp int
as
	begin tran 
	set transaction isolation level serializable
	declare @slbandau int
	declare @slton int
	select @slbandau = SoLuongSP, @slton = SoLuongTon from SAN_PHAM where MaSanPham = @masanpham
	if(@slbandau > @soluongsp)
		begin
		raiserror (N''Chỉ được tăng số lượng!'',1,16)
		rollback tran
		end
	else
		waitfor delay ''00:00:10''
		UPDATE    SAN_PHAM
		SET       SoLuongTon = @slton + @soluongsp - @slbandau, SoLuongSP = @soluongsp
		WHERE MaSanPham = @masanpham
	
commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH07_1_spCapNhatChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE proc [dbo].[TH07_1_spCapNhatChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong		
					where MaDDH = @maddh and MaTangPham = @matangpham		
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
		waitfor delay ''00:00:05''
	rollback tran




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH07_1_spThemChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[TH07_1_spThemChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level read uncommitted
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			return -1
		else
			begin
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end
	commit tran




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH16_2_spCapNhatChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE proc [dbo].[TH16_2_spCapNhatChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin
		BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE

		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham

		waitfor delay ''00:00:10''

		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong		
					WHERE MaTangPham = @matangpham AND MaDDH = @maddh
					if(@@error = 0)
					BEGIN
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
					END
					else
					BEGIN
						ROLLBACK TRAN
						return 0
					END
				end 
			else
				BEGIN
					ROLLBACK TRAN
					return 0	
				END
				
		end
		else
			BEGIN
				ROLLBACK TRAN
				return 0
			END

		COMMIT
	end







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH17_2_spXoaChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[TH17_2_spXoaChiTietDonDatHang_b]
@maddh int,
@matangpham int
as
	begin
		BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		waitfor delay ''00:00:10''	
	
		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			BEGIN
				ROLLBACK TRAN
				return 0
			END
		COMMIT

	end



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatChiTietDonDatHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE proc [dbo].[spCapNhatChiTietDonDatHang]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin
		
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong		
					WHERE MaTangPham = @matangpham AND MaDDH = @maddh

					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
	end



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spThemChiTietDonDatHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE proc [dbo].[spThemChiTietDonDatHang]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin
		
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			return -1
		else
			begin
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end 
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH20_3_spThemChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE  proc [dbo].[TH20_3_spThemChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin
		BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			return -1
		else
			begin
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)

				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end 
		waitfor delay ''00:00:10''

		COMMIT
	end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spXoaChiTietDonDatHang]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE proc [dbo].[spXoaChiTietDonDatHang]
@maddh int,
@matangpham int
as
	begin
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			return 0
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH16_1_spCapNhatChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH16_1_spCapNhatChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin
		BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong		
					WHERE MaTangPham = @matangpham AND MaDDH = @maddh
					if(@@error = 0)
					BEGIN
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
					END
					else
					BEGIN
						ROLLBACK TRAN
						return 0
					END
				end 
			else
				BEGIN
					ROLLBACK TRAN
					return 0	
				END
				
		end
		else
			BEGIN
				ROLLBACK TRAN
				return 0
			END

		COMMIT
	end






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH17_1_spXoaChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[TH17_1_spXoaChiTietDonDatHang_b]
@maddh int,
@matangpham int
as
	begin
		BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			BEGIN
				ROLLBACK TRAN
				return 0
			END
		COMMIT

	end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH09_2_spXoaChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH09_2_spXoaChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable

		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham
		waitfor delay ''00:00:05''
		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			return 0
		
	commit tran







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH09_2_spThemChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'








CREATE proc [dbo].[TH09_2_spThemChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			return -1
		else
			begin
				waitfor delay ''00:00:05''

				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end
	commit tran




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH08_2_spCapNhatChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH08_2_spCapNhatChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					waitfor delay ''00:00:05''
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong				
					where MaDDH = @maddh and MaTangPham = @matangpham
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
	
	commit tran






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH08_2_spXoaChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE proc [dbo].[TH08_2_spXoaChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham
		waitfor delay ''00:00:05''
		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			return 0
	commit tran






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH09_1_spThemChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE proc [dbo].[TH09_1_spThemChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			return -1
		else
			begin

				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end
		waitfor delay ''00:00:05''
	rollback tran







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH09_1_spXoaChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'









CREATE proc [dbo].[TH09_1_spXoaChiTietDonDatHang_b]
@maddh int,
@matangpham int
as
	begin tran
		set transaction isolation level read uncommitted

		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			return 0
	commit tran










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH06_1_spCapNhatChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE proc [dbo].[TH06_1_spCapNhatChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong	
					where	MaDDH = @maddh and MaTangPham = @matangpham			
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
	waitfor delay ''00:00:05''
	rollback tran




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH06_1_spCapNhatChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE proc [dbo].[TH06_1_spCapNhatChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		--set transaction isolation level read uncommitted
		set transaction isolation level read committed
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong				
					where MaDDH = @maddh and MaTangPham = @matangpham
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
	commit tran






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH10_2_spThemChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE proc [dbo].[TH10_2_spThemChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			return -1
		else
			begin
		
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end
			waitfor delay ''00:00:05''

	commit tran










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH10_1_spThemChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



create proc [dbo].[TH10_1_spThemChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level read uncommitted
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			return -1
		else
			begin

				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end
		waitfor delay ''00:00:05''

	rollback tran










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH08_1_spCapNhatChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





create proc [dbo].[TH08_1_spCapNhatChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong				
					where MaDDH = @maddh and MaTangPham = @matangpham
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
	waitfor delay ''00:00:05''
	rollback tran





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH08_1_spXoaChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




create proc [dbo].[TH08_1_spXoaChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level read uncommitted
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			return 0
	commit tran





' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH07_2_spCapNhatChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'








CREATE proc [dbo].[TH07_2_spCapNhatChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable

		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					waitfor delay ''00:00:05''
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong		
					where MaDDH = @maddh and MaTangPham = @matangpham		
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
		
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH07_2_spThemChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE proc [dbo].[TH07_2_spThemChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			return -1
		else
			begin
				waitfor delay ''00:00:05''

				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end
	commit tran






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH06_2_spCapNhatChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH06_2_spCapNhatChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					waitfor delay ''00:00:05''
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong				
					where MaDDH = @maddh and MaTangPham = @matangpham
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				rollback tran
				--return 0	
		end
		else
			--return 0
			rollback tran
	commit tran

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH06_2_spCapNhatChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE proc [dbo].[TH06_2_spCapNhatChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable

		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					waitfor delay ''00:00:05''

					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong				
					where MaDDH = @maddh and MaTangPham = @matangpham
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
	commit tran







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSChiTietDDHTheoMaDDH]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--1. Lấy ds chi tiết đơn đặt hàng theo mã DDH
-- Thu Hà
CREATE proc [dbo].[spLayDSChiTietDDHTheoMaDDH]
@maddh int
as
	begin
		select * from dbo.CHI_TIET_DDH
		where MaDDH = @maddh
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH04_1_spThemChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[TH04_1_spThemChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as

begin tran


	begin
		
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			begin
				rollback tran
				return -1
			end
		else
			begin
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end 
	end
waitfor delay ''00:00:05''
rollback tran


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH04_2_spThemChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[TH04_2_spThemChiTietDonDatHang_a]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as

begin tran
set transaction isolation level read uncommitted -- mất dữ liệu cập nhật
--set transaction isolation level repeatable read -- deadlock
	begin
		
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC

		waitfor delay ''00:00:05''

		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			begin
				rollback tran
				return -1
			end
		else
			begin
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end 
	end
waitfor delay ''00:00:05''
commit tran


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH04_2_spThemChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[TH04_2_spThemChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as

begin tran
set transaction isolation level read uncommitted -- mất dữ liệu cập nhật
--set transaction isolation level repeatable read -- deadlock
	begin
		
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC

		waitfor delay ''00:00:05''

		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			begin
				rollback tran
				return -1
			end
		else
			begin
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end 
	end
waitfor delay ''00:00:05''
commit tran


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH05_1_spXoaChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[TH05_1_spXoaChiTietDonDatHang_b]
@maddh int,
@matangpham int
as

begin tran
set transaction isolation level read uncommitted -- dữ liệu rác
--set transaction isolation level read committed 
	begin
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			begin
				rollback tran
				return 0
			end
	end

commit tran



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH05_2_spXoaChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE proc [dbo].[TH05_2_spXoaChiTietDonDatHang_b]
@maddh int,
@matangpham int
as

begin tran
--set transaction isolation level read uncommitted -- mất dữ liệu cập nhật
set transaction isolation level repeatable read

	begin
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		waitfor delay ''00:00:05''

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			begin
				rollback tran
				return 0
			end
	waitfor delay ''00:00:05''
	end
commit tran




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH05_1_spXoaChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE proc [dbo].[TH05_1_spXoaChiTietDonDatHang_a]
@maddh int,
@matangpham int
as

begin tran
set transaction isolation level read uncommitted -- dữ liệu rác
--set transaction isolation level read committed 
	begin
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			begin
				rollback tran
				return 0
			end
	waitfor delay ''00:00:05''
	end
rollback tran



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH05_2_spXoaChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE proc [dbo].[TH05_2_spXoaChiTietDonDatHang_a]
@maddh int,
@matangpham int
as

begin tran
--set transaction isolation level read uncommitted -- mất dữ liệu cập nhật
set transaction isolation level repeatable read

	begin
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		waitfor delay ''00:00:05''

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			begin
				rollback tran
				return 0
			end
	waitfor delay ''00:00:05''
	end
commit tran




' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH04_1_spThemChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE proc [dbo].[TH04_1_spThemChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as

begin tran

set transaction isolation level read uncommitted -- dữ liệu rác
--set transaction isolation level read committed -- ok
	begin
		
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			begin
				rollback tran
				return -1
			end
		else
			begin
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end 
	end
commit tran


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH12_1_spXoaChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[TH12_1_spXoaChiTietDonDatHang_a]
@maddh int,
@matangpham int
as
	begin tran
		declare @slton int, @slhuy int
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham

		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @slhuy
			where MaTangPham = @matangpham
		else
			return 0
	waitfor delay ''00:00:05''
	rollback tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH11_1_spCapNhatChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH11_1_spCapNhatChiTietDonDatHang_a]
(
	@maddh int,
	@matangpham int,
	@soluong int,
	@diemthuong int
)
as
	begin tran
	
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong				
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
	waitfor delay ''00:00:5''

rollback tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH15_2_spThemChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[TH15_2_spThemChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level serializable
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			rollback tran
		else
			begin
				waitfor delay ''00:00:10''

				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH15_1_spThemChiTietDonDatHang_b]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[TH15_1_spThemChiTietDonDatHang_b]
@maddh int,
@matangpham int,
@soluong int,
@diemthuong int
as
	begin tran
		set transaction isolation level read uncommitted
		declare @diemYC int, @slton int, @sltoida int, @tongdiem int
		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		set @tongdiem = @soluong*@diemYC
		if( @soluong > @slton or @soluong > @sltoida or @tongdiem > @diemthuong)
			rollback tran
		else
			begin
				
				INSERT INTO CHI_TIET_DDH
							  (MaDDH, MaTangPham, SoLuong)
				VALUES     (@maddh,@matangpham,@soluong)
				if(@@error = 0)
					UPDATE    TANG_PHAM
					SET       SoLuongConLai = @slton - @soluong
					where MaTangPham = @matangpham
			end
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH11_2_spCapNhatChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH11_2_spCapNhatChiTietDonDatHang_a]
(
	@maddh int,
	@matangpham int,
	@soluong int,
	@diemthuong int
)
as
	begin tran
		set transaction isolation level serializable
		declare @diemYC int, -- số điểm thưởng yêu cầu của 1 tặng phẩm
				@slton int, -- số lượng tồn của tặng phẩm
				@sltoida int, -- số lượng tặng phẩm tối đa được mua
				@tongdiem int --tổng điểm yêu cầu cho n tặng phẩm đã chọn

		select @diemYC = DiemThuongYC, @slton = SoLuongConLai, @sltoida = SoLuongToiDa 
		from TANG_PHAM where matangpham = @matangpham
		--số lượng tặng phẩm đã chọn trước đó
		declare @slmuabandau int
		select @slmuabandau = SoLuong 
		from CHI_TIET_DDH 
		where MaDDH = @maddh and MaTangPham = @matangpham
	
		set @tongdiem = @soluong*@diemYC
		
		if ((@soluong < @slmuabandau) or 
			(@soluong > @slmuabandau and (@slton >= (@soluong - @slmuabandau))))
		
		begin
			if(@diemthuong >= @tongdiem and @soluong <= @sltoida)
				begin
					waitfor delay ''00:00:5''
					UPDATE    CHI_TIET_DDH
					SET      SoLuong = @soluong				
					if(@@error = 0)
						UPDATE    TANG_PHAM
						SET       SoLuongConLai = @slton + @slmuabandau - @soluong
						where MaTangPham = @matangpham
				end 
			else
				return 0	
		end
		else
			return 0
	

commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH12_2_spXoaChiTietDonDatHang_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE proc [dbo].[TH12_2_spXoaChiTietDonDatHang_a]
(
	@maddh int,
	@matangpham int
)
as
	begin tran
		set transaction isolation level serializable
		--fix
		--set transaction isolation level repeatable read
		declare @slton int, @slhuy int
		waitfor delay ''00:00:10''
		select @slhuy = SoLuong 
		from CHI_TIET_DDH 
		where matangpham = @matangpham and MaDDH = @maddh

		select @slton = SoLuongConLai
		from TANG_PHAM where matangpham = @matangpham
		
		delete from CHI_TIET_DDH where MaDDH = @maddh and MaTangPham = @matangpham
		
		if(@@error = 0)
			begin
				waitfor delay ''00:00:05''
				UPDATE    TANG_PHAM
				SET       SoLuongConLai = @slton + @slhuy
				where MaTangPham = @matangpham
				
			end
		else
			return 0
		
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH15_2_spCapNhatSoLuongTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[TH15_2_spCapNhatSoLuongTangPham_a]
@matangpham int,
@soluongtp int
as
	begin tran 
		set transaction isolation level serializable
		declare @slbandau int
		declare @slton int
		select @slbandau = SoLuongTP, @slton = SoLuongConLai from TANG_PHAM where MaTangPham = @matangpham
		if(@slbandau > @soluongtp)
			begin
				raiserror (N''Chỉ được tăng số lượng!'',1,16)
				rollback tran
			end
		else
			waitfor delay ''00:00:05''
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @soluongtp - @slbandau, SoLuongTP = @soluongtp
			WHERE	MaTangPham = @matangpham
		
	commit tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH15_1_spCapNhatSoLuongTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create proc [dbo].[TH15_1_spCapNhatSoLuongTangPham_a]
@matangpham int,
@soluongtp int
as
	begin tran 
		declare @slbandau int
		declare @slton int
		select @slbandau = SoLuongTP, @slton = SoLuongConLai from TANG_PHAM where MaTangPham = @matangpham
		if(@slbandau > @soluongtp)
			begin
				raiserror (N''Chỉ được tăng số lượng!'',1,16)
				rollback tran
			end
		else
			UPDATE    TANG_PHAM
			SET       SoLuongConLai = @slton + @soluongtp - @slbandau, SoLuongTP = @soluongtp
			WHERE	MaTangPham = @matangpham
		waitfor delay ''00:00:05''
	rollback tran
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayTangPhamTheoMaTP]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

--12.Lấy tặng phẩm theo mã tặng phẩm
CREATE proc [dbo].[spLayTangPhamTheoMaTP]
@matangpham int
as
	begin
		select * from TANG_PHAM where MaTangPham = @matangpham
	end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH17_1_spCapNhatTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'






CREATE proc [dbo].[TH17_1_spCapNhatTangPham_a]
@matangpham int,
@soluongtp int
as
	begin
		BEGIN TRAN
		
		Declare @soluongtpbandau int
		Declare @soluongtpconlai int
		SELECT @soluongtpbandau = SoLuongTP, @soluongtpconlai= SoLuongConLai
		FROM TANG_PHAM
		WHERE MaTangPham = @matangpham
		
		if (@soluongtp >= @soluongtpbandau)
		BEGIN
			UPDATE    TANG_PHAM
			SET      SoLuongTP = @soluongtp, SoLuongConLai = @soluongtpconlai + (@soluongtp - @soluongtpbandau)
			where MaTangPham = @matangpham
		END
			
		waitfor delay ''00:00:10''
		
		ROLLBACK TRAN
		
	end







' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spThemTangPham]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE proc [dbo].[spThemTangPham]
@tentangpham nvarchar(50),
@diemthuongyc int,
@soluongtp int,
@soluongtoida int,
@soluongconlai int,
@masanpham int,
@hinhanh varchar(50)
as
	begin
		INSERT INTO TANG_PHAM
                      (TenTangPham, DiemThuongYC, SoLuongTP, SoLuongToiDa, SoLuongConLai, MaSanPham, HinhAnh)
		VALUES     (@tentangpham,@diemthuongyc,@soluongtp,@soluongtoida,@soluongconlai,@masanpham, @hinhanh)
	end

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH18_2_spCapNhatTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'











CREATE proc [dbo].[TH18_2_spCapNhatTangPham_a]
@matangpham int,
@soluongtp int
as
	begin
		BEGIN TRAN
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
		Declare @soluongtpbandau int
		Declare @soluongtpconlai int
		SELECT @soluongtpbandau = SoLuongTP, @soluongtpconlai= SoLuongConLai
		FROM TANG_PHAM
		WHERE MaTangPham = @matangpham
		
		waitfor delay ''00:00:10''
	

		if (@soluongtp >= @soluongtpbandau)
		BEGIN
			UPDATE    TANG_PHAM
			SET      SoLuongTP = @soluongtp, SoLuongConLai = @soluongtpconlai + (@soluongtp - @soluongtpbandau)
			where MaTangPham = @matangpham
		END
			
		COMMIT
		
	end












' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spCapNhatTangPham]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE proc [dbo].[spCapNhatTangPham]
@matangpham int,
@tentangpham nvarchar(50),
@diemthuongyc int,
@soluongtp int,
@soluongtoida int,
@soluongconlai int,
@masanpham int
as
	begin
						
		Declare @soluongtpbandau int
		Declare @soluongtpconlai int
		SELECT @soluongtpbandau = SoLuongTP, @soluongtpconlai= SoLuongConLai
		FROM TANG_PHAM
		WHERE MaTangPham = @matangpham
		
		if (@soluongtp >= @soluongtpbandau)
		BEGIN
			UPDATE    TANG_PHAM
			SET      SoLuongTP = @soluongtp, SoLuongConLai = @soluongtpconlai + (@soluongtp - @soluongtpbandau)
			where MaTangPham = @matangpham
		END
	end



' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH17_2_spCapNhatTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE proc [dbo].[TH17_2_spCapNhatTangPham_a]
@matangpham int,
@soluongtp int
as
	begin
		BEGIN TRAN
		
		Declare @soluongtpbandau int
		Declare @soluongtpconlai int
		SELECT @soluongtpbandau = SoLuongTP, @soluongtpconlai= SoLuongConLai
		FROM TANG_PHAM
		WHERE MaTangPham = @matangpham
		
		waitfor delay ''00:00:10''
		
		if (@soluongtp >= @soluongtpbandau)
		BEGIN
			UPDATE    TANG_PHAM
			SET      SoLuongTP = @soluongtp, SoLuongConLai = @soluongtpconlai + (@soluongtp - @soluongtpbandau)
			where MaTangPham = @matangpham
		END
			
		COMMIT
		
	end








' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH18_1_spCapNhatTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'









CREATE proc [dbo].[TH18_1_spCapNhatTangPham_a]
@matangpham int,
@soluongtp int
as
	begin
		BEGIN TRAN
		
		Declare @soluongtpbandau int
		Declare @soluongtpconlai int
		SELECT @soluongtpbandau = SoLuongTP, @soluongtpconlai= SoLuongConLai
		FROM TANG_PHAM
		WHERE MaTangPham = @matangpham
		
		if (@soluongtp >= @soluongtpbandau)
		BEGIN
			UPDATE    TANG_PHAM
			SET      SoLuongTP = @soluongtp, SoLuongConLai = @soluongtpconlai + (@soluongtp - @soluongtpbandau)
			where MaTangPham = @matangpham
		END
			
		waitfor delay ''00:00:10''
		
		ROLLBACK TRAN
		
	end










' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH16_1_spCapNhatTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





CREATE proc [dbo].[TH16_1_spCapNhatTangPham_a]
@matangpham int,
@soluongtp int
as
	begin
		BEGIN TRAN
		
		Declare @soluongtpbandau int
		Declare @soluongtpconlai int
		SELECT @soluongtpbandau = SoLuongTP, @soluongtpconlai= SoLuongConLai
		FROM TANG_PHAM
		WHERE MaTangPham = @matangpham
		
		if (@soluongtp >= @soluongtpbandau)
		BEGIN
			UPDATE    TANG_PHAM
			SET      SoLuongTP = @soluongtp, SoLuongConLai = @soluongtpconlai + (@soluongtp - @soluongtpbandau)
			where MaTangPham = @matangpham
		END
			
		waitfor delay ''00:00:10''
		
		ROLLBACK TRAN
		
	end






' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH20_3_spXoaTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--Thu Hà 26.5.2011

CREATE proc [dbo].[TH20_3_spXoaTangPham_a]
@matangpham int

as
	begin
		BEGIN TRAN
	
		DELETE FROM TANG_PHAM WHERE MaTangPham = @matangpham
		
		COMMIT
	end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spXoaTangPham]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'--Thu Hà 26.5.2011

CREATE proc [dbo].[spXoaTangPham]
@matangpham int

as
	begin
		DELETE FROM TANG_PHAM WHERE MaTangPham = @matangpham
	end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSTangPhamTheoMaSP]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

--12.Lấy tặng phẩm theo mã sản phẩm
CREATE proc [dbo].[spLayDSTangPhamTheoMaSP]
@masanpham int
as
	begin
		select * from TANG_PHAM where MaSanPham = @masanpham
	end


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spLayDSTangPhamTheoTen]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
--12.Lấy tặng phẩm theo tên
create proc [dbo].[spLayDSTangPhamTheoTen]
@tentangpham nvarchar(50)
as
	begin
		select * from TANG_PHAM where TenTangPham like @tentangpham
	end
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TH16_2_spCapNhatTangPham_a]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'







CREATE proc [dbo].[TH16_2_spCapNhatTangPham_a]
@matangpham int,
@soluongtp int
as
	begin
		BEGIN TRAN
		
		SET TRANSACTION ISOLATION LEVEL SERIALIZABLE		

		Declare @soluongtpbandau int
		Declare @soluongtpconlai int
		SELECT @soluongtpbandau = SoLuongTP, @soluongtpconlai= SoLuongConLai
		FROM TANG_PHAM
		WHERE MaTangPham = @matangpham
		
	    waitfor delay ''00:00:10''		

		if (@soluongtp >= @soluongtpbandau)
		BEGIN
			UPDATE    TANG_PHAM
			SET      SoLuongTP = @soluongtp, SoLuongConLai = @soluongtpconlai + (@soluongtp - @soluongtpbandau)
			where MaTangPham = @matangpham
		END
		
		COMMIT
		
	end








' 
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SAN_PHAM_DANH_MUC_SAN_PHAM]') AND parent_object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]'))
ALTER TABLE [dbo].[SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [FK_SAN_PHAM_DANH_MUC_SAN_PHAM] FOREIGN KEY([MaDanhMuc])
REFERENCES [dbo].[DANH_MUC_SAN_PHAM] ([Ma])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_SAN_PHAM_QUAN_LY]') AND parent_object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]'))
ALTER TABLE [dbo].[SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [FK_SAN_PHAM_QUAN_LY] FOREIGN KEY([MaNguoiNhap])
REFERENCES [dbo].[QUAN_LY] ([MaQuanLy])
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_diemThuong]') AND parent_object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]'))
ALTER TABLE [dbo].[SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [c_diemThuong] CHECK  (([DiemThuong]>(0)))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_donGia]') AND parent_object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]'))
ALTER TABLE [dbo].[SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [c_donGia] CHECK  (([DonGia]>(0)))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_soLuongSanPham]') AND parent_object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]'))
ALTER TABLE [dbo].[SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [c_soLuongSanPham] CHECK  (([SoLuongSP]>(0)))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_tgBatDauBan_tgKetThucBan]') AND parent_object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]'))
ALTER TABLE [dbo].[SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [c_tgBatDauBan_tgKetThucBan] CHECK  (([ThoiGianBD_Ban]<[ThoiGianKT_Ban]))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_tgBatDauNhanHang_tgKetThucBanHang]') AND parent_object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]'))
ALTER TABLE [dbo].[SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [c_tgBatDauNhanHang_tgKetThucBanHang] CHECK  (([ThoiGianBD_NhanHang]>=[ThoiGianKT_Ban]))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_tgBatDauNhanSP_tgKetThucNhanSP]') AND parent_object_id = OBJECT_ID(N'[dbo].[SAN_PHAM]'))
ALTER TABLE [dbo].[SAN_PHAM]  WITH CHECK ADD  CONSTRAINT [c_tgBatDauNhanSP_tgKetThucNhanSP] CHECK  (([ThoiGianBD_NhanHang]<[ThoiGianKT_NhanHang]))
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DON_DAT_HANG_DAI_LY]') AND parent_object_id = OBJECT_ID(N'[dbo].[DON_DAT_HANG]'))
ALTER TABLE [dbo].[DON_DAT_HANG]  WITH NOCHECK ADD  CONSTRAINT [FK_DON_DAT_HANG_DAI_LY] FOREIGN KEY([MaDaiLy])
REFERENCES [dbo].[DAI_LY] ([MaDaiLy])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DON_DAT_HANG_KHACH_HANG]') AND parent_object_id = OBJECT_ID(N'[dbo].[DON_DAT_HANG]'))
ALTER TABLE [dbo].[DON_DAT_HANG]  WITH CHECK ADD  CONSTRAINT [FK_DON_DAT_HANG_KHACH_HANG] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[KHACH_HANG] ([MaKhachHang])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DON_DAT_HANG_SAN_PHAM]') AND parent_object_id = OBJECT_ID(N'[dbo].[DON_DAT_HANG]'))
ALTER TABLE [dbo].[DON_DAT_HANG]  WITH CHECK ADD  CONSTRAINT [FK_DON_DAT_HANG_SAN_PHAM] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SAN_PHAM] ([MaSanPham])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DON_DAT_HANG_TRANG_THAI]') AND parent_object_id = OBJECT_ID(N'[dbo].[DON_DAT_HANG]'))
ALTER TABLE [dbo].[DON_DAT_HANG]  WITH CHECK ADD  CONSTRAINT [FK_DON_DAT_HANG_TRANG_THAI] FOREIGN KEY([TrangThai])
REFERENCES [dbo].[TRANG_THAI] ([MaTrangThai])
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_soLuongDat]') AND parent_object_id = OBJECT_ID(N'[dbo].[DON_DAT_HANG]'))
ALTER TABLE [dbo].[DON_DAT_HANG]  WITH CHECK ADD  CONSTRAINT [c_soLuongDat] CHECK  (([SoLuongDat]>(0)))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_thanhTien]') AND parent_object_id = OBJECT_ID(N'[dbo].[DON_DAT_HANG]'))
ALTER TABLE [dbo].[DON_DAT_HANG]  WITH CHECK ADD  CONSTRAINT [c_thanhTien] CHECK  (([ThanhTien]>=(0)))
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CHI_TIET_DDH_DON_DAT_HANG]') AND parent_object_id = OBJECT_ID(N'[dbo].[CHI_TIET_DDH]'))
ALTER TABLE [dbo].[CHI_TIET_DDH]  WITH CHECK ADD  CONSTRAINT [FK_CHI_TIET_DDH_DON_DAT_HANG] FOREIGN KEY([MaDDH])
REFERENCES [dbo].[DON_DAT_HANG] ([MaDDH])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_CHI_TIET_DDH_TANG_PHAM]') AND parent_object_id = OBJECT_ID(N'[dbo].[CHI_TIET_DDH]'))
ALTER TABLE [dbo].[CHI_TIET_DDH]  WITH CHECK ADD  CONSTRAINT [FK_CHI_TIET_DDH_TANG_PHAM] FOREIGN KEY([MaTangPham])
REFERENCES [dbo].[TANG_PHAM] ([MaTangPham])
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_soLuong]') AND parent_object_id = OBJECT_ID(N'[dbo].[CHI_TIET_DDH]'))
ALTER TABLE [dbo].[CHI_TIET_DDH]  WITH CHECK ADD  CONSTRAINT [c_soLuong] CHECK  (([SoLuong]>(0)))
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_QUAN_LY_TAI_KHOAN]') AND parent_object_id = OBJECT_ID(N'[dbo].[QUAN_LY]'))
ALTER TABLE [dbo].[QUAN_LY]  WITH CHECK ADD  CONSTRAINT [FK_QUAN_LY_TAI_KHOAN] FOREIGN KEY([MaQuanLy])
REFERENCES [dbo].[TAI_KHOAN] ([MaTaiKhoan])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_KHACH_HANG_TAI_KHOAN]') AND parent_object_id = OBJECT_ID(N'[dbo].[KHACH_HANG]'))
ALTER TABLE [dbo].[KHACH_HANG]  WITH CHECK ADD  CONSTRAINT [FK_KHACH_HANG_TAI_KHOAN] FOREIGN KEY([MaKhachHang])
REFERENCES [dbo].[TAI_KHOAN] ([MaTaiKhoan])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DAI_LY_TAI_KHOAN]') AND parent_object_id = OBJECT_ID(N'[dbo].[DAI_LY]'))
ALTER TABLE [dbo].[DAI_LY]  WITH CHECK ADD  CONSTRAINT [FK_DAI_LY_TAI_KHOAN] FOREIGN KEY([MaDaiLy])
REFERENCES [dbo].[TAI_KHOAN] ([MaTaiKhoan])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_TANG_PHAM_SAN_PHAM]') AND parent_object_id = OBJECT_ID(N'[dbo].[TANG_PHAM]'))
ALTER TABLE [dbo].[TANG_PHAM]  WITH CHECK ADD  CONSTRAINT [FK_TANG_PHAM_SAN_PHAM] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SAN_PHAM] ([MaSanPham])
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_diemThuongYC]') AND parent_object_id = OBJECT_ID(N'[dbo].[TANG_PHAM]'))
ALTER TABLE [dbo].[TANG_PHAM]  WITH CHECK ADD  CONSTRAINT [c_diemThuongYC] CHECK  (([DiemThuongYC]>(0)))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_soLuongTP]') AND parent_object_id = OBJECT_ID(N'[dbo].[TANG_PHAM]'))
ALTER TABLE [dbo].[TANG_PHAM]  WITH CHECK ADD  CONSTRAINT [c_soLuongTP] CHECK  (([SoLuongTP]>(0)))
GO
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[c_soTangPhamToiDa]') AND parent_object_id = OBJECT_ID(N'[dbo].[TANG_PHAM]'))
ALTER TABLE [dbo].[TANG_PHAM]  WITH CHECK ADD  CONSTRAINT [c_soTangPhamToiDa] CHECK  (([SoLuongToiDa]>(0)))
