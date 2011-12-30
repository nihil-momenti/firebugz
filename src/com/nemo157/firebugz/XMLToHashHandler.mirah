import org.xml.sax.helpers.DefaultHandler
import org.xml.sax.Attributes
import java.util.HashMap
import java.util.ArrayList
import java.util.Stack
import java.lang.StringBuilder
import android.util.Log

class XMLToHashHandler < DefaultHandler
  def initialize
    @result = HashMap.new
  end

  def result
    @result
  end

  def startDocument : void
    Log.d("XMLHandler", "Start document")
    @elements = Stack.new
    @elements.push ElementInfo.new "", :map, HashMap.new
    @text = StringBuilder.new
  end

  def endDocument : void
    Log.d("XMLHandler", "End document")
    @result = HashMap(HashMap(ElementInfo(@elements.pop).value)[:response])
  end

  def startElement namespaceUri:String, localName:String, qName:String, atts:Attributes : void
    attributes = parseAttributes atts
    Log.d("XMLHandler", "Start element: [#{localName}] with #{Helpers.mapToString(attributes)}")
    if attributes[:count]
      @elements.push ElementInfo.new localName, :list, ArrayList.new
    else
      @elements.push ElementInfo.new localName, :map, attributes
    end
  end

  def endElement namespaceUri:String, localName:String, qName:String
    Log.d("XMLHandler", "End element: [#{localName}]")
    last = ElementInfo(@elements.pop)
    prev = ElementInfo(@elements.peek)
    text = @text.toString.trim
    @text = StringBuilder.new
    if text.length > 0 and HashMap(last.value).size == 0
      value = Object(text)
    else
      value = last.value
    end

    if prev.klass == :map
      HashMap(prev.value).put last.name, value
    elsif prev.klass == :list
      ArrayList(prev.value).add value
    end
  end

  def characters chars:char[], start:int, length:int
    newtext = StringBuilder.new
    index = 0
    while index < length
      newtext.append chars[start + index]
      index += 1
    end
    Log.d("XMLHandler", "Characters: [#{newtext}]")
    @text.append newtext.toString
  end

  def parseAttributes atts:Attributes
    length = atts.getLength
    index = 0
    attributes = HashMap.new atts.getLength
    while index < length
      key = atts.getLocalName index
      value = atts.getValue index
      attributes.put key, value
      index += 1
    end
    attributes
  end
end

class ElementInfo
  def initialize name:String, klass:String, value:Object
    @name = name
    @klass = klass
    @value = value
  end

  def name; @name end
  def klass; @klass end
  def value; @value end
end
