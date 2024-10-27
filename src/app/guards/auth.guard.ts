import { inject } from '@angular/core';
import { CanActivateFn, Router } from '@angular/router';
import { ServicioGeneralService } from  'src/app/sevicios/servicio-general.service';

export const authGuard: CanActivateFn = (route, state) => {

  const token = sessionStorage.getItem('token');


    if (token) {
      const permisos = sessionStorage.getItem('permisos');

      return true; 
    } else {
      const router = inject(Router); 
      router.navigate(['/login']); 
      return false;
    }
};
