import android.content.SharedPreferences
import java.util.HashMap
import java.util.Map.Entry as MapEntry
import android.content.Context

class Preferences
  def self.prefs context:Context
    @prefs ||= context.getApplicationContext.getSharedPreferences "FireBugz", 0
  end

  def self.save context:Context, args:HashMap
    editor = prefs(context).edit
    args.entrySet.each do |mapping|
      key = MapEntry(mapping).getKey
      value = MapEntry(mapping).getValue
      editor.putString key.toString, value.toString
    end
    editor.commit
  end

  def self.get context:Context, key:String
    prefs(context).getString key, ""
  end
end
