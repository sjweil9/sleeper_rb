# frozen_string_literal: true

class BarAssociation
  def self.call
    %w[A B C]
  end
end

class QuxAssociation
  def self.call(num)
    num * 2
  end
end
