CREATE PROCEDURE Deletion_andBackup(
                                       ----Declaring the parameter
@EmployeMail VARCHAR(100)
)
AS
BEGIN 
                                                                             --Declaring the parameter to count the deleted rows
       DECLARE @deletecount int;
        BEGIN   
		                                                                      --Insering the records into backup table before deleting 
					 INSERT backup_data (EmployeId, EmployeName, EmployeMail, EmployeAddress)
					 SELECT EmployeId, EmployeName, EmployeMail, EmployeAddress
					 FROM EmailId WHERE EmployeMail=@EmployeMail;

                                                                              --Deleting the row 
					 DELETE FROM EmailId WHERE EmployeMail=@EmployeMail;

					                                                          --Counting the deleted row
					 SET @deletecount=@@ROWCOUNT;

				                                                           	  --Updating the log table 
					 INSERT INTO ErrorLog (Message,Deletecount,Insertcount,ErrorTime)
					 VALUES ('Data deletion succeeded for ID: '+ @EmployeMail ,@deletecount,'',GETDATE());
	  
	   END ;
	         
END;