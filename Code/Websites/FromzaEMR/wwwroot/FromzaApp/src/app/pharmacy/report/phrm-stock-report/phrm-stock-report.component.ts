import { Component, OnInit } from '@angular/core';
import { FromzaRoute } from '../../../security/shared/fromza-route.model';
import { SecurityService } from '../../../security/shared/security.service';

@Component({
  selector: 'app-phrm-stock-report',
  templateUrl: './phrm-stock-report.component.html',
  styles: []
})
export class PHRMStockReportComponent {
  validRoutes: FromzaRoute[];

  constructor(public securityService: SecurityService) {
    this.validRoutes = this.securityService.GetChildRoutes("Pharmacy/Report/Stock");
  }
}

