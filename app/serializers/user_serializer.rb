class UserSerializer < ActiveModel::Serializer

  attributes :id, :first_name, :last_name, :email, :password_digest, :full_name, :is_admin, :address, :longitude, :latitude

  has_many :products
  class ProductSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :price, :sale_price, :created_date, :updated_date, :like_count, :tag_name, :author_full_name

    def created_date
      object.created_at.to_formatted_s(:db)
    end

    def updated_date
      object.updated_at.to_formatted_s(:db)
    end

    def like_count
      object.likes.count # faster
      # object.likes.length # return an array first then the length
    end

    def tag_name
      object.tags.map(&:name).join(', ')
    end

    def author_full_name
      object.user&.full_name
    end

  end


  has_many :reviews
  class ReviewSerializer < ActiveModel::Serializer
    attributes :id, :rating, :body, :created_date, :updated_date, :author_full_name, :love_count

    def love_count
      object.loves.count
    end

    def created_date
      object.created_at.to_formatted_s(:db)
    end

    def updated_date
      object.updated_at.to_formatted_s(:db)
    end

    def author_full_name
      object.user&.full_name
    end

  end


end
