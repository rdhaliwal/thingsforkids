class SearchListings
  attr_reader :params
  attr_reader :session

  def self.call(params, session)
    self.new(params, session).call
  end

  def initialize(params, session)
    @params = params
    @session = session
  end

  def call
    Listing.search query, where: conditions, order: order
  end

  private

    def query
      params[:query].presence || "*"
    end

    def conditions
      conditions = {}
      conditions[:location]       = near_condition if session[:postcode].present?
      conditions[:location]       = frame_coordinates if params[:l].present?
      conditions[:activity_type]  = params[:activity_type] if params[:activity_type].present?
      conditions[:days_available] = days_condition if params[:days_available].present?
      conditions[:status]         = :active
      conditions[:min_age]        = min_age if params[:age].present?
      conditions[:max_age]        = max_age if params[:age].present?
      conditions
    end

    def frame_coordinates
      sw_lat, sw_lng, ne_lat, ne_lng = params[:l].split(",")
      {
        top_left: {
          lat: ne_lat,
          lon: sw_lng
        },
        bottom_right: {
          lat: sw_lat,
          lon: ne_lng
        }
      }
    end

    def near_condition
      {
        near: {
          lat: session[:lat],
          lon: session[:lng]
        },
        within: "50mi"
      }
    end

    def days_condition
      {
        all: params[:days_available]
      }
    end

    def min_age
      { gte: params[:age][:min_age] }
    end

    def max_age
      { lte: params[:age][:max_age] }
    end

    def order
      { listing_type: :desc }
    end
end
