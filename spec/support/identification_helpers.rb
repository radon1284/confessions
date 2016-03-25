module IdentificationHelpers
  def pretend_to_be_visitor(visitor)
    create_cookie("visitor_identifier", visitor.identifier)
  end
end
