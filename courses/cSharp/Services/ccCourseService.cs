using Sabio.Data;
using Sabio.Data.Providers;
using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.Addresses;
using Sabio.Models.Requests.ccCourses;
using Sabio.Models.Requests.Friends;
using Sabio.Services.Interfaces;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Services
{
	public class ccCourseService: IccCourseService
	{
		IDataProvider _data = null;

		public ccCourseService(IDataProvider data)
		{
			_data = data;
		}

		//Add (Insert)
		public int Add(ccCourseAddRequest model, int userId)
		{
			int id = 0;

			string procName = "[dbo].[ccCourse_Insert]";
			_data.ExecuteNonQuery(procName,
				inputParamMapper: delegate (SqlParameterCollection col)
				{
					AddCommonParams(model, col);

					SqlParameter idOut = new SqlParameter("@Id", SqlDbType.Int);
					idOut.Direction = ParameterDirection.Output;

					col.Add(idOut);
				},
				returnParameters: delegate (SqlParameterCollection returnCol)
				{
					object oId = returnCol["@Id"].Value;

					int.TryParse(oId.ToString(), out id);
				});
			return id;
		}

		//Update
		public void Update(ccCourseUpdateRequest model, int userId)
		{
			string procName = "[dbo].[ccCourse_Update]";

			_data.ExecuteNonQuery(procName,
				inputParamMapper: delegate (SqlParameterCollection col)
				{
					AddCommonParams(model, col);

					col.AddWithValue("@Id", model.Id);
				},
				returnParameters: null);
		}

		//GetById (Select by Id)
		public ccCourse GetById(int id)
		{
			string procName = "[dbo].[ccCourse_SelectById]";

			ccCourse course = null;

			_data.ExecuteCmd(procName,
				delegate (SqlParameterCollection col)
				{
					col.AddWithValue("@Id", id);
				},
				delegate (IDataReader reader, short set) // single record mapper
				{
					course = MapCourse(reader);
				}
			);
			return course;
		}

		//Delete
		public void Delete(int id)
		{
			string procName = "[dbo].[ccStudent_Delete]";

			_data.ExecuteNonQuery(procName,
				inputParamMapper: delegate (SqlParameterCollection col)
				{
					col.AddWithValue("@Id", id);
				},
				returnParameters: null
			);
		}

		//GetPaginated (Select All Joined)
		public Paged<ccCourse> GetPaginated(int pageIndex, int pageSize)
		{
			string procName = "[dbo].[ccCourse_SelectAllPaginated]";
			Paged<ccCourse> pagedList = null;
			List<ccCourse> list = null;
			int totalCount = 0;

			_data.ExecuteCmd(procName,
				(param) =>
				{
					param.AddWithValue("@PageIndex", pageIndex);
					param.AddWithValue("@PageSize", pageSize);
				},
				(reader, recordSetIndex) =>
				{
					int index = 0;
					ccCourse course = MapCourse(reader);
					totalCount = reader.GetSafeInt32(index++);

					if (list == null)
					{
						list = new List<ccCourse>();
					}
					list.Add(course);
				});
			if (list != null)
			{
				pagedList = new Paged<ccCourse>(list, pageIndex, pageSize, totalCount);
			}
			return pagedList;
		}


		//Mappers follow

		//Mapper - MapCourse (joined)
		private static ccCourse MapCourse(IDataReader reader)
		{
			ccCourse course = new ccCourse();
			int index = 0;

			course.Id = reader.GetSafeInt32(index++);
			course.Name = reader.GetSafeString(index++);
			course.Description = reader.GetSafeString(index++);
			course.SeasonTerm = reader.GetSafeString(index++);
			course.Teacher = reader.GetSafeString(index++);

			string student = reader.GetSafeString(index++);
			if (!string.IsNullOrEmpty(student))
			{
				course.Students = Newtonsoft.Json.JsonConvert.DeserializeObject<List<ccStudent>>(student);
			}

			return course;
		}


		//Mapper - AddCommonParams
		private static void AddCommonParams(ccCourseAddRequest model, SqlParameterCollection col)
		{
			col.AddWithValue("@Name", model.Name);
			col.AddWithValue("@Description", model.Description);
			col.AddWithValue("@SeasonTermId", model.SeasonTermId);
			col.AddWithValue("@TeacherId", model.TeacherId);
			col.AddWithValue("@DateCreated", model.DateCreated);
			col.AddWithValue("@UserId", model.UserId);
		}

	}
}
