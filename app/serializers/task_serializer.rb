class TaskSerializer < ActiveModel::Serializer
  attributes :id, :order, :name, :background_color, :deleted
end
