USE [y5782_mail]
GO
/****** Object:  StoredProcedure [dbo].[ccCourse_SelectAllPaginated]    Script Date: 2/8/2022 8:12:56 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROC [dbo].[ccCourse_SelectAllPaginated]

		@pageIndex int 
		,@pageSize int
		
AS

/* ----- TEST CODE -----

	DECLARE @pageIndex int = 1
			,@pageSize int = 5;

	EXECUTE [dbo].[ccCourse_SelectAllPaginated] @pageIndex, @pageSize

----- END TEST CODE -----
*/

BEGIN

	DECLARE @offset int = @pageIndex * @pageSize
	
	SELECT 
			c.Id
			,c.[Name] AS courseName
			,c.[Description]
			,st.Season
			,t.[Name] AS teacherName
			,Students = (
					SELECT s.Id AS stuId
							,s.[Name] AS stuName
					FROM dbo.ccStudent AS s INNER JOIN dbo.ccStudentCourses AS sc
							ON sc.StudentId = s.Id
					WHERE sc.StudentId = s.Id
					FOR JSON AUTO
			)

		FROM dbo.[ccCourse] AS c JOIN dbo.ccSeasonTerms AS st
				ON c.SeasonTermId = st.Id
			JOIN dbo.ccTeacher AS t
				ON c.TeacherId = t.Id
			INNER JOIN dbo.ccStudentCourses as sc
				ON c.Id = sc.CourseId
			JOIN dbo.ccStudent AS s
				ON sc.StudentId = s.Id

	ORDER BY c.Id

	OFFSET @offSet ROWS
	FETCH NEXT @pageSize ROWS ONLY

END