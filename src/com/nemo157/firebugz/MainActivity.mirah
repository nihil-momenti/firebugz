import android.app.Activity
import android.os.Bundle
import android.content.Intent
import android.view.View.OnClickListener

class MainActivity < Activity
  def onCreate(state:Bundle)
    super state
    setContentView R.layout.main

    this = self
    findViewById(R.id.temp_button).setOnClickListener do |view|
      this.startActivity Intent.new(this, LoginActivity.class)
    end
  end
end
