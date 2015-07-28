# TODO: Remove example user!
# Example User
user = User.find_or_initialize_by(api_key: 'example')
user.update!(email:    'example@osirixnodes.com',
             password: 'chunkybacon')
             #password: Rails.application.secrets.example_user_password)
user.confirm
#user.confirm! # NOTE: This one is deprecated.

# Example Node
node = user.nodes.first_or_initialize
node.update!(name:    'A boring example node',
             aetitle: 'OSIRIXNODES_COM',
             address: '127.0.0.1',
             port:    11112,
             transfer_syntax: 0)
