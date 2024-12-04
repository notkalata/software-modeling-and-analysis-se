CREATE TRIGGER TRG_UpdateRoomAvailability
ON BOOKINGS
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE BOOKING_STATUS = 'Completed')
    BEGIN
        UPDATE r
        SET r.AVAILABLE = 'N'
        FROM ROOMS r
        JOIN inserted i ON r.ID = i.ROOM_ID
        WHERE i.BOOKING_STATUS = 'Completed';
    END
END;
GO