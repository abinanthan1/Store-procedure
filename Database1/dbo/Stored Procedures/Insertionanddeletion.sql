CREATE PROCEDURE Insertionanddeletion(
    @EmployeId INT,
    @EmployeName VARCHAR(10),
    @EmployeMail VARCHAR(20),
    @EmployeAddress VARCHAR(30),
    @Type VARCHAR(30)
)
AS
BEGIN
    IF @Type = 'insert'
    BEGIN
        BEGIN TRY
            INSERT INTO Record_table (EmployeId, EmployeName, EmployeMail, EmployeAddress)
            VALUES (@EmployeId, @EmployeName, @EmployeMail, @EmployeAddress);

            INSERT INTO Log_table (ErrorMessage, ErrorSeverity, ErrorState,ErrorProcedure,ErrorLine,
	ErrorNumber,ErrorTime)
            VALUES ('Data insertion succeeded for name: ' + @EmployeName, 0, 0,'',0,0, GETDATE());
        END TRY
        BEGIN CATCH
            DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
            DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
            DECLARE @ErrorState INT = ERROR_STATE();
			DECLARE @ErrorProcedure NVARCHAR(128)=Error_Procedure();
	    	DECLARE	@ErrorLine INT=Error_Line()
	        DECLARE @ErrorNumber INT=Error_Number()

            INSERT INTO Log_table (ErrorMessage, ErrorSeverity, ErrorState, ErrorProcedure,ErrorLine,ErrorNumber,ErrorTime)
            VALUES ('Data insertion failed for name: ' + @EmployeName + '. Error: ' + @ErrorMessage, @ErrorSeverity, @ErrorState,@ErrorProcedure,@ErrorLine,@ErrorNumber,GETDATE());
        END CATCH;
    END;

    IF @Type = 'delete'
    BEGIN   
        BEGIN TRY 
		       INSERT INTO Restore_table (EmployeId, EmployeName, EmployeMail, EmployeAddress)
               SELECT EmployeId, EmployeName, EmployeMail, EmployeAddress
               FROM Record_table
               WHERE EmployeId = @EmployeId;
		IF EXISTS (SELECT 1 FROM Record_table WHERE EmployeId = @EmployeId)
        BEGIN
            -- Perform the deletion
            DELETE FROM Record_table WHERE EmployeId = @EmployeId;

            INSERT INTO Log_table (ErrorMessage, ErrorSeverity, ErrorState,ErrorProcedure,ErrorLine,ErrorNumber,ErrorTime)
            VALUES ('Data deletion succeeded for name: ' + @EmployeName, 0, 0,'',0,0,GETDATE());
        END
        ELSE
        BEGIN
            -- If the record does not exist, insert a log indicating it was not found
            INSERT INTO Log_table (ErrorMessage, ErrorSeverity, ErrorState,ErrorProcedure,ErrorLine,ErrorNumber, ErrorTime)
            VALUES ('Data deletion failed for name: ' + @EmployeName + '. Record not found.', 0, 0,'',0,0,GETDATE());
        END
        END TRY
        BEGIN CATCH
            DECLARE @ErrorMessag NVARCHAR(4000) = ERROR_MESSAGE();
            DECLARE @ErrorSeverit INT = ERROR_SEVERITY();
            DECLARE @ErrorStat INT = ERROR_STATE();
			DECLARE @ErrorProcedur NVARCHAR(128)=Error_Procedure();
			DECLARE	@ErrorLin INT=Error_Line()
	        DECLARE @ErrorNumbe INT=Error_Number()


            INSERT INTO Log_table (ErrorMessage, ErrorSeverity, ErrorState,ErrorProcedure,ErrorLine,ErrorNumber,ErrorTime)
            VALUES ('Data deletion failed for name: ' + @EmployeName + '. Error: ' + @ErrorMessag, @ErrorSeverit, @ErrorStat,@ErrorProcedur,@ErrorLin,@ErrorNumbe, GETDATE());
        END CATCH;
    END;
	 IF @Type = 'UPDATE'
    BEGIN   
        BEGIN TRY 
		  
		IF EXISTS (SELECT 1 FROM Record_table WHERE EmployeId = @EmployeId)
        BEGIN
            -- Perform the UPDATION
              UPDATE  RECORD_TABLE SET EmployeName=@EmployeName,EmployeMail=@EmployeMail,EmployeAddress=@EmployeAddress WHERE EmployeId=@EmployeId;

            INSERT INTO Log_table (ErrorMessage, ErrorSeverity, ErrorState,ErrorProcedure,ErrorLine,ErrorNumber,ErrorTime)
            VALUES ('Data updation succeeded for name: ' + @EmployeName, 0, 0,'',0,0,GETDATE());
        END
        ELSE
        BEGIN
            -- If the record does not exist, insert a log indicating it was not found
            INSERT INTO Log_table (ErrorMessage, ErrorSeverity, ErrorState,ErrorProcedure,ErrorLine,ErrorNumber, ErrorTime)
            VALUES ('Data updationn failed for name: ' + @EmployeName + '. Record not found.', 0, 0,'',0,0,GETDATE());
        END
        END TRY
        BEGIN CATCH
            DECLARE @ErrorMessa NVARCHAR(4000) = ERROR_MESSAGE();
            DECLARE @ErrorSeveri INT = ERROR_SEVERITY();
            DECLARE @ErrorSta INT = ERROR_STATE();
			DECLARE @ErrorProcedu NVARCHAR(128)=Error_Procedure();
			DECLARE	@ErrorLi INT=Error_Line()
	        DECLARE @ErrorNumb INT=Error_Number()


            INSERT INTO Log_table (ErrorMessage, ErrorSeverity, ErrorState,ErrorProcedure,ErrorLine,ErrorNumber,ErrorTime)
            VALUES ('Data updation failed for name: ' + @EmployeName + '. Error: ' + @ErrorMessa, @ErrorSeveri, @ErrorSta,@ErrorProcedu,@ErrorLi,@ErrorNumb, GETDATE());
        END CATCH;
		END;
END;