class RedisObject
  def self.redis
    @connection ||= Redis::Store::Factory.create("#{ENV.fetch('REDIS_HOST','localhost:6379')}", { serializer: nil })
  end

  def self.exists?(id)
    !!redis.get(id)
  end

  def redis
    self.class.redis
  end
end
