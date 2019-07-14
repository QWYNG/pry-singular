class Array
  def extract_pry_singular_options!
    if last.is_a?(Hash)
      pop
    else
      {}
    end
  end
end
