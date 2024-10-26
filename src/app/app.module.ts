import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { InicioComponent } from './components/inicio/inicio.component';
import { ModalModule } from 'ngx-bootstrap/modal';
import { NgMultiSelectDropDownModule } from 'ng-multiselect-dropdown';
import { TimepickerModule } from 'ngx-bootstrap/timepicker';
import {AsyncPipe} from '@angular/common';


import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';
import { HttpClientModule } from '@angular/common/http';
import { provideAnimations } from '@angular/platform-browser/animations';
import { provideToastr } from 'ngx-toastr';

import { FormsModule,ReactiveFormsModule } from '@angular/forms';
import { LoginComponent } from './components/login/login.component';

@NgModule({
  declarations: [
    AppComponent,
    InicioComponent,
    LoginComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    ModalModule.forRoot(),
    ToastrModule.forRoot(),
    NgMultiSelectDropDownModule.forRoot(),
    TimepickerModule.forRoot(),
    AsyncPipe
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
