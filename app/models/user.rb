class User < ActiveRecord::Base
  #保存之前，将email转为小写
  before_save {self.email=email}
  #添加name规则
  validates :name ,presence:true,length: {maximum:50}
  #邮件地址表达式
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #添加email规则
  validates :email,presence:true,length: {maximum:200},format:{with:VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password
end
