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
    puts list_gossips[id].author
    puts list_gossips[id].content
    return list_gossips[id]
end

end

