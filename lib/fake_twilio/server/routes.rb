require 'fake_twilio/server/routes/messages'
require 'fake_twilio/server/routes/phonenumbers'
require 'fake_twilio/server/routes/incomingphonenumbers'

helpers do
  # Optionally write a file, predicated upon the $WRITE_FILES global variable.
  # Any number of directories can be passed to path glob, which will be joined
  # in an OS independent fashion.
  # The full directory structure must exist at the time of testing.
  def write_file(*path, content)
    return unless WRITE_FILES

    prefix = ENV.key?('PREFIX') ? ENV['PREFIX'] : '.'
    File.open(File.join(File.expand_path(prefix), *path), 'w') do |file|
      file.write(content)
    end
  end
end
