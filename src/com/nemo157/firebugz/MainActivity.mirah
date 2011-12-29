import android.app.Activity
import android.os.Bundle
import android.content.Intent
import android.view.View

class MainActivity < Activity
  def onCreate state:Bundle
    super state
    setContentView R.layout.main
  end

  def doLogin view:View
    startActivity Intent.new(self, LoginActivity.class)
  end
end
