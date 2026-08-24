import { NgModule } from '@angular/core';
import { Routes, RouterModule, Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { FromzaAutoCompleteModule } from '../../shared/fromza-autocomplete';
import { SharedModule } from '../../shared/shared.module';
import { ReportingService } from '../../reporting/shared/reporting-service';
import { MaternityReportsMatAllowanceComponent } from './maternity-allowance-report/mat-allowance-report.component';
import { MaternityReportsComponent } from './maternity-reports.component';
import { MaternityReportsRoutingModule } from './maternity-reports-routing.module';
import { MaternitySharedModule } from '../shared/maternity-shared-module';



@NgModule({

  providers: [
    ReportingService
  ],

  imports: [
    CommonModule,
    ReactiveFormsModule,
    HttpClientModule,
    FormsModule,
    FromzaAutoCompleteModule,
    SharedModule,
    MaternityReportsRoutingModule,
    MaternitySharedModule
  ],
  declarations: [
    MaternityReportsComponent,
    MaternityReportsMatAllowanceComponent
  ],
  bootstrap: [MaternityReportsComponent]
})
export class MaternityReportsModule {


} 

