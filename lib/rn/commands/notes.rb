module RN
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
          if Dir.exist?("#{Dir.home}/.my_rns/#{book}")
            if File.exist?("#{Dir.home}/.my_rns/#{book}/#{title}.rn") 
              puts "No se puede crear la nota porque el nombre ya existe"
            else
              if title['/'] or title[' '] or title['\\'] 
                puts "El nuevo nombre tiene caracteres invalidos -> '/' '\\' ' ' "
              else
                File.new("#{Dir.home}/.my_rns/#{book}/#{title}.rn", "w")  
                puts "La nota ha sido creada en #{Dir.home}/.my_rns/#{book}/"     
              end
            end
          else
            puts "El directorio ingresado no existe"
          end
          warn "TODO: Implementar creación de la nota con título '#{title}' (en el libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          if Dir.exist?("#{Dir.home}/.my_rns/#{book}/")
            if not File.exist?("#{Dir.home}/.my_rns/#{book}/#{title}.rn")
              puts "La nota ingresada no existe en este directorio: #{Dir.home}/.my_rns/#{book}/"
            else
              File.delete("#{Dir.home}/.my_rns/#{book}/#{title}.rn")
              puts "La nota fue borrada con éxito"
            end
          else
            puts "El directorio ingresado no existe"
          end
          warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          if Dir.exist?("#{Dir.home}/.my_rns/#{book}/")
            if not File.exist?("#{Dir.home}/.my_rns/#{book}/#{title}.rn")
              puts "La nota ingresada no existe en este directorio: #{Dir.home}/.my_rns/#{book}/"
            else
              TTY::Editor.open("#{Dir.home}/.my_rns/#{book}/#{title}.rn")
            end
          else
            puts "El directorio ingresado no existe"
          end
          warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          puts book
          book = "global" if not book
          if Dir.exist?("#{Dir.home}/.my_rns/#{book}/") && File.exist?("#{Dir.home}/.my_rns/#{book}/#{old_title}.rn")
            if File.exist?("#{Dir.home}/.my_rns/#{book}/#{new_title}.rn")
              puts "Ya existe una nota con ese nombre"
            else
              if new_title['/'] or new_title['\\']
                puts "El nuevo nombre tiene caracteres invalidos -> / \\"
              else
                File.rename("#{Dir.home}/.my_rns/#{book}/#{old_title}.rn", "#{Dir.home}/.my_rns/#{book}/#{new_title}.rn")        
              end
            end
          else
            puts "El directorio o la nota no existe"
          end
          warn "TODO: Implementar cambio del título de la nota con título '#{old_title}' hacia '#{new_title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
            Dir.each_child("#{Dir.home}/.my_rns/") {|c| Dir.new("#{Dir.home}/.my_rns/#{c}").each_child { |n| puts n }}
          else
            if Dir.exist?("#{Dir.home}/.my_rns/#{book}/")
              Dir.each_child("#{Dir.home}/.my_rns/#{book}") { |n| puts n }              
            else
              puts "El directorio ingresado no existe"
            end
          end
          warn "TODO: Implementar listado de las notas del libro '#{book}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          if Dir.exist?("#{Dir.home}/.my_rns/#{book}/")
            if not File.exist?("#{Dir.home}/.my_rns/#{book}/#{title}.rn")
              puts "La nota ingresada no existe en este directorio: #{Dir.home}/.my_rns/#{book}/"
            else
              puts File.read("#{Dir.home}/.my_rns/#{book}/#{title}.rn"), :magenta              
            end
          else
            puts "El directorio ingresado no existe"
          end
          warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
