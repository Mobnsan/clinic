import { Component, OnInit } from '@angular/core';
import { FromzaRoute } from '../../../security/shared/fromza-route.model';
import { SecurityService } from '../../../security/shared/security.service';

@Component({
  selector: 'app-inv-stock-report-main',
  templateUrl: './inv-stock-report-main.component.html',
  styleUrls: ['./inv-stock-report-main.component.css']
})
export class InvStockReportMainComponent implements OnInit {
  validRoutes: FromzaRoute[];
  constructor(public securityService: SecurityService) {
    this.validRoutes = this.securityService.GetChildRoutes("Inventory/Reports/Stock");
  }
  ngOnInit() {
  }

}

