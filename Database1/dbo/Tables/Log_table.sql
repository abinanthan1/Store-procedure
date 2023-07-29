CREATE TABLE [dbo].[Log_table] (
    [LogID]          INT             IDENTITY (1, 1) NOT NULL,
    [ErrorMessage]   NVARCHAR (4000) NULL,
    [ErrorSeverity]  INT             NULL,
    [ErrorState]     INT             NULL,
    [ErrorProcedure] NVARCHAR (128)  NULL,
    [ErrorLine]      INT             NULL,
    [ErrorNumber]    INT             NULL,
    [ErrorTime]      DATETIME        NULL
);

