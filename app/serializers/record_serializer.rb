class RecordSerializer < ActiveModel::Serializer
  attributes :task_name, :date, :time

  def date
    object.at.to_date
  end

  def time
    object.at.strftime('%k:%M').strip
  end
end
