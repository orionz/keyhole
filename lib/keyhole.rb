
require 'sinatra'

class Keyhole

  def version
    1
  end

  def load_avg
    `uptime` =~ /([0-9.]+) ([0-9.]+) ([0-9.]+)/
    [ $1.to_f, $2.to_f, $3.to_f ]
  end

  def stats
    { :load => load_avg }
  end

  def update
    system "git pull"
    exit
  end

end
