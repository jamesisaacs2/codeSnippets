USE [y5782_mail]
GO
/****** Object:  StoredProcedure [dbo].[ccCourse_Insert]    Script Date: 2/8/2022 8:32:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[ccCourse_Insert]

			@Name nvarchar(128)
			,@Description nvarchar(128)
			,@SeasonTermId int
			,@TeacherId int
			,@DateCreated datetime2(7)
			,@UserId nvarchar(128)
			,@Id int OUTPUT

AS

/* ----- TEST CODE -----

	DECLARE @Id int = 0;

	DECLARE @Name nvarchar(128) = 'Flutter 102'
			,@Description nvarchar(128) = 'Rock apps with Flutter'
			,@SeasonTermId int = 2
			,@TeacherId int = 2
			,@DateCreated datetime2(7) = GETUTCDATE()
			,@UserId nvarchar(128) = 'jkifao'
		
	EXECUTE [dbo].[ccCourse_Insert]
			@Name
			,@Description
			,@SeasonTermId
			,@TeacherId
			,@DateCreated
			,@UserId
			,@Id OUTPUT

		SELECT @Id

		SELECT * 
		FROM [dbo].[ccCourse]
		WHERE Id = @Id

----- END TEST CODE -----
*/

BEGIN

	INSERT INTO [dbo].[ccCourse]
           ([Name]
           ,[Description]
           ,[SeasonTermId]
           ,[TeacherId]
           ,[DateCreated]
           ,[UserId])

	VALUES ( @Name
			,@Description
			,@SeasonTermId
			,@TeacherId
			,@DateCreated
			,@UserId )

	SET @Id = SCOPE_IDENTITY()

END