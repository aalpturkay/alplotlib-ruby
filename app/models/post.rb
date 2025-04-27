class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :cover_image
  enum :status, { draft: 0, published: 1 }

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  validate :only_images_allowed_in_body

  attribute :views_count, :integer, default: 0

  private
    def only_images_allowed_in_body
      return unless body.body.attachables.any?

      body.body.attachables.each do |attachable|
        next unless attachable.is_a?(ActiveStorage::Blob)

        unless attachable.image?
          errors.add(:body, "Sadece görsel dosyaları yükleyebilirsiniz (JPG, PNG, vs).")
        end

        if attachable.byte_size > 2.megabytes
          errors.add(:body, "Görseller 2MB'den büyük olamaz.")
        end

        allowed_types = %w[image/png image/jpg image/jpeg image/webp]
        unless allowed_types.include?(attachable.content_type)
          errors.add(:body, "Sadece JPG, PNG veya WebP görselleri yükleyebilirsiniz.")
        end
      end
    end
end
