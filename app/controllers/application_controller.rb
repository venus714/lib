 class ApplicationController < ActionController::Base
    class ApplicationController < ActionController::API
        include ActionController::Cookies
    
        rescue_from StandardError, with: :standard_error
    
        def app_response(message: 'success', status: 200, data: nil)
            render json: {
                message: message,
                data: data
            }, status: status
        end
    
        # hash data into web token
        def encode(uid, email)
            payload = {
                data: {
                    uid: uid,
                    email: email,
                    role: 'admin'
                },
                exp: Time.now.to_i + (6 * 3600)
            }
            begin
                JWT.encode(payload, ENV['task_train_key'], 'HS256')
            rescue JWT::EncodeError => e
                app_response(message: 'failed', status: 400, data: { info: 'Something went wrong. Please try again' })
            end
        end
    
        # unhash the token
        def decode(token)
            begin
                JWT.decode(token, ENV['task_train_key'], true, { algorithm: 'HS256' })
            rescue JWT::DecodeError => e
                app_response(message: 'failed', status: 401, data: { info: 'Your session has expired. Please login again to continue' }) 
            end
        end
        def verify_auth
            auth_headers = request.headers['Authorization']
            if !auth_headers
                app_response(message: 'failed', status: 401, data: { info: 'Your request is not authorized.' }) 
            else
                token = auth_headers.split(' ')[1]
                save_user_id(token)
            end
        end
#     include ActionController::Cookies

#     rescue_from StandardError, with: :standard_error

#     def app_response(message: 'success', status: 200, data: nil)
#         render json: {
#             message: message,
#             data: data
#         }, status: status
#     end
#     def encode(uid, email)
#         payload = {
#             data: {
#                 uid: uid,
#                 email: email,
#                 role: 'admin'
#             },
#             exp: Time.now.to_i + (6 * 3600)
#         }
#         begin
#             JWT.encode(payload, ENV['task_train_key'], 'HS256')
#         rescue JWT::EncodeError => e
#             app_response(message: 'failed', status: 400, data: { info: 'Something went wrong. Please try again' })
#         end
 end
