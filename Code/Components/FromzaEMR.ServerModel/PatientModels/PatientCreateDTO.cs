using System;

namespace FromzaEMR.ServerModel
{
    public class PatientCreateDTO
    {
        public string Salutation { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string MiddleName { get; set; }
        public string FatherName { get; set; }
        public string MotherName { get; set; }
        public string Gender { get; set; }
        public string Age { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public string PreviousLastName { get; set; }
        public string MaritalStatus { get; set; }
        public string Race { get; set; }
        public string PhoneNumber { get; set; }
        public string LandLineNumber { get; set; }
        public string PassportNumber { get; set; }
        public string Email { get; set; }
        public string IDCardType { get; set; }
        public bool PhoneAcceptsText { get; set; }
        public string IDCardNumber { get; set; }
        public string Occupation { get; set; }
        public string EthnicGroup { get; set; }
        public string BloodGroup { get; set; }
        public string EmployerInfo { get; set; }
        public int CountryId { get; set; }
        public int? CountrySubDivisionId { get; set; }
        public int? MunicipalityId { get; set; }
        public bool HasFile { get; set; }
        public PatientFilesModel ProfilePic { get; set; }
        // Excluded sensitive fields like Ins_InsuranceBalance, IsActive, MedicationPrescriptions, Insurances
    }
}
