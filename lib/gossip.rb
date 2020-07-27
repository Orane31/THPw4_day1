class Gossip
attr_accessor :author, :content

    def initialize(author, content)
        @author = author
        @content = content
    end
    
    def save
        CSV.open("./db/gossip.csv", "ab") do |csv|
            csv << ["#{@author}", "#{@content}"]
            end
    end

    def self.all
        list_gossips = Array.new
        CSV.read("./db/gossip.csv").each do |csv_line|
            list_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return list_gossips
    end

    def self.find(id)
        list_gossips = self.all
        id = id.to_i
        return list_gossips[id]
    end

    def self.update(id, author, content)
        updated_gossip = []
         CSV.foreach("./db/gossip.csv").with_index do |row, n|
            if n == (id.to_i-1) #si l' id correspond on le met dans l'array
                updated_gossip << [author, content]
            else #sinon on garder l' original
                updated_gossip << [row[0], row[1]]
            end
        end
        CSV.open("./db/gossip.csv", "w") do |csv|
            updated_gossip.each do |row|
                csv << row
            end
        end
    end
end

