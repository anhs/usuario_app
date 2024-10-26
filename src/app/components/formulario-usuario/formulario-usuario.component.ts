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
      contraseña: ['', [Validators.required, Validators.minLength(10)]]
    });

  }

  onSubmit() {

    console.log();
    if (this.registroForm.valid) {
      this.registroForm.value.contraseña = this.request.encriptarContraseña(this.registroForm.value.contraseña)
      console.log('Datos del formulario:', this.registroForm.value);
      // Aquí puedes enviar los datos al servidor
    } else {
      console.log('Formulario no válido');
    }
  }
}
