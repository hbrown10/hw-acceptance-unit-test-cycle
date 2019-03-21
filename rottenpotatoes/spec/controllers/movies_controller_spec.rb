require 'rails_helper'

describe MoviesController, type: :controller do
    
  describe '#similar' do
    
    context 'when movie has a director' do
      
      describe 'when only one movie has that director' do
        
        let(:id1) {'1'}
        let(:id2) {'2'}
        let(:movie1) {instance_double('Movie', title: 'Blade Runner', director: 'Ridley Scott')}
        let(:movie2) {instance_double('Movie', title: 'Star Wars', director: 'George Lucas')}
        
        it 'retrieves the director for only one movie' do
          allow(Movie).to receive(:find).and_return(movie1)
          expect(movie1).to receive(:find_with_same_director).and_return([movie1])
          get :similar, :id => id1
        end
        
        it 'makes these results available to the template' do
          allow(Movie).to receive(:find).and_return(movie1)
          allow(movie1).to receive(:find_with_same_director).and_return([movie1])
          get :similar, :id => id1 
          expect(assigns(:movies)).to eq([movie1])
        end
        
        it 'selects similar template for rendering' do
          allow(Movie).to receive(:find).and_return(movie1)
          allow(movie1).to receive(:find_with_same_director).and_return([movie1])
          get :similar, :id => id1 
          expect(response).to render_template('similar')
        end
        
      end
      
      describe 'when multiple movies have that director' do
        
        let(:id1) {'1'}
        let(:id2) {'2'}
        let(:id3) {'3'}
        let(:movie1) {instance_double('Movie', title: 'Blade Runner', director: 'Ridley Scott')}
        let(:movie2) {instance_double('Movie', title: 'Star Wars', director: 'George Lucas')}
        let(:movie3) {instance_double('Movie', title: 'Alien', director: 'Ridley Scott')}

        it 'retrieves the director for multiple movies' do
          allow(Movie).to receive(:find).and_return(movie1)
          expect(movie1).to receive(:find_with_same_director).and_return([movie1, movie3])
          get :similar, :id => id1
        end
        
        it 'makes these results available to the template' do
          allow(Movie).to receive(:find).and_return(movie1)
          allow(movie1).to receive(:find_with_same_director).and_return([movie1, movie3])
          get :similar, :id => id1 
          expect(assigns(:movies)).to eq([movie1, movie3])
        end
        
        it 'selects similar template for rendering' do
          allow(Movie).to receive(:find).and_return(movie1)
          allow(movie1).to receive(:find_with_same_director).and_return([movie1, movie3])
          get :similar, :id => id1 
          expect(response).to render_template('similar')
        end
        
      end
      
    end
    
    context 'when movie has no director' do
      
      describe 'when unable to retrieve director from movie' do
        
        let(:id1) {'1'}
        let(:movie1) {instance_double('Movie', title: 'Blade Runner', director: '')}
        
        it 'retrieves the movie but no director' do
          allow(Movie).to receive(:find).and_return(movie1)
          expect(movie1.director.blank?).to be(true)
          get :similar, :id => id1
        end
        
        it 'sets a flash message' do
          allow(Movie).to receive(:find).and_return(movie1)
          get :similar, :id => id1
          expect(flash[:warning]).to match(/^\'[^']*\' has no director info.$/)
        end
        
        it 'redirects to the movies page' do
          allow(Movie).to receive(:find).and_return(movie1)
          get :similar, :id => id1 
          expect(response).to redirect_to(movies_path)
        end
        
      end
      
    end
    
  end
  
  # write spec tests for other methods!
    
end

