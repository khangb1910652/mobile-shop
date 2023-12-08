-- show databases;
-- drop database NLCS;
-- create database NLCS;
-- use NLCS;

create table hang(
	id_hang varchar(50) primary key,
    ten_hang varchar(50) not null,
    img varchar(200) not null
);
create table loai(
	id_loai varchar(50) primary key,
    ten_loai varchar(50) not null,
    id_hang varchar(50) references hang(id_hang)
);
create table san_pham(
	id_sp varchar(50) primary key,
    ten_sp varchar(50) not null,
    id_loai varchar(50) not null references hang(id_loai),
    id_tt varchar(50) references thong_tin(id_tt),
    mo_ta varchar(2000)
);
create table chi_tiet_sp(
	id_chitiet varchar(50) primary key,
	dung_luong varchar(50),
    gia float default 0 check (gia >=0),
    id_sp varchar(50) not null references san_pham(id_sp)
);
create table mau_sac(
	id_mau varchar(50) primary key,
    mau varchar(50) not null,
    anh varchar(200) not null,
    id_sp varchar(50) not null references san_pham(id_sp)
);
create table thong_tin(
	id_tt varchar(50) primary key,
    cn_man varchar(100),
    do_phan_giai varchar(100),
    kich_thuoc varchar(100),
    do_sang varchar(100),
    mat_kinh varchar(100),
    camera_sau varchar(100),
	den_flash varchar(100),
    camera_truoc varchar(100),
    he_dieu_hanh varchar(100),
    CPU varchar(100),
    GPU varchar(100),
    ram varchar(100),
    mang_di_dong varchar(100),
    sim varchar(100),
    wifi varchar(100),
    bluetooth varchar(100),
    cong_sac varchar(100),
    ket_noi_khac varchar(100),
    dung_luong_pin varchar(100),
    loai_pin varchar(100),
    toc_do_sac varchar(100),
    cong_nghe_pin varchar(100)
);
create table Bill(
	id_bill varchar(50) primary key,
    sdt varchar(11) not null,
	ho_ten varchar(50) not null,
    dia_chi varchar(500) not null,
    ngay_lap timestamp default current_timestamp
);
create table chi_tiet_bill(
	id_ctbill int primary key AUTO_INCREMENT,
    id_chitiet varchar(50) references chi_tiet_sp(id_chitiet),
    id_mau varchar(50) not null references mau_sac(id_mau),
    amount numeric(10) default 0 check (amount >=0),
    price float default 0 check (price >=0),
    id_bill varchar(50) not null references bill(id_bill)
);


delimiter //
create procedure addBill(
    id_bill varchar(50),
    sdt varchar(11),
    ho_ten varchar(50),
    dia_chi varchar(500))
begin
	insert into bill(id_bill,sdt,ho_ten,dia_chi) value(id_bill,sdt,ho_ten,dia_chi);
    commit;
end//
delimiter ;

delimiter //
create procedure addCTBill(
    id_sp varchar(50),
    dung_luong varchar(50),
    mau_sac varchar(50),
    amount numeric(10),
	id_bill varchar(50))
begin
	insert into chi_tiet_bill(id_chitiet,id_mau,amount, price,id_bill) 
    value(
    (select c.id_chitiet from  san_pham s join chi_tiet_sp c on s.id_sp = c.id_sp where s.id_sp = id_sp and c.dung_luong = dung_luong),
    (select m.id_mau from  san_pham s join mau_sac m on s.id_sp = m.id_sp where s.id_sp = id_sp and m.mau = mau_sac),
    amount,
    (select c.gia from  san_pham s join chi_tiet_sp c on s.id_sp = c.id_sp where s.id_sp = id_sp and c.dung_luong = dung_luong) * amount,
    id_bill);
    commit;
end//
delimiter ;

-- create table Total_Bill(
-- 	id_total_bill varchar(50) primary key,
--     id_bill varchar(50) references bill(id_bill),   
--     account_customer varchar(50) references customer(account),
--     date date not null,
-- 	total_price float default 0 check (total_price >=0)
-- );
-- create table Customer(
-- 	account varchar(50) primary key,
--     password varchar(50) not null,
--     name_customer varchar(50) not null,
--     gender varchar(6) not null,
--     birthDay date not null,
--     phone numeric(11) not null,
--     address varchar(100) not null,
--     isAdmin numeric(1) not null
-- );

-- insert data
-- insert hang
insert into hang values("apple","Apple","img");
insert into hang values("samsung","Samsung","img");
insert into hang values("oppo","OPPO","img");
insert into hang values("xiaomi","Xiaomi","img");
insert into hang values("vivo","VIVO","img");

-- insert loai
insert into loai values("iphone","Phones","apple");
insert into loai values("ipad","Tablet","apple");
insert into loai values("airpod","Headphone","apple");
insert into loai values("applewatch","Watch","apple");

insert into loai values("ss","Phones","samsung");
insert into loai values("sstab","Tablet","samsung");
insert into loai values("ssbud","Headphone","samsung");
insert into loai values("glxwatch","Watch","samsung");

insert into loai values("opo","Phones","oppo");
insert into loai values("oppobud","Headphone","oppo");
insert into loai values("oppowatch","Watch","oppo");

insert into loai values("mi","Phones","xiaomi");
-- insert into loai values("tablet","Tablet","oppo");
-- insert into loai values("airpod","Headphone","oppo");

insert into loai values("vv","Phones","vivo");
-- insert into loai values("tablet","Tablet","oppo");
-- insert into loai values("airpod","Headphone","oppo");
-- insert thong tin
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone13promax", "OLED", "1284 x 2778 Pixels", "6.7' - Tần số quét 120 Hz", "1200 nits ", "Kính cường lực Ceramic Shield", "3 camera 12 MP",
		"Có", "12MP", "iOS 15", "Apple A15 Bionic 6 nhân 3.22 GHz", "Apple GPU 5 nhân", "6GB", "Hỗ trợ 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "4352 mAh", "Li-lon", "20 W", "Sạc không dây MagSafe" );
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphonese2022", "IPS LCD", "HD (750 x 1334 Pixels)", "4.7' - Tần số quét 60 Hz", "625 nits ", "Đang cập nhật", "12 MP",
		"Có", "7MP", "iOS 15", "Apple A15 Bionic 6 nhân", "Đang cập nhật", "3GB", "Hỗ trợ 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "Đang cập nhật", "Li-lon", "20 W", "Sạc không dây" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone13", "OLED", "1170 x 2532 Pixels", "6.1' - Tần số quét 60 Hz", "1200 nits ", "Kính cường lực Ceramic Shield", "2 camera 12 MP",
		"Có", "12MP", "iOS 15", "Apple A15 Bionic 6 nhân 3.22 GHz", "Apple GPU 4 nhân", "4GB", "Hỗ trợ 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "3240 mAh", "Li-lon", "20 W", "Sạc không dây MagSafe" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone13mini", "OLED", "1080 x 2340 Pixels", "5.4' - Tần số quét 60 Hz", "1200 nits ", "Kính cường lực Ceramic Shield", "2 camera 12 MP",
		"Có", "12MP", "iOS 15", "Apple A15 Bionic 6 nhân 3.22 GHz", "Apple GPU 4 nhân", "4GB", "Hỗ trợ 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "2438 mAh", "Li-lon", "20 W", "Sạc không dây MagSafe" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone12", "OLED", "1170 x 2532 Pixels", "6.1' - Tần số quét 60 Hz", "1200 nits ", "Kính cường lực Ceramic Shield", "2 camera 12 MP",
		"Có", "12MP", "iOS 15", "Apple A14 Bionic 6 nhân", "Apple GPU 4 nhân", "4GB", "Hỗ trợ 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "2815 mAh", "Li-lon", "20 W", "Sạc không dây MagSafe" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone13pro", "OLED", "1170 x 2532 Pixels", "6.1' - Tần số quét 120 Hz", "1200 nits ", "Kính cường lực Ceramic Shield", "3 camera 12 MP",
		"Có", "12MP", "iOS 15", "Apple A15 Bionic 6 nhân 3.22 GHz", "Apple GPU 5 nhân", "6GB", "Hỗ trợ 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "3095 mAh", "Li-lon", "20 W", "Sạc không dây MagSafe" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphone11", "IPS LCD", "828 x 1792 Pixels", "6.1' - Tần số quét 60 Hz", "625 nits ", "Kính cường lực Oleophobic (ion cường lực)", "2 camera 12 MP",
		"3 đèn LED 2 tông màu", "12MP", "iOS 15", "Apple A13 Bionic 6 nhân", "Apple GPU 4 nhân", "4GB", "Hỗ trợ 4G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC, OTG", "3110 mAh", "Li-lon", "18 W", "Sạc không dây" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("iphonexr", "IPS LCD", "828 x 1792 Pixels", "6.1' - Tần số quét 60 Hz", "625 nits ", "Kính cường lực Oleophobic (ion cường lực)", "12 MP",
		"4 đèn LED 2 tông màu", "7MP", "iOS 15", "Apple A12 Bionic 6 nhân", "Apple GPU 4 nhân", "3GB", "Hỗ trợ 4G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Lightning", "NFC", "2942 mAh", "Li-lon", "18 W", "Sạc không dây" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("zfold3", "Dynamic AMOLED 2X", "Full HD+ (1768 x 2208 Pixels)", "Chính 7.6' & Phụ 6.2' - Tần số quét 120 Hz", "Chính 1200 nits & Phụ 1500 nits", "Kính cường lực Corning Gorilla Glass Victus", "3 camera 12 MP",
		"Có", "10 MP & 4 MP", "Android 11", "Snapdragon 888 8 nhân", "Adreno 660", "12GB", "Hỗ trợ 5G", "2 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "4400 mAh", "Li-lon", "25 W", "Sạc không dây, sạc ngược không dây" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("zflip", "Dynamic AMOLED 2X", "Full HD+ (1080 x 2640 Pixels)", "Chính 6.7' & Phụ 1.9' - Tần số quét 120 Hz", "Chính 1200 nits", "Kính siêu mỏng Ultra Thin Glass (UTG)", "2 camera 12 MP",
		"Có", "10 MP & 4 MP", "Android 11", "Snapdragon 888 8 nhân", "Adreno 660", "8GB", "Hỗ trợ 5G", "1 Nano SIM & 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "3300 mAh", "Li-lon", "15 W", "Sạc không dây, sạc ngược không dây" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("s22ultra", "Dynamic AMOLED 2X", "Quad HD+ (2K+) (1440 x 3088 Pixels)", "6.8' - Tần số quét 120 Hz", "1750 nits", "Kính cường lực Corning Gorilla Glass Victus+", "Chính 108 MP & Phụ 12 MP, 10 MP, 10 MP",
		"Đèn LED kép", "40 MP", "Android 12", "Snapdragon 8 Gen 1 8 nhân", "Adreno 730", "8GB", "Hỗ trợ 5G", "2 Nano SIM hoặc 1 Nano SIM + 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "5000 mAh", "Li-lon", "45 W", "Sạc không dây, sạc ngược không dây" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("s22+", "Dynamic AMOLED 2X", "Full HD+ (1080 x 2340 Pixels)", "6.6' - Tần số quét 120 Hz", "1750 nits", "Kính cường lực Corning Gorilla Glass Victus+", "Chính 50 MP & Phụ 12 MP, 10 MP",
		"Đèn LED kép", "10 MP", "Android 12", "Snapdragon 8 Gen 1 8 nhân", "Adreno 730", "8GB", "Hỗ trợ 5G", "2 Nano SIM hoặc 1 Nano SIM + 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "4500 mAh", "Li-lon", "45 W", "Sạc không dây, sạc ngược không dây" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("s22", "Dynamic AMOLED 2X", "Full HD+ (1080 x 2340 Pixels)", "6.1' - Tần số quét 120 Hz", "1750 nits", "Kính cường lực Corning Gorilla Glass Victus+", "Chính 50 MP & Phụ 12 MP, 10 MP",
		"Đèn LED kép", "10 MP", "Android 12", "Snapdragon 8 Gen 1 8 nhân", "Adreno 730", "8GB", "Hỗ trợ 5G", "2 Nano SIM hoặc 1 Nano SIM + 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, OTG", "3700 mAh", "Li-lon", "25 W", "Sạc không dây, sạc ngược không dây" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("s21fe", "Dynamic AMOLED 2X", "Full HD+ (1080 x 2340 Pixels)", "6.4' - Tần số quét 120 Hz", "1200 nits", "Kính cường lực Corning Gorilla Glass Victus", "Chính 12 MP & Phụ 12 MP, 8 MP",
		"Có", "32 MP", "Android 12", "Exynos 2100 8 nhân", "Mali-G78 MP14", "6GB", "Hỗ trợ 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.0", "Type-C", "NFC, OTG", "4500 mAh", "Li-lon", "25 W", "Sạc không dây, sạc ngược không dây" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("m53", "Super AMOLED Plus", "Full HD+ (1080 x 2400 Pixels)", "6.7' - Tần số quét 120 Hz", "Đang cập nhật", "Kính cường lực Corning Gorilla Glass 5", "Chính 108 MP & Phụ 8 MP, 2 MP, 2 MP",
		"Có", "32 MP", "Android 12", "MediaTek Dimensity 900 5G", "Mali-G68", "8GB", "Hỗ trợ 5G", "2 Nano SIM (SIM 2 chung khe thẻ nhớ)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "NFC", "5000 mAh", "Li-lon", "25 W", "Sạc pin nhanh" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("a73", "Super AMOLED Plus", "Full HD+ (1080 x 2400 Pixels)", "6.7' - Tần số quét 120 Hz", "800 nits", "Kính cường lực Corning Gorilla Glass 5", "Chính 108 MP & Phụ 12 MP, 5 MP, 5 MP",
		"Có", "32 MP", "Android 12", "Snapdragon 778G 5G 8 nhân", "Adreno 642L", "8GB", "Hỗ trợ 5G", "2 Nano SIM (SIM 2 chung khe thẻ nhớ)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.1", "Type-C", "NFC", "5000 mAh", "Li-lon", "25 W", "Sạc pin nhanh" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("a53", "Super AMOLED Plus", "Full HD+ (1080 x 2400 Pixels)", "6.5' - Tần số quét 120 Hz", "800 nits", "Kính cường lực Corning Gorilla Glass 5", "Chính 64 MP & Phụ 12 MP, 5 MP, 5 MP",
		"Có", "32 MP", "Android 12", "Exynos 1280 8 nhân", "Mali-G68", "8GB", "Hỗ trợ 5G", "2 Nano SIM (SIM 2 chung khe thẻ nhớ)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.1", "Type-C", "NFC", "5000 mAh", "Li-lon", "25 W", "Sạc pin nhanh" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("a33", "Super AMOLED Plus", "Full HD+ (1080 x 2400 Pixels)", "6.4' - Tần số quét 90 Hz", "800 nits", "Kính cường lực Corning Gorilla Glass 5", "Chính 48 MP & Phụ 8 MP, 5 MP, 2 MP",
		"Có", "13 MP", "Android 12", "Exynos 1280 8 nhân", "Mali-G68", "6GB", "Hỗ trợ 5G", "2 Nano SIM (SIM 2 chung khe thẻ nhớ)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.1", "Type-C", "NFC", "5000 mAh", "Li-lon", "25 W", "Sạc pin nhanh" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("findx5pro", "AMOLED", "Quad HD+ (2K+) (1440 x 3216 Pixels)", "6.7' - Tần số quét 120 Hz", "Chưa cập nhật", "Kính cường lực Corning Gorilla Glass Victus", "Chính 50 MP & Phụ 50 MP, 13 MP",
		"Đèn LED kép", "32 MP", "Android 12", "Snapdragon 8 Gen 1 8 nhân", "Adreno 730", "8GB", "Hỗ trợ 5G", "2 Nano SIM hoặc 1 Nano SIM + 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax, Wi-Fi MIMO", "v5.2", "Type-C", "NFC, OTG", "5000 mAh", "Li-lon", "80 W", "Sạc không dây, sạc siêu nhanh SuperVOOC" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("reno7z", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.43' - Tần số quét 60 Hz", "600 nits", "Kính cường lực Schott Xensation UP", "Chính 64 MP & Phụ 2 MP, 2 MP",
		"Có", "16 MP", "Android 11", "Snapdragon 695 5G 8 nhân", "Adreno 619", "8GB", "Hỗ trợ 5G", "2 Nano SIM (SIM 2 chung khe thẻ nhớ)",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.1", "Type-C", "NFC", "4500 mAh", "Li-lon", "33 W", "Sạc siêu nhanh SuperVOOC" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("reno7pro", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.5' - Tần số quét 90 Hz", "920 nits", "Kính cường lực Corning Gorilla Glass 5", "Chính 50 MP & Phụ 8 MP, 2 MP",
		"Có", "32 MP", "Android 11", "MediaTek Dimensity 1200 Max 8 nhân", "Mali-G77 MC9", "12GB", "Hỗ trợ 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.2", "Type-C", "NFC", "4500 mAh", "Li-lon", "65 W", "Sạc siêu nhanh SuperVOOC 2.0" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("reno7", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.4' - Tần số quét 90 Hz", "1000 nits", "800", "Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR",
		"Có", "32 MP", "Android 11", "MediaTek Dimensity 900 5G", "Mali-G68 MC4", "8GB", "Hỗ trợ 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.2", "Type-C", "NFC", "4500 mAh", "Li-lon", "65 W", "Sạc siêu nhanh SuperVOOC" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("pro12.9", "Liquid Retina XDR mini-LED LCD", "2048 x 2732 Pixels", "12.9' - Tần số quét 120 Hz", "Đang cập nhật", "Đang cập nhật", "Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR",
		"Có", "12 MP", "iPadOS 15", "Apple M1 8 nhân", "Apple GPU 8 nhân", "8GB", "Hỗ trợ 5G", "1 Nano SIM hoặc 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "Kết nối Apple Pencil 2 & Magic Keyboard, Nam châm & sạc cho Apple Pencil", "40.88 Wh (~ 10.835 mAh)", "Li-Po", "20 W", "Sạc pin nhanh, tiết kiệm pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("pro12.9wifi", "Liquid Retina XDR mini-LED LCD", "2048 x 2732 Pixels", "12.9' - Tần số quét 120 Hz", "Đang cập nhật", "Đang cập nhật", "Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR",
		"Có", "12 MP", "iPadOS 15", "Apple M1 8 nhân", "Apple GPU 8 nhân", "8GB", "Không hỗ trợ", "Không hỗ trợ",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "Kết nối Apple Pencil 2 & Magic Keyboard, Nam châm & sạc cho Apple Pencil", "40.88 Wh (~ 10.835 mAh)", "Li-Po", "20 W", "Sạc pin nhanh, tiết kiệm pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("pro11", "Liquid Retina", "1668 x 2388 Pixels", "11' - Tần số quét 120 Hz", "Đang cập nhật", "Đang cập nhật", "Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR",
		"Có", "12 MP", "iPadOS 15", "Apple M1 8 nhân", "Apple GPU 8 nhân", "8GB", "Hỗ trợ 5G", "1 Nano SIM hoặc 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "Kết nối Apple Pencil 2 & Magic Keyboard, Nam châm & sạc cho Apple Pencil", "28.65 Wh (~ 7538 mAh)", "Li-Po", "20 W", "Sạc pin nhanh, tiết kiệm pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("pro11wifi", "Liquid Retina", "1668 x 2388 Pixels", "11' - Tần số quét 120 Hz", "Đang cập nhật", "Đang cập nhật", "Chính 12 MP & Phụ 10 MP, TOF 3D LiDAR",
		"Có", "12 MP", "iPadOS 15", "Apple M1 8 nhân", "Apple GPU 8 nhân", "8GB", "Không hỗ trợ", "Không hỗ trợ",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "Kết nối Apple Pencil 2 & Magic Keyboard, Nam châm & sạc cho Apple Pencil", "28.65 Wh (~ 7538 mAh)", "Li-Po", "20 W", "Sạc pin nhanh, tiết kiệm pin" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("air5", "Liquid IPS LCD", "1640 x 2360 Pixels", "10.9' - Tần số quét 60 Hz", "Đang cập nhật", "Đang cập nhật", "12 MP",
		"Có", "12 MP", "iPadOS 15", "Apple M1 8 nhân", "Apple GPU 8 nhân", "8GB", "Hỗ trợ 5G", "1 Nano SIM hoặc 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "Kết nối Apple Pencil 2 & Magic Keyboard, Nam châm & sạc cho Apple Pencil", "28.6 Wh (~ 7587 mAh)", "Li-Po", "20 W", "Sạc pin nhanh, tiết kiệm pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("air5wifi", "Liquid IPS LCD", "1640 x 2360 Pixels", "10.9' - Tần số quét 60 Hz", "Đang cập nhật", "Đang cập nhật", "12 MP",
		"Có", "12 MP", "iPadOS 15", "Apple M1 8 nhân", "Apple GPU 8 nhân", "8GB", "Không hỗ trợ", "Không hỗ trợ",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "Kết nối Apple Pencil 2 & Magic Keyboard, Nam châm & sạc cho Apple Pencil", "28.6 Wh (~ 7587 mAh)", "Li-Po", "20 W", "Sạc pin nhanh, tiết kiệm pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("mini6", "LED-backlit IPS LCD", "1488 x 2266 Pixels", "8.3' - Tần số quét 60 Hz", "Đang cập nhật", "Đang cập nhật", "12 MP",
		"Có", "12 MP", "iPadOS 15", "Apple A15 Bionic 6 nhân", "Apple GPU 5 nhân", "4GB", "Hỗ trợ 5G", "1 Nano SIM hoặc 1 eSIM",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "Kết nối Apple Pencil 2, Nam châm & sạc cho Apple Pencil", "19.3 Wh", "Li-Po", "20 W", "Sạc pin nhanh, tiết kiệm pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("mini6wifi", "LED-backlit IPS LCD", "1488 x 2266 Pixels", "8.3' - Tần số quét 60 Hz", "Đang cập nhật", "Đang cập nhật", "12 MP",
		"Có", "12 MP", "iPadOS 15", "Apple A15 Bionic 6 nhân", "Apple GPU 5 nhân", "4GB", "Không hỗ trợ", "Không hỗ trợ",
        "Wi-Fi 802.11 a/b/g/n/ac", "v5.0", "Type-C", "Kết nối Apple Pencil 2, Nam châm & sạc cho Apple Pencil", "19.3 Wh", "Li-Po", "20 W", "Sạc pin nhanh, tiết kiệm pin" );
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("tabs8ultra", "Super AMOLED", "1848 x 2960 Pixels", "14' - Tần số quét 120 Hz", "Đang cập nhật", "Kính cường lực Corning Gorilla Glass 5", "Chính 13 MP & Phụ 6 MP",
		"Có", "12 MP", "Android 12", "Snapdragon 8 Gen 1 8 nhân", "Adreno 730", "8GB", "Hỗ trợ 5G", "1 Nano SIM",
        "MIMO, Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "Samsung DeX (Giao diện tương tự PC)", "11200 mAh", "Li-Po", "45 W", "Sạc pin nhanh, tiết kiệm pin" );

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("mi12", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.28' - Tần số quét 120 Hz", "1100", "Kính cường lực Corning Gorilla Glass Victus", "Chính 50 MP & Phụ 13 MP, 5 MP",
		"Có", "32 MP", "Android 12", "Snapdragon 8 Gen 1 8 nhân", "Adreno 730", "8GB", "Hỗ trợ 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, Hồng ngoại", "4500 mAh", "Li-lon", "67 W", "Sạc không dây, sạc ngược không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("mi12pro", "AMOLED", "2K+ (1440 x 3200 Pixels)", "6.73' - Tần số quét 120 Hz", "1500", "Kính cường lực Corning Gorilla Glass Victus", "3 camera 50 MP",
		"Có", "32 MP", "Android 12", "Snapdragon 8 Gen 1 8 nhân", "Adreno 730", "12GB", "Hỗ trợ 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC, Hồng ngoại", "4600 mAh", "Li-lon", "120 W", "Sạc không dây, sạc ngược không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("vvv23", "AMOLED", "Full HD+ (1080 x 2400 Pixels)", "6.44' - Tần số quét 90 Hz", "600", "Kính cường lực Corning Gorilla Glass", "Chính 64 MP & Phụ 8 MP, 2 MP",
		"Có", "Chính 50 MP & Phụ 8 MP", "Android 12", "MediaTek Dimensity 920 5G 8 nhân", "Mali-G68 MC4", "8GB", "Hỗ trợ 5G", "2 Nano SIM",
        "Wi-Fi 802.11 a/b/g/n/ac/ax", "v5.2", "Type-C", "NFC", "4200 mAh", "Li-Po", "44 W", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("aw745mm", "OLED", "484 x 396 Pixels", "1.77'", "1000 nits", "Ion-X strengthened glass", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "watchOS 8.0", "Apple S7", "PowerVR", "Đang cập nhật", "Hỗ trợ LTE", "Hỗ trợ eSIM",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS", "303.8 mAh", "Đang cập nhật", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("aw745mmwifi", "OLED", "484 x 396 Pixels", "1.77'", "1000 nits", "Ion-X strengthened glass", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "watchOS 8.0", "Apple S7", "PowerVR", "Đang cập nhật", "Không hỗ trợ", "Không hỗ trợ",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS", "303.8 mAh", "Đang cập nhật", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("aw741mm", "OLED", "484 x 396 Pixels", "1.61'", "1000 nits", "Ion-X strengthened glass", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "watchOS 8.0", "Apple S7", "PowerVR", "Đang cập nhật", "Hỗ trợ LTE", "Hỗ trợ eSIM",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS", "265.9 mAh", "Đang cập nhật", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("aw741mmwifi", "OLED", "484 x 396 Pixels", "1.61'", "1000 nits", "Ion-X strengthened glass", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "watchOS 8.0", "Apple S7", "PowerVR", "Đang cập nhật", "Không hỗ trợ", "Không hỗ trợ",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS", "265.9 mAh", "Đang cập nhật", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("swactive244mm", "SUPER AMOLED", "360 x 360 Pixels", "1.4'", "Đang cập nhật", "Kính cường lực Gorrilla Glass Dx+", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "Tizen OS 5.5", "Exynos 9110 (10 nm)", "Mali-T720", "1.5GB RAM", "Hỗ trợ LTE", "Hỗ trợ eSIM",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS, NFC", "340 mAh", "Li-Ion", "Đang cập nhật", "Sạc không dây");

insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("sw4cl46mm", "SUPER AMOLED", "450 x 450 Pixels", "1.36'", "Đang cập nhật", "Kính cường lực Gorrilla Glass Dx+", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "Android Wear OS, One UI Watch 3", "Exynos W920 (5 nm)", "Mali-G68", "1.5GB RAM", "Hỗ trợ LTE", "Hỗ trợ eSIM",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS, NFC", "340 mAh", "Li-Ion", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("sw4cl42mm", "SUPER AMOLED", "396 x 396 Pixels", "1.19'", "Đang cập nhật", "Kính cường lực Gorrilla Glass Dx+", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "Android Wear OS, One UI Watch 3", "Exynos W920 (5 nm)", "Mali-G68", "1.5GB RAM", "Hỗ trợ LTE", "Hỗ trợ eSIM",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS, NFC", "247 mAh", "Li-Ion", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("sw4cl46mmwifi", "SUPER AMOLED", "450 x 450 Pixels", "1.36'", "Đang cập nhật", "Kính cường lực Gorrilla Glass Dx+", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "Android Wear OS, One UI Watch 3", "Exynos W920 (5 nm)", "Mali-G68", "1.5GB RAM", "Không hỗ trợ", "Không hỗ trợ",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS, NFC", "340 mAh", "Li-Ion", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("sw4cl42mmwifi", "SUPER AMOLED", "396 x 396 Pixels", "1.19'", "Đang cập nhật", "Kính cường lực Gorrilla Glass Dx+", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "Android Wear OS, One UI Watch 3", "Exynos W920 (5 nm)", "Mali-G68", "1.5GB RAM", "Không hỗ trợ", "Không hỗ trợ",
        "Có hỗ trợ", "v5.0", "Đế sạc nam châm", "GPS, NFC", "247 mAh", "Li-Ion", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("ow46mm", "AMOLED", "402 x 476 Pixels", "1.91'", "Đang cập nhật", "Kính cường lực", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "Android Wear OS", "Qualcomm Snapdragon 3100", "Đang cập nhật", "Đang cập nhật", "Không hỗ trợ", "Không hỗ trợ",
        "Có hỗ trợ", "v4.2", "Đế sạc nam châm", "GPS", "430 mAh", "Li-Ion", "Đang cập nhật", "Sạc không dây");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("owfree", "AMOLED", "280 x 456 Pixels", "1.64'", "Đang cập nhật", "Kính 2.5D", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "Hãng không công bố", "Apollo 3.5", "Đang cập nhật", "Đang cập nhật", "Không hỗ trợ", "Không hỗ trợ",
        "Không hỗ trợ", "v5.0", "Đế sạc nam châm", "Đang cập nhật", "230 mAh", "Li-Ion", "Đang cập nhật", "Đang cập nhật");
        
insert into thong_tin(id_tt, cn_man, do_phan_giai, kich_thuoc, do_sang, mat_kinh, camera_sau, den_flash, camera_truoc, he_dieu_hanh, CPU, GPU, ram,
	mang_di_dong, sim, wifi, bluetooth, cong_sac, ket_noi_khac, dung_luong_pin, loai_pin, toc_do_sac, cong_nghe_pin)  
    value ("owband", "AMOLED", "126 x 294 Pixels", "1.1'", "Đang cập nhật", "Kính 2.5D", "Không hỗ trợ",
		"Không hỗ trợ", "Không hỗ trợ", "Hãng không công bố", "Hãng không công bố", "Đang cập nhật", "Đang cập nhật", "Không hỗ trợ", "Không hỗ trợ",
        "Không hỗ trợ", "v5.0", "Đế sạc nam châm", "Đang cập nhật", "100 mAh", "Li-Ion", "Đang cập nhật", "Đang cập nhật");
-- insert san pham

insert into san_pham value ("13promax", "Iphone 13 Pro Max","iphone","iphone13promax","Màn hình ProMotion, chip A15 Bionic mạnh mẽ. Lên Pro thôi.");
insert into san_pham value ("se2022", "Iphone SE (2022)","iphone","iphonese2022","Thiết kế nhỏ gọn, chip A15 Bionic mạnh mẽ. Giá rẻ bất ngờ.");
insert into san_pham value ("13", "Iphone 13","iphone","iphone13","Thiết kế cân đối, chip A15 Bionic mạnh mẽ. Giá rẻ bất ngờ.");
insert into san_pham value ("13mini", "Iphone 13 Mini","iphone","iphone13mini","Thiết kế nhỏ gọn, chip A15 Bionic mạnh mẽ. Giá rẻ bất ngờ.");
insert into san_pham value ("12", "Iphone 12","iphone","iphone12","Thiết kế cân đối, chip A14 Bionic mạnh mẽ. Giá rẻ bất ngờ.");
insert into san_pham value ("13pro", "Iphone 13 Pro","iphone","iphone13pro","Màn hình ProMotion, chip A15 Bionic mạnh mẽ. Lên Pro thôi.");
insert into san_pham value ("11", "Iphone 11","iphone","iphone11","Thiết kế cân đối, chip A13 Bionic mạnh mẽ. Giá rẻ bất ngờ.");
insert into san_pham value ("xr", "Iphone XR","iphone","iphonexr","Thiết kế cân đối, chip A12 Bionic mạnh mẽ. Giá rẻ bất ngờ.");

insert into san_pham value ("zfold3", "Samsung Galaxy Z Fold 3","ss","zfold3","Màn hình gập hiện đại, hỗ trợ kháng nước, camera ẩn dưới màn hình.");
insert into san_pham value ("zflip3", "Samsung Galaxy Z Flip 3","ss","zflip3","Màn hình gập hiện đại, hỗ trợ kháng nước, thiết kế siêu nhỏ gọn.");
insert into san_pham value ("s22ultra", "Samsung Galaxy S22 Ultra","ss","s22ultra","Thiết kế dòng Note quen thuộc, hỗ trợ bút spen kèm theo máy, Camere Zoom 100x.");
insert into san_pham value ("s22+", "Samsung Galaxy S22 Plus","ss","s22+","Diện mạo trẻ trung và năng động, thời lượng sử dụng lâu dài.");
insert into san_pham value ("s22", "Samsung Galaxy S22","ss","s22","Diện mạo trẻ trung và năng động, thời lượng sử dụng lâu dài.");
insert into san_pham value ("s21fe", "Samsung Galaxy S21 FE","ss","s21fe","Diện mạo trẻ trung và năng động, thời lượng sử dụng lâu dài.");
insert into san_pham value ("m53", "Samsung Galaxy M53","ss","m53","Diện mạo trẻ trung và năng động, thời lượng sử dụng lâu dài.");
insert into san_pham value ("a73", "Samsung Galaxy A73","ss","a73","Diện mạo trẻ trung và năng động, thời lượng sử dụng lâu dài.");
insert into san_pham value ("a53", "Samsung Galaxy A53","ss","a53","Diện mạo trẻ trung và năng động, thời lượng sử dụng lâu dài.");
insert into san_pham value ("a33", "Samsung Galaxy A33","ss","a33","Diện mạo trẻ trung và năng động, thời lượng sử dụng lâu dài.");

insert into san_pham value ("findx5pro", "OPPO Find X5 Pro","opo","findx5pro","Màn hình chất lượng cao, camera đỉnh cao, pin lớn, sạc SuperVOOC siêu nhanh.");
insert into san_pham value ("reno7z", "OPPO Reno 7Z","opo","reno7z","Camera đỉnh cao, pin lớn, sạc SuperVOOC siêu nhanh.");
insert into san_pham value ("reno7pro", "OPPO Reno 7 Pro","opo","reno7pro","Camera đỉnh cao, pin lớn, sạc SuperVOOC 2.0 siêu nhanh.");
insert into san_pham value ("reno7", "OPPO Reno 7","opo","reno7","Camera đỉnh cao, pin lớn, sạc SuperVOOC siêu nhanh.");

insert into san_pham value ("pro12.9", "iPad Pro M1 12.9 inch Celluler","ipad","pro12.9","Chip Apple M1 vượt trội, kết nối với Apple Pen 2 và Magic Keyboard, màn hình 12.9 inch, hệ thống loa nổi.");
insert into san_pham value ("pro12.9wifi", "iPad Pro M1 12.9 inch Wifi","ipad","pro12.9wifi","Chip Apple M1 vượt trội, kết nối với Apple Pen 2 và Magic Keyboard, màn hình 12.9 inch, hệ thống loa nổi.");

insert into san_pham value ("pro11", "iPad Pro M1 11 inch Celluler","ipad","pro11","Chip Apple M1 vượt trội, kết nối với Apple Pen 2 và Magic Keyboard, màn hình 11 inch, hệ thống loa nổi.");
insert into san_pham value ("pro11wifi", "iPad Pro M1 11 inch Wifi","ipad","pro11wifi","Chip Apple M1 vượt trội, kết nối với Apple Pen 2 và Magic Keyboard, màn hình 11 inch, hệ thống loa nổi.");

insert into san_pham value ("air5", "iPad Air 5 M1 Celluler","ipad","air5","Chip Apple M1 vượt trội, kết nối với Apple Pen 2 và Magic Keyboard.");
insert into san_pham value ("air5wifi", "iPad Air 5 M1 Wifi","ipad","air5wifi","Chip Apple M1 vượt trội, kết nối với Apple Pen 2 và Magic Keyboard.");

insert into san_pham value ("mini6", "iPad Mini 6 Celluler","ipad","air5","Chip Apple M1 vượt trội, kết nối với Apple Pen 2 và Magic Keyboard.");
insert into san_pham value ("mini6wifi", "iPad Mini 6 Wifi","ipad","air5wifi","Chip Apple M1 vượt trội, kết nối với Apple Pen 2.");

insert into san_pham value ("tabs8ultra", "Samsung Galaxy Tab S8 Ultra","sstab","tabs8ultra","Màn hình lớn, đa nhiệm đa tác vụ, bút S Pen được nâng cấp toàn diện hơn.");

insert into san_pham value ("mi12", "Xiaomi Mi 12","mi","mi12","Thiết kế nhỏ gọn, tràn viền hiện đại, cấu hình mạnh mẽ với chip Snapdragon 8 Gen 1 8 nhân.");
insert into san_pham value ("mi12pro", "Xiaomi Mi 12 Pro","mi","mi12","Thiết kế tràn viền hiện đại, chụp ảnh sắc nét với 3 camera 50 MP, cấu hình mạnh mẽ với chip Snapdragon 8 Gen 1 8 nhân.");

insert into san_pham value ("vvv23", "Vivo V23","vv","vvv23","Thiết kế sang xịn, Selfie Phone chất lượng hàng đầu trong phân khúc.");

insert into san_pham value ("aw745mm", "Apple Watch Series 7 Celluler 45mm Viền Thép","applewatch","aw745mm","Kiểu dáng hiện đại & thời thượng, màn OLED độ sáng cao và sắc nét, hỗ trợ eSIM.");
insert into san_pham value ("aw745mmwifi", "Apple Watch Series 7 45mm Viền Nhôm","applewatch","aw745mmwifi","Kiểu dáng hiện đại & thời thượng, màn OLED độ sáng cao và sắc nét.");
insert into san_pham value ("aw741mm", "Apple Watch Series 7 Celluler 41mm Viền Thép","applewatch","aw741mm","Kiểu dáng hiện đại & thời thượng, màn OLED độ sáng cao và sắc nét, hỗ trợ eSIM.");
insert into san_pham value ("aw741mmwifi", "Apple Watch Series 7 41mm Viền Nhôm","applewatch","aw741mmwifi","Kiểu dáng hiện đại & thời thượng, màn OLED độ sáng cao và sắc nét.");

insert into san_pham value ("aw741mmnike", "Apple Watch Series Nike 7 Celluler 41mm","applewatch","aw741mm","Kiểu dáng hiện đại & thời thượng, màn OLED độ sáng cao và sắc nét, hỗ trợ eSIM.");
insert into san_pham value ("aw741mmwifinike", "Apple Watch Series Nike 7 41mm","applewatch","aw741mmwifi","Kiểu dáng hiện đại & thời thượng, màn OLED độ sáng cao và sắc nét.");

insert into san_pham value ("swactive244mm", "Samsung Watch Active 2 44mm","glxwatch","swactive244mm","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");

insert into san_pham value ("sw4cl46mm", "Samsung Watch 4 LTE Classic 46mm ","glxwatch","sw4cl46mm","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");
insert into san_pham value ("sw4cl46mmwifi", "Samsung Watch 4 Classic 46mm ","glxwatch","sw4cl46mmwifi","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");

insert into san_pham value ("sw444mm", "Samsung Watch 4 LTE 44mm ","glxwatch","sw4cl46mm","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");
insert into san_pham value ("sw444mmwifi", "Samsung Watch 4 44mm ","glxwatch","sw4cl46mmwifi","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");

insert into san_pham value ("sw4cl42mm", "Samsung Watch 4 LTE Classic 42mm ","glxwatch","sw4cl42mm","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");
insert into san_pham value ("sw4cl42mmwifi", "Samsung Watch 4 Classic 42mm ","glxwatch","sw4cl42mmwifi","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");

insert into san_pham value ("sw440mm", "Samsung Watch 4 LTE 40mm ","glxwatch","sw4cl42mm","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");
insert into san_pham value ("sw440mmwifi", "Samsung Watch 4 40mm ","glxwatch","sw4cl42mmwifi","Nhiều tính năng chăm sóc sức khỏe, nhận cuộc gọi trực tiếp.");

insert into san_pham value ("ow46mm", "Oppo Watch 46mm ","oppowatch","ow46mm","Thiết kế sang trọng tinh tế, mặt đồng hồ phong phú tha hồ lựa chọn.");
insert into san_pham value ("owfree", "Oppo Watch Free ","oppowatch","owfree","Thiết kế sang trọng tinh tế, mặt đồng hồ phong phú tha hồ lựa chọn.");
insert into san_pham value ("owband", "Oppo Band ","oppowatch","owband","Thiết kế sang trọng tinh tế, mặt đồng hồ phong phú tha hồ lựa chọn.");

insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("airpod3", "AirPods 3", "airpod","Tính năng âm thanh không gian với tính năng theo dõi chuyển động, chống mồ hôi, chống nước.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("airpodpro", "AirPods Pro", "airpod","Chủ động khử tiếng ồn với chế độ xuyên âm, chống mồ hôi, chống nước.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("airpodmax", "AirPods Max", "airpod","Chủ động khử tiếng ồn với chế độ xuyên âm, chế độ âm thanh không gian với tính năng theo dõi chuyển động.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("earpod", "EarPods", "airpod","Thiết kế theo hình dạng của tai, tối đa hóa đầu ra âm thanh và giảm thiểu việc mất âm thanh");

insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("ia500", "Tai nghe nhét tai Có Dây Samsung IA500", "ssbud","Thiết kế có dây truyền thống, đệm tai êm ái, trải nghiệm nghe phong phú, chất âm rõ nét với hệ thống loa 2 chiều.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("eg920", "Tai nghe Có Dây Samsung EG920", "ssbud","Chủ động khử tiếng ồn với chế độ xuyên âm, chống mồ hôi, chống nước.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("ig935", "Tai nghe Có Dây Samsung IG935", "ssbud","Chủ động khử tiếng ồn với chế độ xuyên âm, chế độ âm thanh không gian với tính năng theo dõi chuyển động.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("budspro", "Tai nghe Bluetooth True Wireless Galaxy Buds Pro", "ssbud","Thiết kế sang trọng, thời thượng cùng hộp sạc đồng nhất màu sắc đi kèm, nghe rõ bất kỳ đâu cùng công nghệ chống ồn chủ động (ANC).");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("budslive", "Tai nghe Bluetooth True Wireless Galaxy Buds Live", "ssbud","Ngoại hình hoàn toàn mới, độc đáo riêng biệt, nghe rõ bất kỳ đâu cùng công nghệ chống ồn chủ động (ANC).");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("buds2", "Tai nghe Bluetooth True Wireless Galaxy Buds 2", "ssbud","Thiết kế sang trọng, thời thượng cùng hộp sạc đồng nhất màu sắc đi kèm, nghe rõ bất kỳ đâu cùng công nghệ chống ồn chủ động (ANC).");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("bn920c", "Tai nghe Bluetooth Samsung Level U Pro BN920C", "ssbud","Thiết kế sang trọng, hai đầu tai nghe hít nam châm, công nghệ lọc tiếng ồn thông minh.");

insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("encoair2", "Tai nghe Bluetooth True Wireless OPPO ENCO Air 2 ETE11", "oppobud","Thiết kế sang trọng, công nghệ lọc tiếng ồn thông minh.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("encobuds", "Tai nghe Bluetooth True Wireless OPPO ENCO Buds ETI81", "oppobud","Thiết kế sang trọng, công nghệ lọc tiếng ồn thông minh.");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("mh135-3", "Tai nghe Có Dây EP Type C OPPO MH135-3", "oppobud","Tai nghe có dây thiết kế sành điệu, dây dài 1.2 m");
insert into san_pham(id_sp, ten_sp,id_loai, mo_ta) value ("mh151", "Tai nghe Có Dây EP OPPO MH151", "oppobud","Tai nghe có dây thiết kế sành điệu, dây dài 1.2 m.");
-- insert chi tiet san pham
insert into chi_tiet_sp value ("1", "128GB",29190000,"13promax");
insert into chi_tiet_sp value ("2", "256GB",32890000,"13promax");
insert into chi_tiet_sp value ("3", "512GB",39290000,"13promax");
insert into chi_tiet_sp value ("4", "1TB",45790000,"13promax");

insert into chi_tiet_sp value ("5", "64GB",12990000,"se2022");
insert into chi_tiet_sp value ("6", "128GB",13990000,"se2022");
insert into chi_tiet_sp value ("7", "256GB",17000000,"se2022");

insert into chi_tiet_sp value ("8", "256GB",36990000,"zfold3");
insert into chi_tiet_sp value ("9", "512GB",39990000,"zfold3");

insert into chi_tiet_sp value ("10","0", 4590000,"airpod3");
insert into chi_tiet_sp value ("11","0", 4990000,"airpodpro");
insert into chi_tiet_sp value ("12","0", 12490000,"airpodmax");
insert into chi_tiet_sp value ("13","0", 549000,"earpod");

insert into chi_tiet_sp value ("14", "128GB",21290000,"13");
insert into chi_tiet_sp value ("15", "256GB",23690000,"13");
insert into chi_tiet_sp value ("16", "512GB",30290000,"13");

insert into chi_tiet_sp value ("17", "64GB",17790000,"12");
insert into chi_tiet_sp value ("18", "128GB",18890000,"12");
insert into chi_tiet_sp value ("19", "256GB",21590000,"12");

insert into chi_tiet_sp value ("20", "128GB",27490000,"13pro");
insert into chi_tiet_sp value ("21", "256GB",30290000,"13pro");
insert into chi_tiet_sp value ("22", "512GB",36790000,"13pro");
insert into chi_tiet_sp value ("23", "1TB",44690000,"13pro");

insert into chi_tiet_sp value ("25", "128GB",18490000,"13mini");
insert into chi_tiet_sp value ("26", "256GB",21990000,"13mini");
insert into chi_tiet_sp value ("27", "512GB",25490000,"13mini");

insert into chi_tiet_sp value ("28", "64GB",12090000,"11");
insert into chi_tiet_sp value ("29", "128GB",14490000,"11");
insert into chi_tiet_sp value ("30", "256GB",18990000,"11");

insert into chi_tiet_sp value ("31", "8/128GB",30990000,"s22ultra");
insert into chi_tiet_sp value ("32", "12/256GB",33990000,"s22ultra");
insert into chi_tiet_sp value ("33", "12/512GB",36990000,"s22ultra");

insert into chi_tiet_sp value ("34", "128GB",19990000,"zflip3");
insert into chi_tiet_sp value ("35", "256GB",20990000,"zflip3");

insert into chi_tiet_sp value ("36", "128GB",25990000,"s22+");
insert into chi_tiet_sp value ("37", "256GB",27990000,"s22+");

insert into chi_tiet_sp value ("38", "128GB",21990000,"s22");
insert into chi_tiet_sp value ("39", "256GB",23490000,"s22");

insert into chi_tiet_sp value ("40", "6/128GB",12490000,"s21fe");
insert into chi_tiet_sp value ("41", "8/128GB",13490000,"s21fe");
insert into chi_tiet_sp value ("42", "8/256GB",15490000,"s21fe");

insert into chi_tiet_sp value ("43", "256GB",12290000,"m53");
insert into chi_tiet_sp value ("44", "128GB",11990000,"a73");
insert into chi_tiet_sp value ("45", "128GB",9690000,"m53");
insert into chi_tiet_sp value ("46", "128GB",8190000,"a33");

insert into chi_tiet_sp value ("47", "256GB",30990000,"findx5pro");
insert into chi_tiet_sp value ("48", "128GB",10490000,"reno7z");
insert into chi_tiet_sp value ("49", "256GB",18990000,"reno7pro");
insert into chi_tiet_sp value ("50", "256GB",12990000,"reno7");

insert into chi_tiet_sp value ("51", "128GB",29290000,"pro12.9");
insert into chi_tiet_sp value ("52", "256GB",33390000,"pro12.9");
insert into chi_tiet_sp value ("53", "512GB",40190000,"pro12.9");
insert into chi_tiet_sp value ("54", "1TB",53990000,"pro12.9");
insert into chi_tiet_sp value ("55", "2TB",63990000,"pro12.9");

insert into chi_tiet_sp value ("56", "128GB",25490000,"pro12.9wifi");
insert into chi_tiet_sp value ("57", "256GB",27990000,"pro12.9wifi");
insert into chi_tiet_sp value ("58", "512GB",32690000,"pro12.9wifi");
insert into chi_tiet_sp value ("59", "1TB",49990000,"pro12.9wifi");
insert into chi_tiet_sp value ("60", "2TB",59990000,"pro12.9wifi");

insert into chi_tiet_sp value ("61", "128GB",24490000,"pro11");
insert into chi_tiet_sp value ("62", "256GB",29990000,"pro11");
insert into chi_tiet_sp value ("63", "512GB",35990000,"pro11");
insert into chi_tiet_sp value ("64", "1TB",49990000,"pro11");
insert into chi_tiet_sp value ("65", "2TB",55990000,"pro11");

insert into chi_tiet_sp value ("66", "128GB",19990000,"pro11wifi");
insert into chi_tiet_sp value ("67", "256GB",25990000,"pro11wifi");
insert into chi_tiet_sp value ("68", "512GB",31990000,"pro11wifi");
insert into chi_tiet_sp value ("69", "1TB",42990000,"pro11wifi");
insert into chi_tiet_sp value ("70", "2TB",51990000,"pro11wifi");

insert into chi_tiet_sp value ("71", "64GB",19490000,"air5");
insert into chi_tiet_sp value ("72", "256GB",24990000,"air5");

insert into chi_tiet_sp value ("73", "64GB",14590000,"air5wifi");
insert into chi_tiet_sp value ("74", "256GB",17990000,"air5wifi");

insert into chi_tiet_sp value ("75", "64GB",17190000,"mini6");
insert into chi_tiet_sp value ("76", "256GB",23990000,"mini6");

insert into chi_tiet_sp value ("77", "64GB",14990000,"mini6wifi");
insert into chi_tiet_sp value ("78", "256GB",19990000,"mini6wifi");

insert into chi_tiet_sp value ("79", "128GB",28490000,"tabs8ultra");

insert into chi_tiet_sp value ("80","0", 300000,"ia500");
insert into chi_tiet_sp value ("81","0", 280000,"eg920");
insert into chi_tiet_sp value ("82","0", 300000,"ig935");
insert into chi_tiet_sp value ("83","0", 2490000,"budspro");
insert into chi_tiet_sp value ("84","0", 1990000,"budslive");
insert into chi_tiet_sp value ("85","0", 2990000,"buds2");
insert into chi_tiet_sp value ("86","0", 1450000,"bn920c");

insert into chi_tiet_sp value ("87", "256GB",27990000,"mi12pro");
insert into chi_tiet_sp value ("88", "256GB",19990000,"mi12");

insert into chi_tiet_sp value ("89", "120GB",12990000,"vvv23");

insert into chi_tiet_sp value ("90", "32GB",21990000,"aw745mm");
insert into chi_tiet_sp value ("91", "32GB",11990000,"aw745mmwifi");
insert into chi_tiet_sp value ("92", "32GB",19590000,"aw741mm");
insert into chi_tiet_sp value ("93", "32GB",10590000,"aw741mmwifi");

insert into chi_tiet_sp value ("94", "32GB",13990000,"aw741mmnike");
insert into chi_tiet_sp value ("95", "32GB",10990000,"aw741mmwifinike");

insert into chi_tiet_sp value ("96", "4GB",9990000,"swactive244mm");

insert into chi_tiet_sp value ("97", "16GB",8991000,"sw4cl46mm");
insert into chi_tiet_sp value ("98", "16GB",8091000,"sw4cl46mmwifi");

insert into chi_tiet_sp value ("99", "16GB",8541000,"sw4cl42mm");
insert into chi_tiet_sp value ("100", "16GB",7641000,"sw4cl42mmwifi");

insert into chi_tiet_sp value ("101", "16GB",7191000,"sw444mm");
insert into chi_tiet_sp value ("102", "16GB",6291000,"sw444mmwifi");

insert into chi_tiet_sp value ("103", "16GB",6741000,"sw440mm");
insert into chi_tiet_sp value ("104", "16GB",5841000,"sw440mmwifi");

insert into chi_tiet_sp value ("105", "128GB",13490000,"xr");

insert into chi_tiet_sp value ("106", "8GB",5193000,"ow46mm");
insert into chi_tiet_sp value ("107", "128MB",1790000,"owfree");
insert into chi_tiet_sp value ("108", "16MB",790000,"owband");

insert into chi_tiet_sp value ("109","0", 1431000,"encoair2");
insert into chi_tiet_sp value ("110","0", 790000,"encobuds");
insert into chi_tiet_sp value ("111","0", 590000,"mh151");
insert into chi_tiet_sp value ("112","0", 260000,"mh135-3");
-- insert mau sac

insert into mau_sac value ("1","Vàng Đồng","iphone-13-pro-max-gold-650x650.png","13promax");
insert into mau_sac value ("2","Bạc","iphone-13-pro-max-silver-650x650.png","13promax");
insert into mau_sac value ("3","Xanh Dương","iphone-13-pro-max-blue-2-650x650.png","13promax");
insert into mau_sac value ("4","Xám","iphone-13-pro-max-grey-650x650.png","13promax");
insert into mau_sac value ("5","Xanh Lá","iphone-13-pro-max-green-650x650.png","13promax");

insert into mau_sac value ("6","Đen","iphone-se-black-650x650.png","se2022");
insert into mau_sac value ("7","Đỏ","iphone-se-red-650x650.png","se2022");
insert into mau_sac value ("8","Trắng","iphone-se-white-650x650.png","se2022");

insert into mau_sac value ("9","Xanh Rêu","samsung-galaxy-z-fold-3-green.jpg","zfold3");
insert into mau_sac value ("10","Đen","samsung-galaxy-z-fold-3-black.jpg","zfold3");
insert into mau_sac value ("11","Bạc","samsung-galaxy-z-fold-3-silver.jpg","zfold3");

insert into mau_sac value ("12","Đỏ","iphone-13-red-650x650.png","13");
insert into mau_sac value ("13","Hồng","iphone-13-pink-650x650.png","13");
insert into mau_sac value ("14","Xanh Dương","iphone-13-blue-650x650.png","13");
insert into mau_sac value ("15","Đen","iphone-13-black-650x650.png","13");
insert into mau_sac value ("16","Trắng","iphone-13-white-650x650.png","13");
insert into mau_sac value ("17","Xanh Lá","iphone-13-green-650x650.png","13");

insert into mau_sac value ("18","Đỏ","iphone-12-red-1-650x650.png","12");
insert into mau_sac value ("19","Tím","iphone-12-purple-1-650x650.png","12");
insert into mau_sac value ("20","Xanh Dương","iphone-12-blue-1-650x650.png","12");
insert into mau_sac value ("21","Đen","iphone-12-black-1-650x650.png","12");
insert into mau_sac value ("22","Trắng","iphone-12-white-1-650x650.png","12");
insert into mau_sac value ("23","Xanh Lá","iphone-12-green-1-1-650x650.png","12");

insert into mau_sac value ("24","Trắng","airpods-3-thumb-650x650.png","airpod3");
insert into mau_sac value ("25","Trắng","airpods-pro-thumb-650x650.png","airpodpro");
insert into mau_sac value ("26","Trắng","airpods-max-select-bac-thumb-650x650.png","airpodmax");
insert into mau_sac value ("27","Trắng","earpod-lightning-trang-thumb-1-650x650.png","earpod");

insert into mau_sac value ("28","Vàng Đồng","iphone-13-pro-gold-650x650.png","13pro");
insert into mau_sac value ("29","Bạc","iphone-13-pro-silver-650x650.png","13pro");
insert into mau_sac value ("30","Xanh Dương","iphone-13-pro-blue-650x650.png","13pro");
insert into mau_sac value ("31","Xám","iphone-13-pro-grey-650x650.png","13pro");
insert into mau_sac value ("32","Xanh Lá","iphone-13-pro-thumbtz-650x650.png","13pro");

insert into mau_sac value ("33","Đỏ","iphone-13-mini-red-650x650.png","13mini");
insert into mau_sac value ("34","Hồng","iphone-13-mini-pink-650x650.png","13mini");
insert into mau_sac value ("35","Xanh Dương","iphone-13-mini-blue-650x650.png","13mini");
insert into mau_sac value ("36","Đen","iphone-13-mini-black-650x650.png","13mini");
insert into mau_sac value ("37","Trắng","iphone-13-mini-white-650x650.png","13mini");
insert into mau_sac value ("38","Xanh Lá","iphone-13-mini-green-thumbtz-650x650.png","13mini");

insert into mau_sac value ("39","Đỏ","iphone-11-red-1-650x650.png","11");
insert into mau_sac value ("40","Vàng","iphone-11-yellow-1-650x650.png","11");
insert into mau_sac value ("41","Tím","iphone-11-purple-1-650x650.png","11");
insert into mau_sac value ("42","Đen","iphone-11-black-1-650x650.png","11");
insert into mau_sac value ("43","Trắng","iphone-11-white-1-650x650.png","11");
insert into mau_sac value ("44","Xanh Lá","iphone-11-green-1-650x650.png","11");

insert into mau_sac value ("45","Đỏ","samsung-galaxy-s22-ultra-1-1.jpg","s22ultra");
insert into mau_sac value ("46","Trắng","galaxy-s22-ultra-white-8.jpg","s22ultra");
insert into mau_sac value ("47","Đen","galaxy-s22-ultra-black-8.jpg","s22ultra");
insert into mau_sac value ("48","Xanh Lá","samsung-galaxy-s22-ultra-1.jpg","s22ultra");

insert into mau_sac value ("49","Tím","samsung-galaxy-z-flip-3-1-1.jpg","zflip3");
insert into mau_sac value ("50","Kem","samsung-galaxy-z-flip-3-kem-1-org.jpg","zflip3");
insert into mau_sac value ("51","Xanh Rêu","samsung-galaxy-z-flip-3-1-2.jpg","zflip3");
insert into mau_sac value ("52","Đen","samsung-galaxy-z-flip-3-1.jpg","zflip3");

insert into mau_sac value ("53","Hồng","samsung-galaxy-s22-plus-256gb-1.jpg","s22+");
insert into mau_sac value ("54","Đen","samsung-galaxy-s22-plus-den-1.jpg","s22+");
insert into mau_sac value ("55","Trắng","samsung-galaxy-s22-plus-trang-1.jpg","s22+");
insert into mau_sac value ("56","Xanh Lá","samsung-galaxy-s22-plus-xanh-1.jpg","s22+");

insert into mau_sac value ("57","Hồng","samsung-galaxy-s22-pink.jpg","s22");
insert into mau_sac value ("58","Đen","samsung-galaxy-s22-256gb-1.jpg","s22");
insert into mau_sac value ("59","Trắng","samsung-galaxy-s22-white.jpg","s22");
insert into mau_sac value ("60","Xanh Lá","samsung-galaxy-s22-green.jpg","s22");

insert into mau_sac value ("61","Tím","samsung-galaxy-s21-fe-1-1.jpg","s21fe");
insert into mau_sac value ("62","Xanh Lá","samsung-galaxy-s21-fe-xanh-1.jpg","s21fe");
insert into mau_sac value ("63","Xám","samsung-galaxy-s21-fe-1.jpg","s21fe");
insert into mau_sac value ("64","Trắng","samsung-galaxy-s21-fe-trang-1-1.jpg","s21fe");

insert into mau_sac value ("65","Nâu","samsung-galaxy-m53-nau-1-1.jpg","m53");
insert into mau_sac value ("66","Xanh Dương","samsung-galaxy-m53-xanhduong-1.jpg","m53");
insert into mau_sac value ("67","Xanh Lá","samsung-galaxy-m53-xanhla-1.jpg","m53");

insert into mau_sac value ("68","Xanh Lá","samsung-galaxy-a73-5g-xanh-1.jpg","a73");
insert into mau_sac value ("69","Xám","samsung-galaxy-a73-1-1.jpg","a73");
insert into mau_sac value ("70","Trắng","samsung-galaxy-a73-5g-1.jpg","a73");

insert into mau_sac value ("71","Xanh Dương","samsung-galaxy-a53-1-1.jpg","a53");
insert into mau_sac value ("72","Đen","samsung-galaxy-a53-den-1.jpg","a53");
insert into mau_sac value ("73","Cam","samsung-galaxy-a53-cam-1.jpg","a53");
insert into mau_sac value ("74","Trắng","samsung-galaxy-a53-trang-1.jpg","a53");

insert into mau_sac value ("75","Xanh Dương","samsung-galaxy-a33-5g-xanh-1.jpg","a33");
insert into mau_sac value ("76","Đen","samsung-galaxy-a33-5g-den-1-1.jpg","a33");
insert into mau_sac value ("77","Cam","samsung-galaxy-a33-1.jpg","a33");
insert into mau_sac value ("78","Trắng","samsung-galaxy-a33-1-1.jpg","a33");

insert into mau_sac value ("79","Đen","oppo-find-x5-pro-1-1.jpg","findx5pro");
insert into mau_sac value ("80","Trắng","oppo-find-x5-pro-1-2.jpg","findx5pro");

insert into mau_sac value ("81","Bạc","oppo-reno7-z-1-1.jpg","reno7z");
insert into mau_sac value ("82","Đen","oppo-reno7-z-1-2.jpg","reno7z");

insert into mau_sac value ("83","Xanh Dương Nhạt","oppo-reno7-pro-1-1.jpg","reno7pro");
insert into mau_sac value ("84","Đen","oppo-reno7-pro-1-2.jpg","reno7pro");

insert into mau_sac value ("85","Xanh Dương","oppo-reno7-1-1.jpg","reno7");
insert into mau_sac value ("86","Đen","oppo-reno7-1.jpg","reno7");

insert into mau_sac value ("87","Xám","ipad-pro-m1-129-inch-wifi-cellular-gray-650x650.png","pro12.9");
insert into mau_sac value ("88","Bạc","ipad-pro-m1-129-inch-wifi-cellular-silver-650x650.png","pro12.9");

insert into mau_sac value ("89","Xám","ipad-pro-m1-129-inch-wifi-cellular-gray-650x650.png","pro12.9wifi");
insert into mau_sac value ("90","Bạc","ipad-pro-m1-129-inch-wifi-cellular-silver-650x650.png","pro12.9wifi");


insert into mau_sac value ("91","Bạc","ipad-pro-m1-11-inch-cellular-wifi-silver-650x650.png","pro11");
insert into mau_sac value ("92","Bạc","ipad-pro-m1-11-inch-cellular-wifi-silver-650x650.png","pro11wifi");

insert into mau_sac value ("97","Xám","ipad-pro-m1-11-inch-cellular-wifi-gray-650x650.png","pro11");
insert into mau_sac value ("98","Xám","ipad-pro-m1-11-inch-cellular-wifi-gray-650x650.png","pro11wifi");

insert into mau_sac value ("93","Tím","ipad-air-5-5G-purple-650x650.png","air5");
insert into mau_sac value ("94","Xanh Dương","air-5-m1-wifi-cellular-xanh-thumb-650x650.png","air5");
insert into mau_sac value ("95","Trắng","air-5-m1-wifi-cellular-trang-thumb-650x650.png","air5");
insert into mau_sac value ("96","Xám","ipad-air-5-m1-wifi-cellular-gray-thumb-650x650.png","air5");

insert into mau_sac value ("99","Tím","ipad-air-5-5G-purple-650x650.png","air5wifi");
insert into mau_sac value ("100","Xanh Dương","air-5-m1-wifi-cellular-xanh-thumb-650x650.png","air5wifi");
insert into mau_sac value ("101","Trắng","air-5-m1-wifi-cellular-trang-thumb-650x650.png","air5wifi");
insert into mau_sac value ("102","Xám","ipad-air-5-m1-wifi-cellular-gray-thumb-650x650.png","air5wifi");

insert into mau_sac value ("103","Hồng","ipad-mini-6-5g-pink-650x650.png","mini6");
insert into mau_sac value ("104","Tím","ipa-mini-6-5g-purple-650x650.png","mini6");
insert into mau_sac value ("105","Trắng","ipad-mini-6-5g-startlight-650x650.png","mini6");
insert into mau_sac value ("106","Xám","ipad-mini-6-5g-gray-650x650.png","mini6");

insert into mau_sac value ("107","Hồng","ipad-mini-6-5g-pink-650x650.png","mini6wifi");
insert into mau_sac value ("108","Tím","ipa-mini-6-5g-purple-650x650.png","mini6wifi");
insert into mau_sac value ("109","Trắng","ipad-mini-6-5g-startlight-650x650.png","mini6wifi");
insert into mau_sac value ("110","Xám","ipad-mini-6-5g-gray-650x650.png","mini6wifi");

insert into mau_sac value ("111","Xám","public_images_b08df22d_4b5e_46a8_87c5_fc303e133f8a_1500x1500.jpg","tabs8ultra");

insert into mau_sac value ("112","Đen","nhet-tai-samsung-ia500-den-041221-063201-600x600.jpg","ia500");
insert into mau_sac value ("113","Đỏ","tai-nghe-nhet-tai-samsung-eg920b-avatar-600x600.jpg","eg920");
insert into mau_sac value ("118","Đen","tai-nghe-15.jpg","eg920");
insert into mau_sac value ("114","Đen","tai-nghe-nhet-tai-samsung-ig935b-avatar-1-600x600.jpg","ig935");
insert into mau_sac value ("117","Trắng","tai-nghe-nhet-trong-samsung-ig935b-trang-1-2-org.jpg","ig935");
insert into mau_sac value ("115","Bạc","bluetooth-true-wireless-galaxy-buds-pro-bac-thumb-600x600.jpeg","budspro");
insert into mau_sac value ("116","Đen","tai-nghe-bluetooth-true-wireless-galaxy-buds-pro-ava-1-600x600.jpg","budspro");
insert into mau_sac value ("119","Đồng","ai-nghe-bluetooth-true-wireless-samsung-galaxy-buds-live-r180-gold-thumb-600x600.jpeg","budslive");
insert into mau_sac value ("120","Trắng","samsung-galaxy-buds-2-r177n-trang-thumb-3-600x600.jpeg","buds2");
insert into mau_sac value ("121","Đen","samsung-galaxy-buds-2-r177n-600x600.jpg","buds2");
insert into mau_sac value ("122","Đồng","tai-nghe-bluetooth-samsung-level-u-pro-bn920c-avatar-1-1-600x600.jpg","bn920c");
insert into mau_sac value ("123","Đen","tai-nghe-bluetooth-samsung-level-u-pro-bn920c-den-3-org.jpg","bn920c");

insert into mau_sac value ("124","Xám","xiaomi-12-1.jpg","mi12");
insert into mau_sac value ("125","Xanh Dương","xiaomi-12-1-1.jpg","mi12");
insert into mau_sac value ("126","Tím","xiaomi-mi-12-1.jpg","mi12");

insert into mau_sac value ("127","Tím","xiaomi-12-pro-1-1.jpg","mi12pro");
insert into mau_sac value ("128","Xám","xiaomi-12-pro-1-2.jpg","mi12pro");
insert into mau_sac value ("129","Xanh Dương","xiaomi-12-pro-1-3.jpg","mi12pro");

insert into mau_sac value ("130","Vàng","vivo-v23-5g-vang-1.jpg","vvv23");
insert into mau_sac value ("131","Xanh Đen","vivo-v23-5g-xanh-1.jpg","vvv23");

insert into mau_sac value ("132","Xanh Dương","apple-watch-s7-lte-45mm-xanh-duong-2-650x650.png","aw745mm");
insert into mau_sac value ("133","Tím","apple-watch-s7-lte-45mm-tim-650x650.png","aw745mm");
insert into mau_sac value ("134","Vàng","apple-watch-s7-lte-45mm-vang-nhat-2-650x650.png","aw745mm");

insert into mau_sac value ("135","Xanh Dương","apple-watch-s7-lte-45mm-xanh-duong-2-650x650.png","aw741mm");
insert into mau_sac value ("136","Tím","apple-watch-s7-lte-45mm-tim-650x650.png","aw741mm");
insert into mau_sac value ("137","Vàng","apple-watch-s7-lte-45mm-vang-nhat-2-650x650.png","aw741mm");

insert into mau_sac value ("138","Vàng","apple-watch-s7-gps-45mm-vang-nhat-650x650.png","aw745mmwifi");
insert into mau_sac value ("139","Đen","apple-watch-s7-gps-45mm-den-650x650.png","aw745mmwifi");
insert into mau_sac value ("140","Xanh Lá","apple-watch-s7-gps-45mm-xanh-la-650x650.png","aw745mmwifi");
insert into mau_sac value ("141","Xanh Dương","apple-watch-s7-gps-45mm-xanh-duong-650x650.png","aw745mmwifi");
insert into mau_sac value ("142","Đỏ","apple-watch-s7-gps-45mm-do-650x650.png","aw745mmwifi");

insert into mau_sac value ("143","Vàng","apple-watch-s7-gps-45mm-vang-nhat-650x650.png","aw741mmwifi");
insert into mau_sac value ("144","Đen","apple-watch-s7-gps-45mm-den-650x650.png","aw741mmwifi");
insert into mau_sac value ("145","Xanh Lá","apple-watch-s7-gps-45mm-xanh-la-650x650.png","aw741mmwifi");
insert into mau_sac value ("146","Xanh Dương","apple-watch-s7-gps-45mm-xanh-duong-650x650.png","aw741mmwifi");
insert into mau_sac value ("147","Đỏ","apple-watch-s7-gps-45mm-do-650x650.png","aw741mmwifi");

insert into mau_sac value ("148","Đen","apple-watch-nike-series-7-gps-cellular-41mm-650x650.png","aw741mmnike");
insert into mau_sac value ("149","Trắng","apple-watch-series-7-nike-lte-41mm-650x650.png","aw741mmnike");
insert into mau_sac value ("150","Đen","apple-watch-series-7-gps-41mm-den-650x650.png","aw741mmwifinike");

insert into mau_sac value ("151","Đen","samsung-galaxy-watch-4-lte-classic-42mm-den-thumb-1-600x600.jpg","sw4cl46mm");
insert into mau_sac value ("152","Đen","samsung-galaxy-watch-4-lte-classic-42mm-den-thumb-1-600x600.jpg","sw4cl42mm");

insert into mau_sac value ("153","Đen","samsung-galaxy-watch-4-classic-46mm-den-thumb-1-600x600.jpeg","sw4cl46mmwifi");
insert into mau_sac value ("154","Bạc","samsung-galaxy-watch-4-classic-46mm-bac-thumb-01-1-600x600.jpg","sw4cl46mmwifi");

insert into mau_sac value ("155","Đen","samsung-galaxy-watch-4-classic-42mm-den-thumb-600x600.jpg","sw4cl42mmwifi");
insert into mau_sac value ("156","Trắng","samsung-galaxy-watch-4-classic-42mm-trang-thumb-1-2-3-600x600.jpg","sw4cl42mmwifi");

insert into mau_sac value ("157","Xanh Lá","samsung-galaxy-watch-4-44mm-xanh-thumb-600x600.jpg","sw444mmwifi");
insert into mau_sac value ("158","Đen","samsung-galaxy-watch-4-44mm-den-thumb-600x600.jpg","sw444mmwifi");
insert into mau_sac value ("159","Bạc","samsung-galaxy-watch-4-44mm-thumb-02-600x600.jpg","sw444mmwifi");

insert into mau_sac value ("160","Đen","samsung-galaxy-watch-4-40mm-den-thumb-600x600.jpg","sw440mmwifi");
insert into mau_sac value ("161","Trắng","samsung-galaxy-watch-4-40mm-trang-thumbnew-1-600x600.jpg","sw440mmwifi");
insert into mau_sac value ("162","Vàng Hồng","samsung-galaxy-watch-4-40mm-vang-hong-thumb-1-2-3-4-600x600.jpg","sw440mmwifi");

insert into mau_sac value ("163","Đen","samsung-galaxy-watch-active-2-44-mm-day-da-thumb-1-1-600x600.jpg","swactive244mm");

insert into mau_sac value ("164","Đen","samsung-galaxy-watch-4-lte-44mm-den-thumb-600x600.jpg","sw444mm");
insert into mau_sac value ("165","Đen","samsung-galaxy-watch-4-lte-40mm-thumb-den-1-1-600x600.jpg","sw440mm");

insert into mau_sac value ("166","Trắng","iphone-xr-white-650x650.png","xr");

insert into mau_sac value ("167","Vàng Đồng","oppo-watch-46mm-day-silicone-hong-thumb-1-1-600x600.jpg","ow46mm");
insert into mau_sac value ("168","Đen","oppo-watch-free-den-thumb-mau-600x600.jpg","owfree");
insert into mau_sac value ("169","Vàng","oppo-watch-free-vani-1.jpg","owfree");
insert into mau_sac value ("170","Tím","oppo-band-tim-thumb-600x600.jpg","owband");
insert into mau_sac value ("171","Đen","oppo-band-1-org-1.jpg","owband");

insert into mau_sac value ("172","Xanh Dương","bluetooth-true-wireless-oppo-enco-air-2-ete11-1-600x600.jpg","encoair2");
insert into mau_sac value ("173","Trắng","bluetooth-true-wireless-oppo-enco-air-2-ete11-2.jpg","encoair2");

insert into mau_sac value ("174","Trắng","bluetooth-tws-oppo-enco-buds-eti81-600x600.jpg","encobuds");
insert into mau_sac value ("175","Xanh Dương","bluetooth-tws-oppo-enco-buds-eti81-2-2.jpg","encobuds");

insert into mau_sac value ("176","Đen","co-day-ep-oppo-mh151-10-600x600.jpg","mh151");
insert into mau_sac value ("177","Trắng","co-day-ep-oppo-mh151-bac-1-1-org.jpg","mh151");

insert into mau_sac value ("178","Trắng","co-day-ep-type-c-oppo-mh135-600x600.jpg","mh135-3");