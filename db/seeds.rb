
tag = Tag.create(title: 'Admin', immutable: true, grants_admin: true, description: 'Users with administration privledges.')
user = User.create(full_name: 'Admin', password: 'password', password_confirmation: 'password')
UserTag.create(tag: tag, user: user)

ClientService.create(title: "User Management",
  tag: tag,
  login_redirect: "/users?client_service_id=<CLIENT_SERVICE_ID>&token=<TOKEN>",
  description: "Service for creating, reading, updating, and deleting users.",
  login_css: ".sessions input[type=submit]{background: #ff7043;}
.sessions a{color: #ff7043;}
.sessions a:focus, .sessions a:hover, .sessions input:focus, .sessions input:hover{border-color: #ff7043;}
.sessions .initials{background:#ff7043;}
::selection{background:rgba(255,112,67,0.4);}")
