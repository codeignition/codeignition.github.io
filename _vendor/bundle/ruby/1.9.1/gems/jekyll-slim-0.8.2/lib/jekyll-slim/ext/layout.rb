module Jekyll
  class Layout
    def initialize(site, base, name)
      @site = site
      @base = base
      @name = name

      self.data = {}

      self.process(name)
      self.read_yaml(base, name)
      self.transform
    end
  end
end
