# Organizador de notas

Aplicación para llevar registro de notas organizadas de manera que permite acceder facilmente a la información que dichas notas contienen.

## Funcionalidad

Esta herramienta organizará las notas en cuadernos representados por directorios, los cuales podran ser creados y elegidos para almacenar las notas, en caso de no especificar ningun cuaderno para una nota ésta se guardara en el cuaderno 'global' que se crea al ejecutar la app, junto con la carpeta '.my_rns', contenedora de todos los cuadernos (en caso de estar creadas no se vuelven a crear).

### Notas

Para acceder a las opciones que ofrece nuestra app para las notas se debe enviar el parametro 'notes' al ejecutar la aplicación:
```bash
$ ruby bin/rn notes
```
Luego se deberá enviar el siguiente parámetro para especificar qué se quiere hacer con la nota.
Comandos para gestionar las notas:

  * ### Crear
    ```bash
    $ ruby bin/rn notes create una_nota --book un_cuaderno
    ```
    Esto indica que se quiere crear una nota de nombre 'una_nota' y usando la opción '--book' se indica con el nombre 'un_cuaderno' que se quiere guardar la nota en ese directorio.
    En caso de no especificar ninguna opción la nota se guardará en el cuaderno 'global'

  * #### Eliminar
    ```bash
    $ ruby bin/rn notes delete una_nota --book un_cuaderno
    ```

  * #### Editar
    ```bash
    $ ruby bin/rn notes edit una_nota --book un_cuaderno
    ```
    Este comando abrirá un editor de texto en consola para modificar la nota y guardar cambios

  * #### Renombrar
    ```bash
    $ ruby bin/rn notes retitle un_nombre_viejo un_nombre_nuevo --book un_cuaderno
    ```
    Con esto se modificará el nombre de la nota 'un_nombre_viejo' a 'un_nombre_nuevo' del cuaderno 'un_cuaderno', en caso de no indicar un directorio se buscará la nota en la carpeta 'global'

  * #### Listar
    ```bash
    $ ruby bin/rn notes list --book un_cuaderno
    ```
    Esta linea listará todas las notas ubicadas en la carpeta 'un_cuaderno', en este caso se le envía a la opcion --book el argumento 'un_cuaderno', si se utiliza la opcion --global se listarán todas las notas almacenadas en la carpeta 'global' (esta opción no necesita ningún argumento), si no se elije ninguna opción se listarán todas las notas de todos los cuadernos.

  * #### Mostrar
    ```bash
    $ ruby bin/rn notes show una_nota --book un_cuaderno
    ```
    Con este comando se mostrará en consola el contenido de la nota.

### Cuadernos

Para acceder a las opciones que ofrece nuestra app para los cuadernos se debe enviar el parametro 'books' al ejecutar la aplicación:
```bash
$ ruby bin/rn books
```
Luego se deberá enviar el siguiente parámetro para especificar qué se quiere hacer con el cuaderno.
Comandos para gestionar cuadernos:

  * #### Crear
    ```bash
    $ ruby bin/rn books create un_cuaderno
    ```
    Esto creará un nuevo directorio llamado 'un_cuaderno' en la carpeta '.my_rns'

  * #### Eliminar
    ```bash
    $ ruby bin/rn delete un_cuaderno
    ```
    Usando este comando se eliminará la carpeta llamada 'un_cuaderno', en caso de no estar vacío se eliminan tambien sus notas, si se usa la opción --global se eliminan solo las notas de esta carpeta.

  * #### Listar
    ```bash
    $ ruby bin/rn list
    ```
    Este comando lista todos los cuadernos

  * #### Renombrar
    ```bash
    $ ruby bin/rn rename titulo_viejo titulo_nuevo
    ```
    Con este comando se renombra el cuaderno de nombre 'titulo_viejo' a 'titulo_nuevo'


### Consideraciones generales a notas y cuadernos

Para cada comando se verificará que los directorios y/o las notas existan, por esto de no ser asi se dará una advertencia