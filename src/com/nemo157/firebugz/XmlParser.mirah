import java.io.InputStream
import javax.xml.parsers.SAXParserFactory
import org.xml.sax.InputSource
import java.util.Map

class XmlParser
  def self.parse xml_stream:InputStream : Map
    saxParser = SAXParserFactory.newInstance.newSAXParser
    handler = XMLToHashHandler.new
    saxParser.parse InputSource.new(xml_stream), handler
    handler.result
  end
end
