USE [y5782_mail]
GO
/****** Object:  StoredProcedure [dbo].[ccCourse_Update]    Script Date: 2/8/2022 8:13:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[ccCourse_Update]

			@Name nvarchar(128)
			,@Description nvarchar(128)
			,@SeasonTermId int
			,@TeacherId int
			,@Id int

AS

/* ----- TEST CODE -----

	--- FIRST VALIDATE RECORD ---

		DECLARE @Id int = 1;

			SELECT * 
			FROM [dbo].[ccCourse]
			WHERE Id = @Id

	--- VALIDATE @Id , THEN RUN: ---

		DECLARE @Id int = 1;

			SELECT * 
			FROM [dbo].[ccCourse]
			WHERE Id = @Id

		DECLARE @Name nvarchar(128) = 'JS 102'
				,@Description nvarchar(128) = 'JS Improved'
				,@SeasonTermId int = 1
				,@TeacherId int = 1
		
		EXECUTE [dbo].[ccCourse_Update]
				@Name
				,@Description
				,@SeasonTermId
				,@TeacherId
				,@Id

		SELECT @Id

			SELECT * 
			FROM [dbo].[ccCourse]
			WHERE Id = @Id

----- END TEST CODE -----
*/
BEGIN

	UPDATE [dbo].[ccCourse]
		SET [Name] = @Name
           ,[Description] = @Description
           ,[SeasonTermId] = @SeasonTermId
           ,[TeacherId] = @TeacherId
	
	WHERE Id = @Id

END