-- ******************************************************
-- Create User Defined Functions
-- ******************************************************
-- Builds an ISO 8601 format date from a year, month, and day specified as integers.
-- This format of date should parse correctly regardless of SET DATEFORMAT and SET LANGUAGE.
-- See SQL Server Books Online for more details.
CREATE FUNCTION [dbo].[udfBuildISO8601Date] (@year int, @month int, @day int)
RETURNS datetime
AS
BEGIN
	RETURN cast(convert(varchar, @year) + '-' + [dbo].[udfTwoDigitZeroFill](@month)
	    + '-' + [dbo].[udfTwoDigitZeroFill](@day) + 'T00:00:00'
	    as datetime);
END;
GO


CREATE FUNCTION [dbo].[udfMinimumDate] (
    @x DATETIME,
    @y DATETIME
) RETURNS DATETIME
AS
BEGIN
    DECLARE @z DATETIME

    IF @x <= @y
        SET @z = @x
    ELSE
        SET @z = @y

    RETURN(@z)
END;
GO

-- Converts the specified integer (which should be < 100 and > -1)
-- into a two character string, zero filling from the left
-- if the number is < 10.
CREATE FUNCTION [dbo].[udfTwoDigitZeroFill] (@number int)
RETURNS char(2)
AS
BEGIN
	DECLARE @result char(2);
	IF @number > 9
		SET @result = convert(char(2), @number);
	ELSE
		SET @result = convert(char(2), '0' + convert(varchar, @number));
	RETURN @result;
END;
GO