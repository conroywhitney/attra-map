class CrawledPage < ActiveRecord::Base

  attr_accessible \
    :type,
    :digest,
    :url,
    :html

end

