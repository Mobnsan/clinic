import { ComponentFactoryResolver, ComponentRef, Directive, EventEmitter, HostListener, Input, Output, ViewContainerRef } from '@angular/core';
import { FromzaConfirmationDialogComponent } from './fromza-confirmation-dialog.component';

@Directive({
  selector: '[FromzaConfirmationDialog]'
})
export class FromzaConfirmationDirective {
  @Input('title') title: string;
  @Input('message') message: string;
  @Output('confirm') confirm: EventEmitter<void> = new EventEmitter<void>();
  @Output('cancel') cancel: EventEmitter<void> = new EventEmitter<void>();
  private ConfirmationDialogComponentRef: ComponentRef<FromzaConfirmationDialogComponent>;

  constructor(private resolver: ComponentFactoryResolver, private viewContainerRef: ViewContainerRef) { }

  @HostListener('click', ['$event'])
  onClick(event: MouseEvent): void {
    event.preventDefault();
    event.stopPropagation();
    this.showConfirmationDialog();
  }

  private showConfirmationDialog(): void {
    const factory = this.resolver.resolveComponentFactory(FromzaConfirmationDialogComponent);
    this.ConfirmationDialogComponentRef = this.viewContainerRef.createComponent(factory);
    this.ConfirmationDialogComponentRef.instance.title = this.title;
    this.ConfirmationDialogComponentRef.instance.message = this.message;
    this.ConfirmationDialogComponentRef.instance.confirm.subscribe(() => this.confirmAction());
    this.ConfirmationDialogComponentRef.instance.cancel.subscribe(() => this.cancelAction());
  }

  confirmAction(): void {
    this.confirm.emit();
    this.ConfirmationDialogComponentRef.destroy();
  }

  cancelAction(): void {
    this.cancel.emit();
    this.ConfirmationDialogComponentRef.destroy();
  }
}

