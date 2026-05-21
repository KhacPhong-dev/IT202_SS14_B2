update Appointments
set status = 'Completed'
where appointment_id = 104;

-- Phải dùng OLD vì cần kiểm tra lịch khám trước khi update đã Completed hay chưa.
-- NEW là trạng thái mới người dùng muốn cập nhật.

drop trigger if exists PreventStatusRevert;

delimiter //

create trigger PreventStatusRevert
before update
on Appointments
for each row
begin
    if OLD.status = 'Completed' then
        signal sqlstate '45000'
        set message_text = 'Khong duoc phep thay doi lich kham da Completed';
    end if;
end //

delimiter ;