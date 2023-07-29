CREATE TABLE [dbo].[Restore_table] (
    [EmployeId]      INT          NULL,
    [EmployeName]    VARCHAR (10) NULL,
    [EmployeMail]    VARCHAR (20) NOT NULL,
    [EmployeAddress] VARCHAR (30) NULL,
    PRIMARY KEY CLUSTERED ([EmployeMail] ASC)
);

