using AutoMapper;
using FromzaEMR.ServerModel;
using FromzaEMR.Services.Pharmacy.DTOs.PurchaseOrder;

namespace FromzaEMR.Services.Pharmacy.Mapper.PurchaseOrder
{
    public class PurchaseOrderMappingProfile : Profile
    {
        public PurchaseOrderMappingProfile()
        {
            CreateMap<PurchaseOrder_DTO, PHRMPurchaseOrderModel>().ForMember(dest => dest.PHRMPurchaseOrderItems, act => act.Ignore());
            CreateMap<PurchaseOrderItems_DTO, PHRMPurchaseOrderItemsModel>();
        }
    }
}

