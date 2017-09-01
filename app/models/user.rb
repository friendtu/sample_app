class User < ApplicationRecord
    validates :name,presence:true, length:{maximum:50}
    #validates_length_of :name, maximum: 50
    validates :email,presence:true, 
        length: {maximum:255},
        format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i},
        uniqueness: {case_sensitive:false}
        
    before_save {email.downcase!}
    has_secure_password
    validates :password,presence:true,length:{minimum:6}
    
end
