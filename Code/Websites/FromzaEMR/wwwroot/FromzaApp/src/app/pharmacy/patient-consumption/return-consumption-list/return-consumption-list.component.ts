import { Component } from '@angular/core';
import { FromzaHTTPResponse } from '../../../shared/common-models';
import { NepaliDateInGridColumnDetail, NepaliDateInGridParams } from '../../../shared/fromza-grid/NepaliColGridSettingsModel';
import GridColumnSettings from '../../../shared/fromza-grid/grid-column-settings.constant';
import { GridEmitModel } from '../../../shared/fromza-grid/grid-emit.model';
import { MessageboxService } from '../../../shared/messagebox/messagebox.service';
import { ENUM_FromzaHTTPResponseText, ENUM_MessageBox_Status } from '../../../shared/shared-enums';
import { PharmacyBLService } from '../../shared/pharmacy.bl.service';
import { PHRMPatientConsumption } from '../shared/phrm-patient-consumption.model';
import { ReturnPatientConsumptionDTO } from '../shared/return-patient-consumption-dto.model';

@Component({
  selector: 'app-return-consumption-list',
  templateUrl: './return-consumption-list.component.html',
  host: { '(window:keydown)': 'hotkeys($event)' }

})
export class ReturnConsumptionListComponent {

  PatientConsumptionReturnColumns: Array<any> = null;
  PatientConsumptionReturnList: ReturnPatientConsumptionDTO[] = [];
  NepaliDateInGridSettings: NepaliDateInGridParams = new NepaliDateInGridParams();
  showPrintPage: boolean = false;
  PatientConsumption: PHRMPatientConsumption = new PHRMPatientConsumption();
  isConsumptionReturnReceipt: boolean = false;
  PatientConsumptionReturnReceiptNo: number = null;

  constructor(public pharmacyBLService: PharmacyBLService,
    public messageBoxService: MessageboxService) {
    this.PatientConsumptionReturnColumns = GridColumnSettings.PatientConsumptionReturnColumn;
    this.NepaliDateInGridSettings.NepaliDateColumnList.push(new NepaliDateInGridColumnDetail('CreatedOn', false));
  }

  ngOnInit() {
    this.GetPatientConsumptionReturnList();
  }
  PatientConsumptionReturnGridAction($event: GridEmitModel) {
    switch ($event.Action) {
      case "view": {
        if ($event.Data != null) {
          this.PatientConsumptionReturnReceiptNo = $event.Data.ConsumptionReturnReceiptNo;
          this.showPrintPage = true;
        }
        break;
      }
      default:
        break;
    }
  }

  GetPatientConsumptionReturnList() {
    this.pharmacyBLService.GetPatientConsumptionReturnList().subscribe((res: FromzaHTTPResponse) => {
      if (res.Status === ENUM_FromzaHTTPResponseText.OK) {
        this.PatientConsumptionReturnList = res.Results;
      }
      else {
        this.messageBoxService.showMessage(ENUM_MessageBox_Status.Failed, ['Failed to load data']);
      }
    },
      err => {
        this.messageBoxService.showMessage(ENUM_MessageBox_Status.Failed, ['Failed to load data. See console for more info.']);
      })
  }

  ClosePrintPage() {
    this.showPrintPage = false;
  }

  public hotkeys(event) {
    if (event.keyCode === 27) {
      //For ESC key => close the pop up
      this.ClosePrintPage();
    }
  }

}

