import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { forkJoin } from "rxjs";
import { FromzaHTTPResponse } from "../../shared/common-models";

@Injectable()
export class AdmissionMasterDlService {
  public jsonOptions = {
    headers: new HttpHeaders({ 'Content-Type': 'application/json' })
  };
  constructor(private _httpClient: HttpClient) {
  }

  public GetSchemeAdtAutoBillingItemsAndDepositSettings(schemeId: number, priceCategoryId: number, serviceBillingContext: string) {
    const adtSchemeAutoBillingItems = this._httpClient.get<FromzaHTTPResponse>(`/api/AdmissionMaster/SchemeAdtAutoBillingItems?schemeId=${schemeId}&priceCategoryId=${priceCategoryId}&serviceBillingContext=${serviceBillingContext}`, this.jsonOptions);
    const adtSchemeDepositSettings = this._httpClient.get<FromzaHTTPResponse>(`/api/AdmissionMaster/SchemeAdtDepositSettings?schemeId=${schemeId}&priceCategoryId=${priceCategoryId}&serviceBillingContext=${serviceBillingContext}`, this.jsonOptions);

    return forkJoin([adtSchemeAutoBillingItems, adtSchemeDepositSettings]);
  }
  public GetSchemeAdtAutoBillItems(schemeId: number, priceCategoryId: number, serviceBillingContext: string) {
    return this._httpClient.get<FromzaHTTPResponse>(`/api/AdmissionMaster/SchemeAdtAutoBillingItems?schemeId=${schemeId}&priceCategoryId=${priceCategoryId}&serviceBillingContext=${serviceBillingContext}`, this.jsonOptions);
  }
  public GetBedFeatureSchemePriceCategoryMap(schemeId: number) {
    return this._httpClient.get<FromzaHTTPResponse>(`/api/AdmissionMaster/BedFeatureSchemePriceCategoryMap?schemeId=${schemeId}`, this.jsonOptions);
  }
}

