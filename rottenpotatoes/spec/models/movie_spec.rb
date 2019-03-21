require 'rails_helper'

describe Movie, type: :model do
    
    describe '.all_ratings' do
        
        it 'is a class method' do
           expect(described_class).to respond_to(:all_ratings)
        end
        
        let(:ratings) {['G', 'PG', 'PG-13', 'NC-17', 'R']}
        
        it 'returns all movie ratings' do
           expect(Movie.all_ratings).to eq(ratings) 
        end
        
    end
    
    describe '#find_with_same_director' do
        
        let(:movie) {Movie.new}
        
        it 'is an instance method' do
            expect(movie).to respond_to(:find_with_same_director)
        end
        
        context 'unit test' do
           
           describe 'no other movies with that director' do
               
               let(:movie1) {Movie.new(director: 'Ridley Scott')}
               let(:movie2) {Movie.new(director: 'George Lucas')}
               
               it 'finds the director and only one movie with this director' do
                  
                  allow(movie1).to receive(:director).and_return('Ridley Scott')
                  allow(Movie).to receive(:where).with(director: 'Ridley Scott').and_return([movie1])
                  expect(movie1.find_with_same_director).to eq([movie1])
                   
               end
               
           end
           
           describe 'other movies with that director' do
               let(:movie1) {Movie.new(director: 'Ridley Scott')}
               let(:movie2) {Movie.new(director: 'George Lucas')}
               let(:movie3) {Movie.new(director: 'Ridley Scott')}
               
               it 'finds the director and only one movie with this director' do
                  allow(movie1).to receive(:director).and_return('Ridley Scott')
                  allow(Movie).to receive(:where).with(director: 'Ridley Scott').and_return([movie1, movie3])
                  expect(movie1.find_with_same_director).to eq([movie1, movie3])
               end
           end
            
        end
        
    end
    
end