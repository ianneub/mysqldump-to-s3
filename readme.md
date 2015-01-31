# mysqldump-to-s3

This docker container will backup a MySQL database using mysqldump, stream it to gzip, and stream that to a file on S3.

## To build

    make
