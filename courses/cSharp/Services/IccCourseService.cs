using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using Sabio.Models;
using Sabio.Models.Domain;
using Sabio.Models.Requests.ccCourses;

namespace Sabio.Services.Interfaces
{
	public interface IccCourseService
	{
		int Add(ccCourseAddRequest model, int userId);
		void Update(ccCourseUpdateRequest model, int userId);
		ccCourse GetById(int id);
		void Delete(int id);
		Paged<ccCourse> GetPaginated(int pageIndex, int pageSize);

	}
}
