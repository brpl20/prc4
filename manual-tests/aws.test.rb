def amazon_client
 require 'aws-sdk-s3'
  aws_config = Aws.config.update({region: 'us-west-2', credentials: Aws::Credentials.new(
      ENV['AWS_ID'],
      ENV['AWS_SECRET_KEY']
      )})
  @aws_client = Aws::S3::Client.new
  @s3 = Aws::S3::Resource.new(region: 'us-west-2')
end
