json.extract! tag, :id, :code, :title, :description, :immutable, :grants_admin, :apply_only_by_admin, :apply_by_default, :created_at, :updated_at
json.icon_url tag.icon.attachment ? url_for(tag.icon) : nil
