import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { FromzaHTTPResponse } from '../../../../src/app/shared/common-models';
import { VisitService } from '../../appointments/shared/visit.service';
import { SecurityService } from '../../security/shared/security.service';
import GridColumnSettings from '../../shared/fromza-grid/grid-column-settings.constant';
import { MessageboxService } from '../../shared/messagebox/messagebox.service';
import { ENUM_FromzaHTTPResponses, ENUM_MessageBox_Status } from '../../shared/shared-enums';
import { BloodSugarMonitoring } from '../shared/blood-sugar-monitoring.model';
import { IOAllergyVitalsBLService } from '../shared/io-allergy-vitals.bl.service';
import { PatientInfoDTO } from '../shared/patient-info.dto';

@Component({
    selector: 'blood-sugar-monitoring',
    templateUrl: './blood-sugar-monitoring.component.html'
})
export class BloodSugarMonitoringComponent implements OnInit {

    public CurrentBloodSugar: BloodSugarMonitoring = new BloodSugarMonitoring();
    public BloodSugarMonitoringList: Array<BloodSugarMonitoring> = new Array<BloodSugarMonitoring>();
    public showBloodSugarAddBox: boolean = false;
    public selectedIndex: number = null;
    public loading: boolean = false;
    public bloodSugarMonitoringGridColumns: Array<any> = null;
    public patientVisitId: number = null;
    public showBloodSugarMonitoringList: boolean = false;
    public patientInfo: PatientInfoDTO = new PatientInfoDTO();

    constructor(
        private changeDetector: ChangeDetectorRef,
        private securityService: SecurityService,
        private visitService: VisitService,
        private ioAllergyVitalsBLService: IOAllergyVitalsBLService,
        private messageBoxService: MessageboxService
    ) {
        let colSettings = new GridColumnSettings(this.securityService);
        this.bloodSugarMonitoringGridColumns = colSettings.BloodSugar;
        this.patientVisitId = this.visitService.getGlobal().PatientVisitId;
        this.GetPatientBloodSugarList();
    }

    ngOnInit() {
    }

    public AddNewBloodSugar(): void {
        this.selectedIndex = null;
        this.CurrentBloodSugar = new BloodSugarMonitoring();
        this.showBloodSugarAddBox = false;
        this.changeDetector.detectChanges();
        this.showBloodSugarAddBox = true;
    }


    public GetPatientBloodSugarList(): void {
        this.ioAllergyVitalsBLService.GetPatientBloodSugarList(this.patientVisitId)
            .subscribe((res: FromzaHTTPResponse) => {
                if (res.Status === ENUM_FromzaHTTPResponses.OK) {
                    this.BloodSugarMonitoringList = res.Results;
                    this.showBloodSugarMonitoringList = true;
                }
                else {
                    this.messageBoxService.showMessage(ENUM_MessageBox_Status.Failed, ["Failed. please check log for details."], res.ErrorMessage);
                }
            });
    }

    public CallBackBloodSugarUpdate(): void {
        this.GetPatientBloodSugarList();
    }

}

