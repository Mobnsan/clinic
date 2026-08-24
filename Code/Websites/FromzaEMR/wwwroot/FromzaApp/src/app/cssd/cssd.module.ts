import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { CssdRoutingModule } from './cssd-routing.module';
import { CssdMainComponent } from './cssd-main/cssd-main.component';
import { SterilizationComponent } from './cssd-main/sterilization/sterilization.component';
import { ReportsComponent } from './cssd-main/reports/reports.component';
import { SterilizationPendingItemsComponent } from './cssd-main/sterilization/sterilization-pending-items/sterilization-pending-items.component';
import { SterilizationFinalizedItemsComponent } from './cssd-main/sterilization/sterilization-finalized-items/sterilization-finalized-items.component';
import { IntegratedCssdReportComponent } from './cssd-main/reports/integrated-cssd-report/integrated-cssd-report.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { SharedModule } from '../shared/shared.module';
import { HttpClientModule } from '@angular/common/http';
import { FromzaAutoCompleteModule } from '../shared/fromza-autocomplete';
import { DisinfectItemComponent } from './cssd-main/sterilization/sterilization-pending-items/disinfect-item/disinfect-item.component';
import { SterilizationService } from './cssd-main/sterilization/sterilization.service';
import { SterilizationEndpoint } from './cssd-main/sterilization/sterilization.endpoint';
import { CssdReportEndpointService } from './cssd-main/reports/cssd-report.endpoint';

@NgModule({
  providers: [SterilizationService, SterilizationEndpoint, CssdReportEndpointService],
  declarations: [CssdMainComponent, SterilizationComponent, ReportsComponent, SterilizationPendingItemsComponent, SterilizationFinalizedItemsComponent, IntegratedCssdReportComponent, DisinfectItemComponent],
  imports: [CommonModule, CssdRoutingModule, FormsModule, ReactiveFormsModule, SharedModule, FromzaAutoCompleteModule, HttpClientModule]
})
export class CssdModule { }

