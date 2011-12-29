import android.app.Activity
import android.os.Bundle
import android.view.View
import android.widget.EditText
import android.app.Dialog
import android.app.ProgressDialog

class LoginActivity < Activity
  def onCreate state:Bundle
    super state
    setContentView R.layout.login

    @url_edit = EditText(findViewById(R.id.url_edit))
    @email_edit = EditText(findViewById(R.id.email_edit))
    @password_edit = EditText(findViewById(R.id.password_edit))

    @submit_button = findViewById(R.id.submit_button)
  end

  def doSubmit view:View : void
    validate_fields && do_login
  end

  def validate_fields
    return ! (
      @url_edit.getText.toString.trim.isEmpty ||
      @email_edit.getText.toString.trim.isEmpty ||
      @password_edit.getText.toString.trim.isEmpty
    )
  end

  def do_login : void
    dialog = ProgressDialog.show(self, "Logging in", "Logging in, please wait...", true);
    this = self
    Thread.new do
      api_token = this.get_token
      this.finish_login dialog if api_token
    end.start
  end

  def get_token
    fb = FogBugz.new(:url => @url_edit.getText.toString.trim,
                     :email => @email_edit.getText.toString.trim,
                     :password => @password_edit.getText.toString.trim)
    fb.authenticate
  end

  def finish_login dialog:Dialog
    this = self
    @submit_button.post do
      dialog.dismiss
      this.finish
    end
  end
end
