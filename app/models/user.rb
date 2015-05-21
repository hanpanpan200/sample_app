class User < ActiveRecord::Base
  attr_accessor :remember_token
  #保存之前，将email转为小写 ，下面的写法同：before_save {self.email=email.downcase}
  before_save {email.downcase!}
  #添加name规则
  validates :name ,presence:true,length: {maximum:50}
  #邮件地址表达式
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  #添加email规则
  validates :email,presence:true,length: {maximum:200},format:{with:VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  has_secure_password
#添加password最小长度规则
  validates :password,length: {minimum:6}

  #return the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def
  remember
    self.remember_token =User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  def forget
    update_attribute(:remember_digest,nil)
  end
  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
