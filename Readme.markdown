FireBugz
========

This is a simple project to make using FogBugz more enjoyable and learn a bit
about android development at the same time.

There is a lot of really pre-production technology used in this.  Mirah and
Pindah in particular are IMHO not anywhere near usable for production software,
but since this is just a fun project that doesn't really matter.

Setup
=====

There is a bit of setup required cause of the varying pieces of technology
used.  First obviously you need the android SDK, install that along with the
version 10 (2.3.3/2.3.4) platform.  Next you need JRuby as it is required for
Mirah.  Finally the Gemfile should be setup to install Mirah and Pindah along
with their dependencies.

Once setup use the Rake tasks to build and deploy the app.

Easy way (OS X)
---------------

If you use OS X with Homebrew and rvm then the easy installation method is:

    brew install android-sdk
    android
    # Select the version 10 platform and install
    rvm install jruby
    rvm use jruby
    gem install --binstubs=bex
    bex/rake debug install

Others
======

I do have a slight modification to the Pindah source as this is my first time
using Mirah and I like taking a glance at the code that is produced:


    diff --git a/templates/build.xml b/templates/build.xml
    index a440595..631413a 100644
    --- a/templates/build.xml
    +++ b/templates/build.xml
    @@ -25,6 +25,9 @@
           <mirahc dir="src" destdir="bin/classes" jvmversion="1.6">
             <classpath refid="java.classpath" />
           </mirahc>
    +      <mirahc dir="src" destdir="bin/gen_src" jvmversion="1.6" bytecode="false">
    +        <classpath refid="java.classpath" />
    +      </mirahc>
         </target>
     
         <!-- version-tag: 1 -->

