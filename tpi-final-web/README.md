# Aplicación de notas

#### Version de Ruby: 2.7.1
#### Version de Rails: 6.1.1

### Dependencias de sistema
Es necesario ejecutar 
```bash
bundle install
```
o simplemente 
```bash
bundle 
```
para instalar las gemas especificadas en el archivo Gemfile

### Configuracion de la base de datos
Para utilizar la aplicación es necesario disponer de MySQL instalado.
La configuración de la base de datos se realiza a traves de variables de entorno, la aplicación las buscará en un archivo *.env* en el directorio de trabajo, o bien, usará las que esten configuradas en su computadora. Dichas variables son:
   * DB_USER
   * DB_PASS
   * DB_NAME_DEV
   * DB_NAME_TEST
   * DB_NAME_PROD

### Creación de la base de datos
Dentro del directorio de trabajo se debe ejecutar el siguiente comando para crear la base de datos
```bash
rails db:create
```
luego para correr las migraciones se necesita ejecutar
```bash
rails db:migrate
```
### Inicialización de la base de datos
Para hacer la carga de datos a la base se debe ejecutar
```bash
rails db:seed
```