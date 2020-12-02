module Models
    module General
        module ClassMethods
            def valid_name?(name)
                not (name['/'] or name['\\'] or name[' '])
            end
            
            def path_home
                "#{Dir.home}/.my_rns/"
            end
        end
        def self.included(a_class)
            a_class.extend(ClassMethods)
        end
    end
    
    class Book
        include General
        
        attr_accessor :name, :path
        
        def initialize(name)
            self.name = name
            self.path = "#{Dir.home}/.my_rns/#{name}/"
        end
        
        def self.dir_exist?(name)
            Dir.exist?("#{Dir.home}/.my_rns/#{name}/")
        end
        
        def create()
            Dir.mkdir(self.path)
        end

        def self.dir_empty?(name)
            Dir.empty?("#{Dir.home}/.my_rns/#{name}/")
        end
        
        def delete(global)
            if not Dir.empty?(self.path)
                Dir.each_child(self.path) {|f| File.delete("#{self.path}/#{f}")}  
            end
            if not global
                Dir.rmdir(self.path)
            end  
        end
        
        def self.list()
            arr_childs = Array.new
            Dir.each_child("#{Dir.home}/.my_rns/") { |f| arr_childs << Book.new(f) }
            arr_childs
        end
        
        def rename(new_name, old_name)
            self.path = "#{Book.path_home}/#{new_name}"
            File.rename("#{Book.path_home}/#{old_name}", self.path)
        end
    end
    
    class Note
        include General
        attr_accessor :title, :book, :path
        
        def initialize(title, book)
            self.title = title
            self.book = book
            self.path = "#{Dir.home}/.my_rns/#{book}/#{title}.rn"
        end
        
        def dir_path()
            "#{Dir.home}/.my_rns/#{book}"
        end
        
        def self.note_exist?(title, book)
            File.exist?("#{Dir.home}/.my_rns/#{book}/#{title}.rn")
        end

        def note_empty()
            File.zero?("#{Dir.home}/.my_rns/#{self.book}/#{self.title}.rn")
        end
        
        def create()
            File.new("#{Dir.home}/.my_rns/#{self.book}/#{self.title}.rn", "w")
        end

        def delete()
            File.delete("#{self.path}")
        end

        def edit
            TTY::Editor.open("#{Dir.home}/.my_rns/#{book}/#{title}.rn")
        end

        def rename(new_title)
            File.rename("#{self.path}", "#{self.dir_path}/#{new_title}.rn")
            self.title = new_title
        end

        def self.list
            arr_notes = Array.new
            Dir.each_child("#{self.path_home}") {|c| Dir.new("#{self.path_home}#{c}").each_child do |n|
                if (n.end_with?('.rn'))
                    arr_notes << Note.new(n.delete_suffix('.rn'), c)
                end
            end
            }
            arr_notes
        end

        def self.list_of(book)
            arr_notes = Array.new
            Dir.each_child("#{Dir.home}/.my_rns/#{book}") do |n|
                if (n.end_with?('.rn'))
                    arr_notes << new(n.delete_suffix('.rn'), book)
                end
            end
            arr_notes
        end

        def show
            puts File.read("#{Dir.home}/.my_rns/#{self.book}/#{self.title}.rn"), :magenta
        end

        def convert
            file = File.read("#{self.dir_path}/#{self.title}.rn")
            nuevo = File.new("#{self.dir_path}/#{self.title.delete_suffix('.rn')}.html", "w")
            nuevo.puts(CommonMarker.render_html(file, :DEFAULT))
            nuevo.close
        end
    end
end