require "spec_helper"

describe Lita::Handlers::EyTools, lita_handler: true do
  it { routes_command("ey dbdump appname envname").to(:dump_database) }
end
