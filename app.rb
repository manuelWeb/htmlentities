# encoding: UTF-8
require 'slim'
require 'htmlbeautifier' 
require 'htmlentities'
Slim::Engine.set_options pretty: true, sort_attrs: false

class Slimed
  attr_accessor :src, :out
  def initialize(src,out)
    @src = src
    @out = out
  end
  
  def tohtml
    # ouverture src en lecture
    srcfile = File.open(src, "rb").read
    s2h = Slim::Template.new{srcfile}
    htmlrender = s2h.render
    beautiful = HtmlBeautifier.beautify(htmlrender, tab_stops: 2)
    # ecriture du fichier out = Slimed.new(src,**out**) > return beautiful
    File.open(out, "w") do |go|
      go.puts beautiful
    end
  end

  def htmlEncodeEnt
    coder = HTMLEntities.new
    html = File.open(out).read
    coder.encode(html, :named).gsub(/&lt;/, "<").gsub(/&gt;/, ">").gsub(/&apos;/, "'").gsub(/&quot;/, '"')
  end

end

fr = Slimed.new('indexC.slim', 'indexC.html')
fr.tohtml
puts fr.htmlEncodeEnt

# system("explorer #{fr.out}")