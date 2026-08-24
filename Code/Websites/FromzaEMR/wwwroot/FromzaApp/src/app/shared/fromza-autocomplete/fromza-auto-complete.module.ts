import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

import { FromzaAutoCompleteComponent } from './fromza-auto-complete.component';
import { FromzaAutoCompleteDirective } from './fromza-auto-complete.directive';
import { FromzaAutoComplete } from './fromza-auto-complete';

@NgModule({
  imports: [CommonModule, FormsModule],
  declarations: [
   FromzaAutoCompleteComponent, 
    FromzaAutoCompleteDirective
  ],
  exports:  [
    FromzaAutoCompleteComponent,
     FromzaAutoCompleteDirective
    ],
  entryComponents: [FromzaAutoCompleteComponent]
})
export class FromzaAutoCompleteModule {
  static forRoot() {
    return {
        ngModule: FromzaAutoCompleteModule,
      providers: [FromzaAutoComplete]
    }
  }
}


