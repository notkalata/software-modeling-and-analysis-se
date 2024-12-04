CREATE PROCEDURE dbo.UpdateBookingStatus
AS
BEGIN
    DECLARE @BookingID TABLE (BOOKING_ID INT);

    UPDATE p
    SET p.STATUS = 'PROCESSED'
    OUTPUT INSERTED.BOOKING_ID INTO @BookingID (BOOKING_ID)
    FROM PAYMENTS p
    WHERE p.STATUS = 'UNPROCESSED';

    UPDATE b
    SET b.BOOKING_STATUS = 'Completed'
    FROM BOOKINGS b
    JOIN @BookingID bi ON b.ID = bi.BOOKING_ID;
    
END;
GO