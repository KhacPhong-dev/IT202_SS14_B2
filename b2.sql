drop procedure if exists TransferBed;

delimiter //

create procedure TransferBed(
    in p_patient_id int,
    in p_new_bed_id int
)
begin

    declare exit handler for sqlexception
    begin
        rollback;
    end;

    start transaction;

    -- Giải phóng giường cũ
    update Beds
    set patient_id = null
    where patient_id = p_patient_id;

    -- Gán giường mới
    update Beds
    set patient_id = p_patient_id
    where bed_id = p_new_bed_id;

    commit;

end //

delimiter ;