module RN
  require 'rn/models.rb'
  module Commands
    module Books
      class Create < Dry::CLI::Command
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'

        example [
          '"My book" # Creates a new book named "My book"',
          'Memoires  # Creates a new book named "Memoires"'
        ]

        def call(name:, **)
          if Models::Book.dir_exist?(name)
            puts "No se puede crear el cuaderno porque el nombre ya existe"
          else
            if Models::Book.valid_name?(name)
              newBook = Models::Book.new (name)
              newBook.create()
              puts "El cuaderno se creó correctamente en #{Dir.home}/.my_rns/"
            else
              puts "El nuevo nombre tiene caracteres invalidos -> '/' '\\' ' '"
            end
          end
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Deletes all notes from the global book',
          '"My book" # Deletes a book named "My book" and all of its notes',
          'Memoires  # Deletes a book named "Memoires" and all of its notes'
        ]

        def call(name: nil, **options)
          global = options[:global]
          name = "global" if global
          if name
            if not Models::Book.dir_exist?(name)
              puts "El directorio no existe"
            else
              newBook = Models::Book.new(name)
              newBook.delete(global)
              if global
                puts "Las notas de global se eliminaron correctamente"
              else
                puts "El cuaderno se eliminó correctamente"
              end
            end
          else
            puts "Se debe proveer un nombre de cuaderno"
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]

        def call(*)
          (Models::Book.list).each {|book| puts book.name}
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]

        def call(old_name:, new_name:, **)
          if not Models::Book.dir_exist?(old_name)
            puts "El directorio no existe"
          else
            if Models::Book.dir_exist?(new_name)
              puts "El nombre de directorio ya existe"
            else
              if Models::Book.valid_name?(new_name)
                newBook = Models::Book.new(old_name)
                newBook.rename(new_name, old_name)
                puts "El cuaderno se renombró correctamente"
              else
                puts "El nuevo nombre tiene caracteres invalidos -> '/' '\\' ' '"
              end
            end
          end
        end
      end
    end
  end
end