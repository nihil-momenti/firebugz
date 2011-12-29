import java.util.Map.Entry as MapEntry
import java.util.HashMap
import android.net.Uri
import java.net.URL

class HttpRequester
  def self.do_request uri:Uri, path:String, params:HashMap
    uri_builder = uri.buildUpon
    uri_builder.appendPath path
    params.entrySet.each do |mapping|
      key = String(MapEntry(mapping).getKey)
      value = String(MapEntry(mapping).getValue)
      uri_builder.appendQueryParameter key, value
    end
    URL.new(uri_builder.build.toString).openStream
  end
end
