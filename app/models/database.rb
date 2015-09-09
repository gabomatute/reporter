class Database < ActiveRecord::Base
  has_many :report_types, dependent: :restrict_with_error

  validates :name, :database, :adapter, presence: true
  validates :adapter, inclusion: { in: %w(postgresql sqlite3) }
  validates :name, uniqueness: true

  attr_encrypted_options.merge!(encode: true, key: ENV["DB_AUTH_ENCRYPT_KEY"])
  attr_encrypted :username 
  attr_encrypted :password

  def connection_info
    {
      database: database,
      adapter: adapter,
      host: host,
      port: port,
      username: username,
      password: password
    }.delete_if { |k,v| v.blank? }
  end

  def connect_to_exec (query)
    connect
    data = exec_query(query)
  rescue
    data = nil
  ensure
    disconnect
    data
  end

  private
    def connect
      Database.establish_connection(connection_info)
    end

    def exec_query (query)
      Database.connection.exec_query(query)
    end

    def disconnect
      Database.remove_connection
    end
end
