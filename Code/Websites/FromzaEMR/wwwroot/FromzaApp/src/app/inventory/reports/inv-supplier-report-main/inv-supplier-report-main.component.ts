import { Component, OnInit } from '@angular/core';
import { FromzaRoute } from '../../../security/shared/fromza-route.model';
import { SecurityService } from '../../../security/shared/security.service';

@Component({
  selector: 'app-inv-supplier-report-main',
  templateUrl: './inv-supplier-report-main.component.html',
  styleUrls: ['./inv-supplier-report-main.component.css']
})
export class InvSupplierReportMainComponent implements OnInit {

  validRoutes: FromzaRoute[];
  constructor(public securityService: SecurityService) {
    this.validRoutes = this.securityService.GetChildRoutes("Inventory/Reports/Supplier");
  }

  ngOnInit() {
  }

}

