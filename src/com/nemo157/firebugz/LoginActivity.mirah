import android.app.Activity
import android.os.Bundle

class LoginActivity < Activity
  def onCreate(state:Bundle)
    super state
    setContentView R.layout.login
  end
end
