export interface Peticion {
    ruta?:string,
    tipo?:string,
    body:Body
}

export interface Body{
  accion:string,
  data:any
}

export interface Respuesta{
  respuesta: "error" | "success" | "info" | "warning",
  titulo?:string,
  mensaje:string,
  datos?:any
  token?:string
  idSession?:string
}

export interface ActiveToast {
  /** Your Toast ID. Use this to close it individually */
  toastId: number;
  /** the title of your toast. Stored to prevent duplicates if includeTitleDuplicates set */
  title: string;
  /** the message of your toast. Stored to prevent duplicates */
  message: string;
}