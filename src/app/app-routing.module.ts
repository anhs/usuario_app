import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { InicioComponent } from './components/inicio/inicio.component';
import { LoginComponent } from './components/login/login.component';
import { FormularioUsuarioComponent } from './components/formulario-usuario/formulario-usuario.component';
import { authGuard } from './guards/auth.guard';

const routes: Routes = [
  { path: '', redirectTo: '/login', pathMatch: 'full' },
  { path: 'login', component:LoginComponent },
  { path: 'inicio', component: InicioComponent,canActivate: [authGuard] },
  { path: 'registroUsuario', component: FormularioUsuarioComponent },
  { path: 'administracion', loadChildren: () => import('./components/administracion/administracion.module').then(m => m.AdministracionModule) },
  { path: 'acercade', loadChildren: () => import('./components/acercade/acercade.module').then(m => m.AcercadeModule) },
  { path: '**', component: LoginComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
