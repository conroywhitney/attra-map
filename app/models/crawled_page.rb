class CrawledPage < ActiveRecord::Base

  attr_accessible \
    :type,
    :source_id,
    :digest,
    :url,
    :html

end

