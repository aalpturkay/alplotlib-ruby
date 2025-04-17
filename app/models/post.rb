class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :cover_image
  enum :status, { draft: 0, published: 1 }

  # before_validation :generate_slug, on: :create

  belongs_to :user
  has_many :comments, dependent: :destroy

  validate :only_images_allowed_in_body
  # validates :slug, presence: true, uniqueness: true

  # def to_param
  #   slug
  # end

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

  # def generate_slug
  #   base_slug = title.to_s.parameterize
  #   candidate = base_slug
  #   count = 2

  #   # Aynı slug varsa -2, -3 gibi ekle
  #   while Post.exists?(slug: candidate)
  #     candidate = "#{base_slug}-#{count}"
  #     count += 1
  #   end

  #   self.slug ||= candidate
  # end
end
