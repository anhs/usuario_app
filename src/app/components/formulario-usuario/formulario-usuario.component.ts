import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ServicioGeneralService } from 'src/app/sevicios/servicio-general.service';

@Component({
  selector: 'app-formulario-usuario',
  templateUrl: './formulario-usuario.component.html',
  styleUrls: ['./formulario-usuario.component.css']
})
export class FormularioUsuarioComponent {

  registroForm: FormGroup;
  
  constructor(private formBuilder: FormBuilder,private request : ServicioGeneralService,) {

    this.registroForm = this.formBuilder.group({
      nombre: ['', Validators.required],
      correo: ['', [Validators.required, Validators.email]],
      direccion: [''],
      telefono: ['', [Validators.required, Validators.pattern('^[0-9]{8}$')]],
      usuario: ['', Validators.required],
      contrasena: ['', [Validators.required, Validators.minLength(10)]]
    });

  }

  guardarUsuario() {

    if (this.registroForm.valid) {
      this.registroForm.value.contrasena = this.request.encriptarContraseña(this.registroForm.value.contrasena)
      console.log('Datos del formulario:', this.registroForm.value);
      this.request.query(
        {
          body: {
            accion: 'guardarUsuario',
            data: {...{accion:"insert"},...this.registroForm.value}
          }
        }
      ).subscribe((res)=>{
          const respuesta = res.respuesta  == 0 ? "info": "success";
          this.request.mensajeServidor(respuesta,res.mensaje,"información");
          this.registroForm.reset();
      })

    } else {
      this.request.mensajeServidor("info","Datos incompletos","Información")
    }
  }
}
