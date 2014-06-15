class CommentSerializer < ActiveModel::Serializer
  attributes :id,
    :nameof_filer,
    :date_received,
    :date_posted,
    :address,
    :view_url,
    :body
end
