CREATE PROCEDURE Data_insertion(
--Decalaring the variable
@EmployeId int,
@EmployeName varchar(10),
@EmployeMail VARCHAR(100),
@EmployeAddress varchar(30)      
)
AS
BEGIN 

--Decalaring parameter to count the inserted rows
 DECLARE @insertcount int
	         
                                                                             --Using exception handling to INSERT without duplicate id
      BEGIN TRY
	                                                                          --Inserting new data
			 INSERT INTO EmailId(EmployeId,EmployeName,EmployeMail,EmployeAddress)VALUES(@EmployeId,@EmployeName,@EmployeMail,@EmployeAddress);
			                                                                  --counting the number of inserted row
			 SET @insertcount=@@ROWCOUNT;
			                                                                  --Updating the log table
			 INSERT INTO ErrorLog (Message,Deletecount,Insertcount, ErrorTime)
             VALUES ('Data insertion succeeded for ID: ' + @EmployeMail,'',@insertcount,GETDATE());
			
	  END TRY

	  BEGIN CATCH 
	                                                                           --Updating log table for dupliacte id 
	          INSERT INTO ErrorLog (Message,Deletecount,Insertcount,ErrorTime)
              VALUES ('Data insertion Unsucceeded for ID: ' + @EmployeMail,'',@insertcount, GETDATE());

	   END CATCH
END;