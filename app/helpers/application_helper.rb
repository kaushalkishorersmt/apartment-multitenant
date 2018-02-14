module ApplicationHelper

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", p: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def get_product_properties(this_product)
    # if this_product.source == "community"
    #   ProductProperty.where(product_id: this_product.source_product_id)
    # else
      ProductProperty.where(product_id: this_product.id)
    # end
  end

end
