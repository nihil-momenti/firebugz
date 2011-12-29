import java.io.InputStream
import javax.xml.parsers.SAXParserFactory
import org.xml.sax.InputSource
import java.util.Map

class XmlParser
  def self.parse xml_stream:InputStream : Map
    xmlReader = SAXParserFactory.newInstance.newSAXParser.getXMLReader
    handler = XMLToHashHandler.new
    xmlReader.setContentHandler handler
    xmlReader.parse InputSource.new xml_stream
    handler.result
  end
end
