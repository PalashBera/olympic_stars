# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  cattr_accessor :current_user

  strip_attributes only: %i[first_name last_name email], collapse_spaces: true, replace_newlines: true

  validates :first_name, :last_name, :email, presence: true, length: { maximum: 255 }

  def initial
    "#{first_name[0]}#{last_name[0]}".upcase
  end

  def full_name
    [first_name, last_name].join(" ")
  end
end
