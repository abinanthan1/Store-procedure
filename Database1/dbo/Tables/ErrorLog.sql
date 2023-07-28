CREATE TABLE [dbo].[ErrorLog] (
    [LogID]       INT           IDENTITY (1, 1) NOT NULL,
    [Message]     VARCHAR (100) NULL,
    [Deletecount] INT           NULL,
    [Insertcount] INT           NULL,
    [ErrorTime]   DATETIME      NULL
);

