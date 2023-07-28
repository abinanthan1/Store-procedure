CREATE TABLE [dbo].[EmailId] (
    [EmployeId]      INT          NOT NULL,
    [EmployeName]    VARCHAR (10) NOT NULL,
    [EmployeMail]    VARCHAR (20) NOT NULL,
    [EmployeAddress] VARCHAR (30) NULL,
    PRIMARY KEY CLUSTERED ([EmployeMail] ASC)
);

