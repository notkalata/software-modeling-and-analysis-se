CREATE PROCEDURE UpdateHotelRatings
AS
BEGIN
    DECLARE @HotelID INT;
    DECLARE @NewRating INT;
    DECLARE @ReviewCount INT;
    DECLARE @CurrentHotelRating INT;

    DECLARE hotel_cursor CURSOR FOR
    SELECT ID
    FROM HOTELS;

    OPEN hotel_cursor;
    FETCH NEXT FROM hotel_cursor INTO @HotelID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @ReviewCount = COUNT(*)
        FROM REVIEWS
        WHERE HOTEL_ID = @HotelID;

        IF @ReviewCount > 0
        BEGIN
            DECLARE @TotalRating INT;
            SELECT @TotalRating = SUM(RATING)
            FROM REVIEWS
            WHERE HOTEL_ID = @HotelID;

            SET @NewRating = ROUND(@TotalRating / @ReviewCount, 0);

            UPDATE HOTELS
            SET REVIEW_RATING = @NewRating
            WHERE ID = @HotelID;
        END
        ELSE
        BEGIN
            UPDATE HOTELS
            SET REVIEW_RATING = 0
            WHERE ID = @HotelID;
        END
        FETCH NEXT FROM hotel_cursor INTO @HotelID;
    END;

    CLOSE hotel_cursor;
    DEALLOCATE hotel_cursor;
END;