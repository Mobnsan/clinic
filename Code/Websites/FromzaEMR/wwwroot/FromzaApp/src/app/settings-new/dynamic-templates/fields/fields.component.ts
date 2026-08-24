import { Component } from '@angular/core';
import { FromzaHTTPResponse } from '../../../shared/common-models';
import { ENUM_FromzaHTTPResponses } from '../../../shared/shared-enums';
import { SettingsService } from '../../shared/settings-service';
import { SettingsBLService } from '../../shared/settings.bl.service';
import { FieldMasterDTO } from '../shared/field-master-dto';
import { TemplateType } from '../shared/template-type.model';

@Component({
  selector: 'app-fields',
  templateUrl: './fields.component.html'
})
export class FieldsComponent {
  public fieldMasterList: Array<FieldMasterDTO> = new Array<FieldMasterDTO>();
  public showGrid: boolean = false;
  public fieldMasterGridColumns: Array<any> = null;

  public templateTypeList: Array<TemplateType> = [];

  constructor(
    public settingsServ: SettingsService,
    public settingsBLService: SettingsBLService,
  ) {
    this.fieldMasterGridColumns = this.settingsServ.settingsGridCols.FieldMasterList;
    this.GetTemplateType();
  }

  GetFieldMasterList(TemplateTypeId: number = null) {
    this.settingsBLService.GetFieldMasterList(TemplateTypeId)
      .subscribe((res: FromzaHTTPResponse) => {
        if (res.Status === ENUM_FromzaHTTPResponses.OK) {
          this.fieldMasterList = res.Results;
          this.showGrid = true;
        }
        else {
          console.error(res.ErrorMessage)
        }

      });

  }
  GetTemplateType() {
    this.settingsBLService.GetTemplateType()
      .subscribe((res: FromzaHTTPResponse) => {
        if (res.Status === ENUM_FromzaHTTPResponses.OK) {
          this.templateTypeList = res.Results;
          if (this.templateTypeList.length) {
            this.GetFieldMasterList();
          }
        }
      })
  }
  onTemplateTypeChange($event) {
    if ($event) {
      const templateTypeId = $event.target.value;
      this.GetFieldMasterList(templateTypeId);
    }
  }
}

