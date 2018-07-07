require_relative 'middleware/runtime'
require_relative 'middleware/logger'
require_relative 'my_app'

use Runtime
use AppLogger, logdev: File.expand_path('logs/app.log', __dir__)
run MyApp.new