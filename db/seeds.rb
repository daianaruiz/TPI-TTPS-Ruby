# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(fullname: 'Usuario1', email: 'usuario1@mail.com', password: 'usuario1')
user2 = User.create(fullname: 'Usuario2', email: 'usuario2@mail.com', password: 'usuario2')
book1 = Book.create(title: 'Cuaderno1 de 1', user: user1)
book2 = Book.create(title: 'Cuaderno2 de 1', user: user1)
book3 = Book.create(title: 'Cuaderno3 de 1', user: user1)
book4 = Book.create(title: 'Cuaderno1 de 2', user: user2)
book5 = Book.create(title: 'Cuaderno2 de 2', user: user2)
nota1 = Note.create(title:'Nota1',book: book1, content: '# What is Lorem Ipsum?
    **Lorem Ipsum** is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
    ')
nota2 = Note.create(title: 'Nota2', book: book1, content: '# Peliculas
    * Ironman
* Avengers
* Captain America')
nota3 = Note.create(title: 'Nota1', book: book3, content: '* #### Convertir a HTML
    ```bash
    $ ruby bin/rn notes convert una_nota --book un_cuaderno
    ```
    Con este comando se convertirá *una_nota* de *un_cuaderno* a un documento .html
    ```bash
    
    $ ruby bin/rn notes convert --book un_cuaderno
    ```
    ```bash
    $ ruby bin/rn notes convert --global
    ```
    Usando estos comandos (por separado) se convertirán a .html todas las notas almacenadas, ya sea, en *un_cuaderno* o en *global*')
nota4 = Note.create(title: 'Nota1', book: book5, content: '## Lista de compras
    * pan
    * leche
    * huevos')