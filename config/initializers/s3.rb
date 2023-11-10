# config/initializers/s3.rb
Aws.config.update({
  region: 'US East (Ohio) us-east-2',
  credentials: Aws::Credentials.new('priyanka', 'Priyanka123')
})

S3_BUCKET = Aws::S3::Resource.new.bucket('credits-education-tracker')

