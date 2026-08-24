using FromzaEMR.ServerModel;
using System;
using System.Collections.Generic;

namespace FromzaEMR.Controllers.Stickers.DTOs
{
    public class StickerSettingsAndData_DTO
    {
       public RegistrationStickerSettings_DTO StickerSettings { get; set; }
       public VisitStickerData_DTO StickerData { get; set; }

    }
}

