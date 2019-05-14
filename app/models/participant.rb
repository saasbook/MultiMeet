
class Participant < ActiveRecord::Base
  belongs_to :project
  has_secure_token :secret_id
  has_many :rankings, :dependent => :destroy
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true,
                    length: { maximum: 100 },
                    uniqueness: { case_sensitive: false, scope: :project },
                    format: { with: VALID_EMAIL_REGEX }
  
  def self.import(file, proj_id)
    alert, success = "", ""
    CSV.foreach(file.path, headers:true) do |row|
      address = row.to_s.gsub("\n", '')
      new = Participant.new(project_id: proj_id.to_i, email: address)
      new.valid? ? (new.save! && success << "#{address} <br/>") : (alert << "For #{address} : #{new.errors.full_messages.first} <br/>")
    end
    return success, alert
  end
end
