import java.util.Map
import java.util.Map.Entry as MapEntry
import java.util.HashMap
import android.net.Uri

class FogBugz
  def initialize args:HashMap
    @uri = Uri.parse(String(args[:uri]))
    if args.containsKey :email
      @email = String(args[:email])
      @password = String(args[:password])
    else
      @token = String(args[:token])
    end
    check_api
  end

  def check_api : void
    xml = HttpRequester.do_request @uri, "api.xml", HashMap.new
    result = XmlParser.parse xml
    raise FogBugzException.new("API is too old") if parseInt(result[:version]) < 8
    raise FogBugzException.new("API is too new") if parseInt(result[:minversion]) > 8
    @path = String(result[:url])
  end

  def parseInt object:Object
    Integer.parseInt(String(object))
  end

  def authenticate
    result = command(:login, :email => @email, :password => @password)
    @token = String(result[:token])
  end

  def command cmd:String, params:HashMap
    params[:token] = @token if @token
    params[:cmd] = cmd
    xml_stream = HttpRequester.do_request @uri, @path, params
    XmlParser.parse xml_stream
  end

  class FogBugzException < Exception
    def initialize msg:String
      super
    end
  end
end
