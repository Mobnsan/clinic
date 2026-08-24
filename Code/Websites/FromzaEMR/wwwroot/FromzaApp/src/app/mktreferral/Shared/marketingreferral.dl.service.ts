import { HttpClient, HttpHeaders } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { Observable } from "rxjs";
import { FromzaHTTPResponse } from "../../shared/common-models";
import { ReferralCommission_DTO } from "./DTOs/referral-commission.dto";
import { ReferringOrganization_DTO } from "./DTOs/referral-organization.dto";
import { ReferralParty_DTO } from "./DTOs/referral-party.dto";


@Injectable()
export class MarketingReferralDLService {
    public optionsJson = {
        headers: new HttpHeaders({ 'Content-Type': 'application/json' })
    };
    constructor(public http: HttpClient) {

    }

    public GetInvoiceList(fromDate, toDate): Observable<FromzaHTTPResponse> {
        return this.http.get<FromzaHTTPResponse>(`/api/MarketingReferral/Invoices?FromDate=${fromDate}&ToDate=${toDate}`, this.optionsJson);
    }
    public GetMarketingReferralDetailReport(fromDate, toDate, ReferringPartyId): Observable<FromzaHTTPResponse> {
        return this.http.get<FromzaHTTPResponse>(`/api/MarketingReferral/MarketingreferralDetailReport?FromDate=${fromDate}&ToDate=${toDate}&ReferringPartyId=${ReferringPartyId}`, this.optionsJson);
    }
    public GetBillDetails(billTransactionId): Observable<FromzaHTTPResponse> {
        return this.http.get<FromzaHTTPResponse>(`/api/MarketingReferral/BillDetails?billTransactionId=${billTransactionId}`, this.optionsJson);
    }
    public GetReferralScheme(): Observable<FromzaHTTPResponse> {
        return this.http.get<FromzaHTTPResponse>("/api/MarketingReferral/ReferralScheme", this.optionsJson);
    }
    public GetReferringParty(): Observable<FromzaHTTPResponse> {
        return this.http.get<FromzaHTTPResponse>("/api/MarketingReferral/ReferringParty", this.optionsJson);
    }
    public GetReferringPartyGroup(): Observable<FromzaHTTPResponse> {
        return this.http.get<FromzaHTTPResponse>("/api/MarketingReferral/ReferringPartyGroup", this.optionsJson);
    }
    public GetReferringOrganization(): Observable<FromzaHTTPResponse> {
        return this.http.get<FromzaHTTPResponse>("/api/MarketingReferral/ReferringOrganization", this.optionsJson);
    }
    public GetAlreadyAddedCommission(BillingTransactionId): Observable<FromzaHTTPResponse> {
        return this.http.get<FromzaHTTPResponse>(`/api/MarketingReferral/AlreadyAddedCommission?BillingTransactionId=${BillingTransactionId}`, this.optionsJson);
    }
    public DeleteReferralCommission(ReferralCommissionId): Observable<FromzaHTTPResponse> {
        return this.http.delete<FromzaHTTPResponse>(`/api/MarketingReferral/ReferralCommission?ReferralCommissionId=${ReferralCommissionId}`, this.optionsJson);
    }
    public SaveNewReferral(referralComission_DTO: ReferralCommission_DTO): Observable<FromzaHTTPResponse> {
        return this.http.post<FromzaHTTPResponse>("/api/MarketingReferral/NewReferralComission", referralComission_DTO, this.optionsJson);
    }
    public SaveReferringOrganization(referringOrganization_DTO: ReferringOrganization_DTO): Observable<FromzaHTTPResponse> {
        return this.http.post<FromzaHTTPResponse>("/api/MarketingReferral/NewReferringOrganization", referringOrganization_DTO, this.optionsJson);
    }
    public SaveReferringParty(referralParty_DTO: ReferralParty_DTO): Observable<FromzaHTTPResponse> {
        return this.http.post<FromzaHTTPResponse>("/api/MarketingReferral/NewReferringParty", referralParty_DTO, this.optionsJson);
    }
    public UpdateReferringOrganization(referringOrganization_DTO: ReferringOrganization_DTO): Observable<FromzaHTTPResponse> {
        return this.http.put<FromzaHTTPResponse>("/api/MarketingReferral/ReferringOrganization", referringOrganization_DTO, this.optionsJson);
    }
    public UpdateReferringParty(referringParty_DTO: ReferralParty_DTO): Observable<FromzaHTTPResponse> {
        return this.http.put<FromzaHTTPResponse>("/api/MarketingReferral/ReferringParty", referringParty_DTO, this.optionsJson);
    }
    public ActivateDeactivateOrganization(selectedItem): Observable<FromzaHTTPResponse> {
        return this.http.put<FromzaHTTPResponse>("/api/MarketingReferral/ActivateDeactivateOrganization", selectedItem, this.optionsJson);
    }
    public ActivateDeactivateParty(selectedItem): Observable<FromzaHTTPResponse> {
        return this.http.put<FromzaHTTPResponse>("/api/MarketingReferral/ActivateDeactivateParty", selectedItem, this.optionsJson);
    }
}
