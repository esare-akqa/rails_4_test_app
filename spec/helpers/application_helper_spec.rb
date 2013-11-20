require 'spec_helper'

describe 'ApplicationHelper' do
  describe 'full_title' do

    context 'no page title given' do
      it 'should return base title' do
        full_title.should match(/Best app in the universe/)
        full_title.should_not match(/\|/)
      end
    end

    context 'page title given' do
      it 'should return base title with page title' do
        full_title('Foo').should eq("Best app in the universe | Foo")
      end
    end
  end
end