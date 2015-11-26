	# config/initializers/refile.rb
	require "refile/s3"

	aws = {
	  access_key_id: "AKIAJPQUUNLAIED2KNBQ",
	  secret_access_key: "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",
	  region: "sa-east-1",
	  bucket: "faturas-phone",
	}
	Refile.cache = Refile::S3.new(prefix: "cache", **aws)
	Refile.store = Refile::S3.new(prefix: "store", **aws)