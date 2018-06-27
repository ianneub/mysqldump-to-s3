# mysqldump-to-s3

This docker container will backup a MySQL database using mysqldump, stream it to gzip, and stream that to a file on S3.

You must set the following environment variables, or use an IAM Role:
* `AWS_ACCESS_KEY_ID`
* `AWS_SECRET_ACCESS_KEY`

You may optionally set the `DATE_FORMAT` variable to change the date used in the output filename. Be default this is `%Y/%m/%d`.

## To build

    make
