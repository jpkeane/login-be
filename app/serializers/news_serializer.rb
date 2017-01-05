class NewsSerializer < ActiveModel::Serializer
  attributes :id, :title, :date, :body
end
