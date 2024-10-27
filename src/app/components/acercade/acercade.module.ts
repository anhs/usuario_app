import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { AcercadeRoutingModule } from './acercade-routing.module';
import { AcercadeComponent } from './acercade.component';


@NgModule({
  declarations: [
    AcercadeComponent
  ],
  imports: [
    CommonModule,
    AcercadeRoutingModule
  ]
})
export class AcercadeModule { }
