import java.util.Map
import java.util.Map.Entry as MapEntry
import java.util.HashMap
import android.net.Uri
import android.content.Context
import android.util.Log

class FogBugz
  def initialize context:Context
    @context = context
    load_config
    begin
      check_api
      @initialized = ! @token.trim.isEmpty
    rescue
      @initialized = false
    end
  end

  def uri; @uri end
  def email; @email end

  def check_api : void
    xml = HttpRequester.do_request @uri, "api.xml", HashMap.new
    result = XmlParser.parse xml
    Log.d(:LOGIN, Helpers::mapToString(result))
    raise FogBugzException.new("API is too old") if parseInt(result[:version]) < 8
    raise FogBugzException.new("API is too new") if parseInt(result[:minversion]) > 8
    @path = String(result[:url])
    @path = @path.substring(0, @path.length-1)
  end

  def parseInt object:Object
    Integer.parseInt(String(object))
  end

  def authenticate args:HashMap
    @uri = Uri.parse(String(args[:uri]))
    check_api

    email = String(args[:email])
    password = String(args[:password])
    result = command(:logon, :email => email, :password => password)

    @email = email
    @token = String(result[:token])
  end

  def command cmd:String, params:HashMap
    params[:token] = @token if @token
    params[:cmd] = cmd
    xml_stream = HttpRequester.do_request @uri, @path, params
    XmlParser.parse xml_stream
  end

  def save_config : void
    Preferences.save @context, :uri => @uri.toString, :email => @email, :token => @token
  end

  def load_config : void
    @uri = Uri.parse Preferences.get @context, :uri
    @email = Preferences.get @context, :email
    @token = Preferences.get @context, :token
  end

  def logout : void
    raise FogBugzException.new("Not initialized") unless @initialized
    command :logoff, HashMap.new
    @token = ""
  end

  class FogBugzException < Exception
    def initialize msg:String
      super
    end
  end
end
