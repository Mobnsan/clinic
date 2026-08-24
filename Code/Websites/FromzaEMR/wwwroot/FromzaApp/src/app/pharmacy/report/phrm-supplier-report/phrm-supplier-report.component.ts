import { Component, OnInit } from '@angular/core';
import { FromzaRoute } from '../../../security/shared/fromza-route.model';
import { SecurityService } from '../../../security/shared/security.service';

@Component({
  selector: 'app-phrm-supplier-report',
  templateUrl: './phrm-supplier-report.component.html',
  styles: []
})
export class PHRMSupplierReportComponent implements OnInit {

  validRoutes: FromzaRoute[];

  constructor(public securityService: SecurityService) {
    this.validRoutes = this.securityService.GetChildRoutes("Pharmacy/Report/Supplier");
  }
  ngOnInit() {
  }

}

