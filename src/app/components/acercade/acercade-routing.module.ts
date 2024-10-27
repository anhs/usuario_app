import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AcercadeComponent } from './acercade.component';
import { authGuard } from './../../guards/auth.guard';

const routes: Routes = [{ path: '', component: AcercadeComponent,canActivate:[authGuard] }];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class AcercadeRoutingModule { }
