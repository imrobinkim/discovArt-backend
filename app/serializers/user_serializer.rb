class UserSerializer < ActiveModel::Serializer
  attributes :id, :favorites
  has_many :favorites
end
