# frozen_string_literal: true

# :nodoc:
class BarAssociation
  def self.call
    %w[A B C]
  end
end

# :nodoc:
class QuxAssociation
  def self.call(num)
    num * 2
  end
end
