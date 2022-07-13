# Cloud Native

Tener en cuenta entornos actuales: mas dinamicos, evolucionan muy rapido, aparecen nuevas tecnoligias y herramientas.
Cloud native busca construir aplicaciones desacopladas que faciles de gestionar y evolucionar y que sean observables. 
Si juntamos esto con una automatizacion a nivel de construcciom, pruebas, seguridad, despliegue, configuracion,... 
podremos hacer cambios (corregir/mejorar) de manera frequente con un impacto minimo.

# 12 Factor

- Dependencies: Una aplicación “twelve-factor” no depende nunca de la existencia explícita de paquetes instalados en el sistema. Declara todas sus dependencias, completamente y explícitamente, mediante un manifiesto de declaración de dependencias

- Backing services: es cualquier componentes externos como bbdd, brokers de mensajes, servidores de correo, otros servicios que forman parte del funcionamiento de la aplicacion. Bien pues estos pueden ser conectados o desconectados sin cambiar una linea de codigo,  (ej prod cambio a backup)

- Processes: Los procesos “twelve-factor” no tienen estado y no comparten nada. Cualquier información que necesite persistencia se debe almacenar en un ‘backing service’ con estado, habitualmente una base de datos. Tanto el espacio de memoria de un proceso como el sistema de ficheros se pueden usar como si fueran una cache temporal para hacer transacciones.Pero nunca dan por hecho que cualquier cosa cacheada en memoria o en el disco vaya a estar disponible al realizar una petición al ejecutar diferentes procesos.

- Port: Las aplicaciones “twelve factor” son completamente auto-contenidas y no dependen de un servidor web en ejecución.

- Desechabilidad: Los procesos de las aplicaciones “twelve-factor” son desechables, lo que significa que pueden iniciarse o finalizarse en el momento que sea necesario. Los procesos deberían intentar  minimizar el tiempo de arranque y se paran de manera segura

- Logs: Una aplicación “twelve-factor” nunca se preocupa del direccionamiento o el almacenamiento de sus transmisiones de salida. En cada ejecucion escribe sus eventos a la salida estandar.

- Admin process: Tenemos el juego de procesos (tareas habituales de la app como procesar una peticion web) y por otro lado tenemos procesos de administracion (como un script para limpiar algo en bbdd). Estos procesos deben ejectutarse en un entorno identico a los habituales de la aplicacion


# Quarkus

Quarkus es una stack de Java Kubernetes-nativeque une algunas de las mejores y mas usadas librerias de java con nuevas tecnicas y tecnologias que hacen que las
apps sean muy 'pequeñas' y rapidas a la hora de arrancar. Por eso lo de supersonic y subatomic

Es importante saber que la curva de aprendizaje es muy corta, si estamos acostumbrados por ejemplo a SpringBoot, el paso a quarkus es practicamente trivial.

Comparativa

# CRW

Basado en Eclipse che es un entorno de desarrollo integrado en Openshift
Los desarrolladores gastan gran parte de su tiempo manteniendo su entorno de desarrollo.
Como hemos visto la diversidad de tecnologias y rapida evolucion en estos entornos cloud o hibridos hace esta tarea mas compleja. (mas versiones, mas lenguajes de programacion, integraciones,..) por lo que es mas dificil recrear estos entornos en nuestra maquina local

CRW usa contenedores  para generar entornos de desarrollo consistentes, securizados y sin configuracion.
La descripcion del dicho entorno se realiza mediante codigo (broma as code) y nos permite de forma automatica clonar el codigo, añadir las herramientas o plugins para el desaroollo, para las pruebas, o por ejemplo podemos levantar como sidecarcontainer una base de datos.
+ business value

# Jaeger

Es una herramienta que nos permite monitorizar y corregir errores en arquitecturas distribuidas de microsercicios. Permite propagar contextos, monitorizar transacciones, ver latencias,...

span: es una unidad logica, una accion. Tienen inicio, fin y duracion. 

Traza es una coleccion o lista de spans conectados con una relacion de padres/hijos



