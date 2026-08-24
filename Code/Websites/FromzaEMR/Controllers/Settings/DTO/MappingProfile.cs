using AutoMapper;
using FromzaEMR.ServerModel.BillingModels;

namespace FromzaEMR.Controllers.Settings.DTO
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<BillSchemeDTO, BillingSchemeModel>();
        }
    }
}

