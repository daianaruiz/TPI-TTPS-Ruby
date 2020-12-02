module RN
  require 'rn/models.rb'
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Create a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          book = "global" if not book
          if Models::Book.dir_exist?(book)
            if Models::Note.note_exist?(title, book) 
              puts "No se puede crear la nota porque el nombre ya existe", :red
            else
              if not Models::Note.valid_name?(title) 
                puts "El nuevo nombre tiene caracteres invalidos -> '/' '\\' ' ' ", :yellow
              else
                newNote = Models::Note.new(title, book)
                newNote.create()
                puts "La nota ha sido creada en #{newNote.dir_path}/", :green
              end
            end
          else
            puts "El directorio ingresado no existe", :red
          end
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          book = "global" if not book
          if Models::Book.dir_exist?(book)
            if not Models::Note.note_exist?(title, book)
              puts "La nota ingresada no existe en este directorio: #{Dir.home}/.my_rns/#{book}/", :red
            else
              newNote = Models::Note.new(title, book)
              newNote.delete()
              puts "La nota fue borrada con éxito", :green
            end
          else
            puts "El directorio ingresado no existe", :red
          end
        end
      end

      class Edit < Dry::CLI::Command
        require 'tty-editor'
        require 'colorputs'
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          book = "global" if not book
          if Models::Book.dir_exist?(book)
            if not Models::Note.note_exist?(title, book)
              puts "La nota ingresada no existe en este directorio: #{Dir.home}/.my_rns/#{book}/", :red
            else
              newNote = Models::Note.new(title, book)
              newNote.edit
              puts "Los cambios se guardaron correctamente", :green
            end
          else
            puts "El directorio ingresado no existe", :red
          end
        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]

        def call(old_title:, new_title:, **options)
          book = options[:book]
          book = "global" if not book
          if Models::Book.dir_exist?(book) && Models::Note.note_exist?(old_title, book)
            if Models::Note.note_exist?(new_title, book)
              puts "Ya existe una nota con ese nombre", :red
            else
              if Models::Note.valid_name?(new_title)
                newNote = Models::Note.new(old_title, book)
                newNote.rename(new_title)
                puts "El nombre de la nota se actualizó correctamente", :green
              else
                puts "El nuevo nombre tiene caracteres invalidos -> / \\", :yellow
              end
            end
          else
            puts "El directorio o la nota no existe", :red
          end
        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]

        def call(**options)
          book = options[:book]
          global = options[:global]
          book = "global" if global
          if not book
            Models::Note.list.each {|n| puts "nota: #{n.title} cuaderno: #{n.book} "}
          else
            if Models::Book.dir_exist?(book)
              if Models::Book.dir_empty?(book)
                puts "La carpeta está vacía", :yellow
              else
                Models::Note.list_of(book).each {|n| puts n.title}
              end
            else
              puts "El nombre de carpeta ingresado no existe", :red
            end
          end
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]

        def call(title:, **options)
          book = options[:book]
          book = "global" if not book
          if Models::Book.dir_exist?(book)
            if not Models::Note.note_exist?(title, book)
              puts "La nota ingresada no existe en este directorio: #{Dir.home}/.my_rns/#{book}/", :red
            else
              newNote = Models::Note.new(title, book)
              newNote.show
              puts "La nota está vacía" if newNote.note_empty
            end
          else
            puts "El directorio ingresado no existe", :red
          end
        end
      end

      class ConvertHTML < Dry::CLI::Command
        require 'commonmarker'

        desc 'Convert markdown to HTML'
        argument :title, required: false, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        def call(title:nil, **options)
          book = options[:book]
          book = 'global' if options[:global]
          if title && book
            if (Models::Book.dir_exist?(book))
              newNote = Models::Note.new(title, book)
              newNote.convert
            else
              puts "La nota o el directorio no existe", :red
            end
          else
            if(book)
              Models::Note.list_of(book).each do |n|
                n.convert
              end
              puts "Las notas del cuaderno #{Dir.home}/.my_rns/#{book} se convirtieron correctamente", :green
            else
              Models::Note.list.each do |n|
                n.convert
              end
              puts "Las notas de todos los cuadernos se convirtieron correctamente"
            end
          end
        end

      end

    end
  end
end
