import { Input, Component} from '@angular/core';
import { LoadingScreenService } from './fromza-loading-screen.services';

@Component({
    selector: "fromza-loader",
    templateUrl:'./fromza-loader.html' ,
    styleUrls: ['../../../../../themes/theme-default/loading.component.css']
})

export class LoaderComponent {

    @Input("loadingScreen")
    public showLoading: boolean = false;
   
    constructor(public loadingScreenService: LoadingScreenService) {                  
           
    }  
    
  }
  
