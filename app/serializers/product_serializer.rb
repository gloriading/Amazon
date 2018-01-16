class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :sale_price, :created_at, :updated_at

  belongs_to :user, key: :author

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :full_name
  end

  has_many :reviews

  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :rating, :body, :created_at, :updated_at, :author_full_name

    def author_full_name
      object.user&.full_name
    end

  end

end
