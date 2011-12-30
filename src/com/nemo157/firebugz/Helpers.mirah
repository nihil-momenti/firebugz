import java.util.Map
import java.util.Map.Entry as MapEntry
import java.lang.StringBuilder

class Helpers
  def self.mapToString map:Map
    mapToString map, 1
  end

  def self.mapToString map:Map, indent:int
    builder = StringBuilder.new
    builder.append "{\n"
    map.entrySet.each do |mapping|
      key = MapEntry(mapping).getKey
      value = MapEntry(mapping).getValue
      doIndent indent, builder
      builder.append key
      builder.append " = "
      if value.kind_of? Map
        builder.append mapToString Map(value), indent+1
      else
        builder.append "[#{value}]"
      end
      builder.append "\n"
    end
    doIndent indent-1, builder
    builder.append "}"
    builder.toString
  end

  def self.doIndent level:int, builder:StringBuilder : void
    index = 0
    while index < level
      builder.append "    "
      index += 1
    end
  end
end
