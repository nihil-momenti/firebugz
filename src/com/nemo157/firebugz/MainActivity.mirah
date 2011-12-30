import android.app.Activity
import android.os.Bundle
import android.content.Intent
import android.view.View
import android.widget.Toast
import android.app.Dialog
import android.app.ProgressDialog
import android.util.Log

class MainActivity < Activity
  def onCreate state:Bundle
    super state
    setContentView R.layout.main
  end

  def doLogin view:View : void
    startActivity Intent.new(self, LoginActivity.class)
  end

  def doLogout view:View : void
    dialog = ProgressDialog.show(self, "Logging out", "Logging out, please wait...", true);
    this = self
    Thread.new do
      begin
        fb = FogBugz.new this
        fb.logout
        fb.save_config
        nil
      rescue FogBugzException => e
        Log.e("Logout", "Error logging out", e)
        this.failed_logout
        nil
      ensure
        this.finish_logout dialog
      end
    end.start
  end

  def failed_logout :void
    this = self
    findViewById(R.id.logout).post do
      Toast.makeText(this, "Error logging out", Toast.LENGTH_SHORT).show
    end
  end

  def finish_logout dialog:Dialog : void
    findViewById(R.id.logout).post do
      dialog.dismiss
    end
  end
end
