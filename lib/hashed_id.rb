module HashedId
  
  MODEL_SECRET = "gaLm8GuWCGsrJy1QNtEQ"
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def find_by_hashed_id(hashed_id)
      parts = hashed_id.split('.')
      id = parts.shift
      hash = parts.shift
      raise ArgumentError if id.nil? || hash.nil?
      
      object = find(id)
      return nil unless object && object.hashed_id == hashed_id
      object
    end
    
  end

  def hashed_id_length
    6
  end
 
  def hashed_id
    hash_plain = "#{id}&#{MODEL_SECRET}"
    hash = Digest::SHA1.hexdigest(hash_plain)
    ([ id, hash[0, hashed_id_length]]).compact.join(".")
  end
  
end
