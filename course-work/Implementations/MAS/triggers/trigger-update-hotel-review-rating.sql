CREATE TRIGGER TRG_UPDATE_HOTEL_RATING
ON REVIEWS
AFTER INSERT
AS
BEGIN
    DECLARE @HotelID INT;
    DECLARE @NewRating INT;
    DECLARE @ReviewCount INT;

    SELECT @HotelID = HOTEL_ID, @NewRating = RATING
    FROM INSERTED;

    SELECT @ReviewCount = COUNT(*) 
    FROM REVIEWS 
    WHERE HOTEL_ID = @HotelID;

    DECLARE @CurrentHotelRating INT;
    SELECT @CurrentHotelRating = REVIEW_RATING
    FROM HOTELS
    WHERE ID = @HotelID;

    IF @ReviewCount = 1
    BEGIN
        SET @CurrentHotelRating = @NewRating;
    END
    ELSE
    BEGIN
        SET @CurrentHotelRating = ROUND(
            ( @CurrentHotelRating * (@ReviewCount - 1) + @NewRating ) 
            / @ReviewCount, 0);
    END

    UPDATE HOTELS
    SET REVIEW_RATING = @CurrentHotelRating
    WHERE ID = @HotelID;

END;