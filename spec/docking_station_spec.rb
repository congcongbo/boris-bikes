require 'docking_station'

describe DockingStation do
  it { is_expected.to respond_to :release_bike }

  let(:bike) { double :bike }

  it 'releases working bikes' do
    bike = double(:bike, broken?:false, working?: true)
    subject.dock(bike)
    expect(subject.release_bike).to be bike
  end

  it 'does not release broken bikes' do
   bike = double(:bike, broken?:true, working?: false)
   subject.dock(bike)
   expect {subject.release_bike}.to raise_error 'No bikes available'
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  describe 'dock' do
    it 'raises an error when full' do
      subject.capacity.times { subject.dock(bike) }
      expect { subject.dock(bike) }.to raise_error 'Docking station full'
    end
  end

  it { is_expected.to respond_to(:bikes) }

  describe '#release_bike' do
    it 'raises an error when there are no bikes available' do
      expect { subject.release_bike }.to raise_error "No bikes available"
    end
  end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  describe 'initialization' do
    subject { DockingStation.new }
    let (:bike) { Bike.new }
    it 'default capacity' do
      described_class::DEFAULT_CAPACITY.times { subject.dock(bike) }
      expect { subject.dock(bike) }.to raise_error 'Docking station full'
    end
  end
end
