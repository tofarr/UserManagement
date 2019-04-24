
tag = Tag.create(title: 'Admin', immutable: true, grants_admin: true, description: 'Users with administration privledges.')
user = User.create(full_name: 'Admin', password: 'password', password_confirmation: 'password')
UserTag.create(tag: tag, user: user)

user_tag = Tag.create(title: 'Users', immutable: true, apply_by_default: true, description: 'Regular users.')
TagMutex.create(tag_a: tag, tag_b: user_tag)
