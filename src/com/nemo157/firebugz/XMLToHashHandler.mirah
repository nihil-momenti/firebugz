import org.xml.sax.helpers.DefaultHandler
import java.util.HashMap

class XMLToHashHandler < DefaultHandler
  def initialize
    @result = HashMap.new
  end

  def result
    @result
  end
end
