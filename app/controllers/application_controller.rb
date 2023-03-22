class ApplicationController < ActionController::APIs

    def encode_token(payload)
        JWT.encode(payload, "secret")
    end

    def decode_token
        # get the token from the headers
        auth_header = request.headers['Authorization']
        # check whether the token is present 
        if auth_header
        # 'Bearer hafshghyklgf' split(' ')[1]
        token = auth_header.split(' ')[1]
        # wrap the decoding process within an exception
     begin 
        JWT.decode(token, 'secret', true, algorithm:'HS256')
     rescue JWT::DecodeError
        nil
     end
  end
end

    def authorised_user
        #  use the decode_token method to get user details
        decode_token =decode_token()

        if decoded_token
             # take out the user id

            user_id = decoded_token[0] ['id']
            # [{payload},{header},{verify_signature}]
            # {
            #     "id":10,
            #     "firstName":"John"
            # }

            # find the user that matches the ID
            user = User.find_by(id: id)
        else 
            render json {error: 'User not found'}, status: :not_found
        end
    end

    def authorize
        render json:{message: "Unauthorized access"}, status: :unauthorized unless 
        authorised_user
    end
end
