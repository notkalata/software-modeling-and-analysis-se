CREATE FUNCTION FN_CALCULATE_AMOUNT
(
    @StartDate DATE,
    @EndDate DATE,
    @Amount DECIMAL(18, 2)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @DaysDifference INT;
    DECLARE @Result DECIMAL(18, 2);
    
    SET @DaysDifference = DATEDIFF(DAY, @StartDate, @EndDate);
    
    SET @Result = @DaysDifference * @Amount;
    
    RETURN @Result;
END;
GO