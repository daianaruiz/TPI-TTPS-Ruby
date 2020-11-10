module RN
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
          if Dir.exist?("#{Dir.home}/.my_rns/#{name}/")
            puts "No se puede crear el cuaderno porque el nombre ya existe"
          else
            if name['/'] or name['\\']
              puts "El nuevo nombre tiene caracteres invalidos -> / \\"
            else
              Dir.mkdir("#{Dir.home}/.my_rns/#{name}/")       
            end
          end
          warn "TODO: Implementar creación del cuaderno de notas con nombre '#{name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
          
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
            if Dir.exist?("#{Dir.home}/.my_rns/#{name}/")
              if not Dir.empty?("#{Dir.home}/.my_rns/#{name}/")
                Dir.each_child("#{Dir.home}/.my_rns/#{name}/") {|f| File.delete("#{Dir.home}/.my_rns/#{name}/#{f}")}  
              end
              Dir.rmdir("#{Dir.home}/.my_rns/#{name}/")
            else
              puts "El directorio no existe"
            end

          warn "TODO: Implementar borrado del cuaderno de notas con nombre '#{name}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]

        def call(*)
          Dir.each_child("#{Dir.home}/.my_rns/") {|f| puts f}
          warn "TODO: Implementar listado de los cuadernos de notas.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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
          if Dir.exist?("#{Dir.home}/.my_rns/#{old_name}/")
            if new_name['/'] or new_name['\\']
              puts "El nuevo nombre tiene caracteres invalidos -> / \\"
            else
              File.rename("#{Dir.home}/.my_rns/#{old_name}", "#{Dir.home}/.my_rns/#{new_name}")        
            end    
          else
            puts "El directorio no existe"
          end
          warn "TODO: Implementar renombrado del cuaderno de notas con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
