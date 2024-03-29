USE [y5782_mail]
GO
/****** Object:  StoredProcedure [dbo].[ccStudent_Delete]    Script Date: 2/8/2022 8:13:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[ccStudent_Delete]

			@Id int

AS

/* ----- TEST CODE -----

	--- FIRST VALIDATE RECORD ---

		DECLARE @Id int = 5;

			SELECT * 
			FROM [dbo].[ccStudent]
			WHERE Id = @Id

	--- VALIDATE @Id , THEN RUN: ---

		DECLARE @Id int = 5;

			SELECT * 
			FROM [dbo].[ccStudent]
			WHERE Id = @Id
		
		EXECUTE [dbo].[ccStudent_Delete] @Id

			SELECT * 
			FROM [dbo].[ccStudent]
			WHERE Id = @Id

----- END TEST CODE -----
*/
BEGIN

	DELETE FROM [dbo].[ccStudent]
	WHERE Id = @Id;

END
