import { Component, OnInit } from '@angular/core';
import { FromzaRoute } from '../../../security/shared/fromza-route.model';
import { SecurityService } from '../../../security/shared/security.service';

@Component({
  selector: 'app-inv-purchase-report-main',
  templateUrl: './inv-purchase-report-main.component.html',
  styleUrls: ['./inv-purchase-report-main.component.css']
})
export class InvPurchaseReportMainComponent implements OnInit {

  validRoutes: FromzaRoute[];
  constructor(public securityService: SecurityService) {
    this.validRoutes = this.securityService.GetChildRoutes("Inventory/Reports/Purchase");
  }

  ngOnInit() {
  }

}

