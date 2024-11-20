require "test_helper"

class MoviesTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @movie = movies(:one)
    @headers = { 'Content-Type': 'application/json' }
  end

  test "should get index" do
    get movies_url, headers: @headers
    assert_response :success
    assert_not_nil assigns(:movies)
  end

  test "should get recommendations" do
    get recommendations_movies_url(user_id: @user.id), headers: @headers
    assert_response :success
    assert_not_nil assigns(:recommendations)
  end

  test "should get user rented movies" do
    get user_rented_movies_movies_url(user_id: @user.id), headers: @headers
    assert_response :success
    assert_not_nil assigns(:rented)
  end

  test "should rent a movie" do
    assert_difference('@user.rented.count', 1) do
      patch rent_movie_url(user_id: @user.id, id: @movie.id), headers: @headers
    end
    assert_response :success
    @movie.reload
    assert_equal movies(:one).available_copies - 1, @movie.available_copies
  end
end