require 'spec_helper'

RSpec.describe Ostiary::Policy, type: :model do
  subject { Ostiary::Policy.new(:view) }

  it 'will always yield' do
    expect{ |b| subject.met?(:show, &b) }.to yield_control
  end

  it 'will always yield' do
    expect{ |b| subject.met?(:edit, &b) }.to yield_control
  end

  context 'with method' do
    let(:target) { double }
    subject { Ostiary::Policy.new(:view, method: target.method(:test?)) }

    it 'will call the method' do
      expect(target).to receive(:test?)
      subject.met?(:edit)
    end
  end

end

RSpec.describe Ostiary::PolicyExempted, type: :model do
  subject { Ostiary::PolicyExempted.new(:view, [:edit, :create, :destroy]) }

  it 'will not yield when action is included in rules' do
    expect{ |b| subject.met?(:edit, &b) }.to_not yield_control
  end

  it 'will yield when action is excluded from rules' do
    expect{ |b| subject.met?(:show, &b) }.to yield_control
  end

end

RSpec.describe Ostiary::PolicyLimited, type: :model do
  subject { Ostiary::PolicyLimited.new(:view, [:index, :show]) }

  it 'will not yield when action is excluded from rules' do
    expect{ |b| subject.met?(:edit, &b) }.to_not yield_control
  end

  it 'will yield when action is included in rules' do
    expect{ |b| subject.met?(:show, &b) }.to yield_control
  end

end
