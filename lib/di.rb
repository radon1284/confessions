class DI
  @overrides = {}

  def self.get(clazz)
    @overrides[clazz] || clazz.build
  end

  def self.add_override(clazz, instance)
    @overrides[clazz] = instance
  end

  def self.reset_overrides
    @overrides = {}
  end
end
