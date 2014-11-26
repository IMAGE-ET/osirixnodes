include Warden::Test::Helpers
Warden.test_mode!

feature 'Add Nodes' do
  scenario 'with valid attributes' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    expect(user.nodes).to be_empty

    visit '/'
    
    click_link 'Add Node'
    fill_in 'Name', with: 'My first node'
    fill_in 'Address', with: '1.2.3.4'
    fill_in 'Port', with: 5678
    fill_in 'Aetitle', with: 'MYFIRSTNODE'
    click_button 'Create Node'

    user.reload
    expect(user.nodes).to_not be_empty
    expect(page).to have_content('My first node')
    
    # check that we're on the nodes page
  end

  scenario 'with invalid attributes' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    expect(user.nodes).to be_empty

    visit '/'
    
    click_link 'Add Node'
    fill_in 'Name', with: 'My first node'
    fill_in 'Address', with: '1.2.3.4'
    fill_in 'Port', with: 5678
    fill_in 'Aetitle', with: '' # Missing AETitle
    click_button 'Create Node'

    user.reload
    expect(user.nodes).to be_empty
    expect(page).to have_content(/aetitle/i)
    
    # check that we're on the nodes page
  end

  # 'Explicit Little Endian'           => 0,
  # 'Implicit Little Endian'           => 9,
  # 'JPEG 2000 Lossless'               => 1,
  # 'JPEG 2000 Lossy - High Quality'   => 2,
  # 'JPEG 2000 Lossy - Medium Quality' => 3,
  # 'JPEG 2000 Lossy - Low Quality'    => 4,
  # 'JPEG LS Lossless'                 => 13,
  # 'JPEG LS Lossy - High Quality'     => 15,
  # 'JPEG LS Lossy - Medium Quality'   => 16,
  # 'JPEG LS Lossy - Low Quality'      => 14,
  # 'JPEG Lossless'                    => 5

  scenario 'with default transfer syntax' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    visit '/'
    click_link 'Add Node'
    fill_in 'Name', with: 'My first node'
    fill_in 'Address', with: '1.2.3.4'
    fill_in 'Port', with: 5678
    fill_in 'Aetitle', with: 'MYFIRSTNODE'
    click_button 'Create Node'

    expect(page).to have_content('Explicit Little Endian')
  end

  scenario 'with custom transfer syntax' do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)

    visit '/'
    click_link 'Add Node'
    fill_in 'Name', with: 'My first node'
    fill_in 'Address', with: '1.2.3.4'
    fill_in 'Port', with: 5678
    fill_in 'Aetitle', with: 'MYFIRSTNODE'
    #select('JPEG 2000 Lossless', from: 'Transfer Syntax')
    select('JPEG 2000 Lossless', from: 'node[transfer_syntax_id]')
    click_button 'Create Node'

    expect(page).to have_content('JPEG 2000 Lossless')
  end
end
