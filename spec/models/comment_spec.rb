# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  blocked           :boolean          default(FALSE), not null
#  content           :text             not null
#  content_formatted :text             not null
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  post_id           :integer          not null
#  user_id           :integer          not null
#
# Foreign Keys
#
#  fk_rails_03de2dc08c  (user_id => users.id)
#  fk_rails_2fd19c0db7  (post_id => posts.id)
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:post).counter_cache(true) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:content) }

  it 'should convert basic markdown to fill in content_formatted' do
    comment = create(:comment, content: '*Emphasis* is cool!')
    expect(comment.content_formatted).to include('<em>')
  end
end
