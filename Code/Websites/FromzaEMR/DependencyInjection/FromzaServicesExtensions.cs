using FromzaEMR.Services;
using FromzaEMR.Services.Admission;
using FromzaEMR.Services.Billing;
using FromzaEMR.Services.ClaimManagement;
using FromzaEMR.Services.Dispensary;
using FromzaEMR.Services.DispensaryTransfer;
using FromzaEMR.Services.DynamicTemplates;
using FromzaEMR.Services.IMU;
using FromzaEMR.Services.Inventory.InventoryDonation;
using FromzaEMR.Services.LIS;
using FromzaEMR.Services.MarketingReferral;
using FromzaEMR.Services.Maternity;
using FromzaEMR.Services.Medicare;
using FromzaEMR.Services.Pharmacy.PharmacyPO;
using FromzaEMR.Services.Pharmacy.Rack;
using FromzaEMR.Services.Pharmacy.SupplierLedger;
using FromzaEMR.Services.ProcessConfirmation;
using FromzaEMR.Services.ProvisionalDischarge;
using FromzaEMR.Services.QueueManagement;
using FromzaEMR.Services.SSF;
using FromzaEMR.Services.Utilities;
using FromzaEMR.Services.Vaccination;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace FromzaEMR.DependencyInjection
{
    /*
        Author: Krishna, 
        Creation: 19thMay'23
        Purpose: 1. Make Startup Clean and Readable
                2. To Achieve Separation of Concerns
                3. Startup class was getting bulky, which leads to less  maintainable code.
                4. DI requires registration of services in the Startup.cs
                5. The number of registrations will increase and become cumbersome to maintain Startup.cs
    */
    public static class FromzaServicesExtensions
    {
        public static IServiceCollection AddFromzaServices(this IServiceCollection services, IConfigurationRoot configuration)
        {
            services.AddTransient<IRackService, RackService>();
            services.AddTransient<IInventoryCompanyService, InventoryCompanyService>();
            services.AddTransient<IDesignationService, DesignationService>();
            services.AddTransient<IInventoryReceiptNumberService, InventoryReceiptNumberService>();
            services.AddTransient<IInventoryGoodReceiptService, InventoryGoodReceiptService>();
            services.AddTransient<IEmailService, EmailService>();
            services.AddTransient<IFractionPercentService, FractionPercentService>();
            services.AddTransient<IFractionCalculationService, FractionCalculationService>();
            services.AddTransient<IVerificationService, VerificationService>();
            services.AddTransient<IDispensaryService, DispensaryService>();
            services.AddTransient<IDispensaryRequisitionService, DispensaryRequisitionService>();
            services.AddTransient<IMaternityService, MaternityService>();
            services.AddTransient<IDispensaryTransferService, DispensaryTransferService>();
            services.AddTransient<IActivateInventoryService, ActivateInventoryService>();
            services.AddTransient<IPharmacyPOService, PharmacyPOService>();
            services.AddTransient<IVaccinationService, VaccinationService>();
            services.AddTransient<ICssdItemService, CssdItemService>();
            services.AddTransient<ICssdReportService, CssdReportService>();
            services.AddTransient<INepaliReceiptService, NepaliReceiptService>();
            services.AddTransient<ISupplierLedgerService, SupplierLedgerService>();
            services.AddTransient<IFileUploadService, GoogleDriveFileUploadService>();
            services.AddTransient<ILISService, LISService>();
            services.AddTransient<IQueueManagementService, QueueManagementService>();
            services.AddTransient<IDonationService, DonationService>();
            services.AddTransient<IIMUService, IMUService>();
            services.AddTransient<ISSFService, SSFService>();
            services.AddTransient<IMedicareService, MedicareService>();
            services.AddTransient<IBillingMasterService, BillingMasterService>();
            services.AddTransient<IClaimManagementService, ClaimManagementService>();
            services.AddTransient<IUtilitiesService, UtilitiesService>();
            services.AddTransient<IProcessConfirmationService, ProcessConfirmationService>();
            services.AddTransient<IAdmissionMasterService, AdmissionMasterService>();
            services.AddTransient<IMarketingReferralService, MarketingReferralService>();
            services.AddTransient<IProvisionalDischargeService, ProvisionalDischargeService>();
            services.AddTransient<IDynamicTemplateService, DynamicTemplateService>();
            return services;
        }
    }
}

