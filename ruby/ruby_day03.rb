# 7 languages in 7 weeks: ruby, day 3

###################################
# some tests from the book...
###################################

# metaprogramming

# method_missing
# method_missing is a "magic" function (like in php,python) that you can intercept 
# and add custom behaviour

# Modules and metaprogramming
# create a class that is a baseclass (like in ActiveRecord) and that generates methods on the fly
# e.g. csv example: using define_method 'name_of_method_as_string' to add method at runtime.
# when putting these in a module, you do not need to use inheritance -> these are Mixins (like in Scala)
# this way cou can e.g. add properties etc. that are retrievd yb teh runtime (e.g. property names of columns on activerevord instance etc)


###################################
# self study
###################################

# 1. modify the CSV application, to support an each method.
# e.g a file containing
# one, two
# lions, tigers
# should be usable like this:
# csv = RubyCsv.new
# csv.each {|row| puts row.one }
# => this should print "lions"

module ActAsCsv

  class CsvHeader

    attr_accessor :column_names

    def initialize(raw_header)
      # use strip to remove leading/trailing whitespace from columnnames
      @column_names = {}
      raw_header.split(',').each_with_index {|col, index| @column_names[col.strip] = index}      
    end

    def index_of_column(column_name)
      # return the key of our dictioanry, which holds the column index
      @column_names[column_name]
    end
  end

  class CsvRow
  
    def initialize(csv_header, raw_line)
      @csv_header = csv_header
      @columns = raw_line.split(',')
    end

    def method_missing(name, *args)
      # we also could generate a class and generate the methods on the fly
      # instead of using method_missing (using define_method)
      column_index = @csv_header.index_of_column(name.to_s)
      # TODO check if index exists etc... not required for understanding right now...
      @columns[column_index]
    end

    def to_s
      @columns.join(',')
    end
  end


  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def act_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read(filenameOrContent)
      @csv_rows = []
      filename = filenameOrContent # self.class.to_s.downcase + '.txt'
            # TODO check if file exists or if filename is already multiline csv string
      if File.exist?(filename)
        iterateableContent = File.new(filename)        
      else
        # assume the content has been passed to the read method
        iterateableContent = filenameOrContent.split(/\r?\n/)       
      end
      # iterableCOntent is either the file, or the passed content splitted per line.
      @header = nil
      iterateableContent.each_with_index do |row, index|
        if index == 0 
          @header = CsvHeader.new(row)
        else
          @csv_rows << CsvRow.new(@header, row)
        end
      end
    end

    attr_accessor :header, :csv_rows
    def initialize filenameOrContent
      read filenameOrContent
    end

    def each(&codeblock)
      @csv_rows.each &codeblock
    end
  end
end

class RubyCsv # no inheritance, just mixins
  include ActAsCsv
  act_as_csv
end

csvContent = "one, two
lions, tigers"

csv = RubyCsv.new csvContent
csv.each {|row| 
#  puts row.to_s
  puts row.one 
}
