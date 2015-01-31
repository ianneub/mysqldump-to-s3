all: build

build:
	docker build -t tutum.co/ianneub/mysqldump_to_s3 .
	@echo "You should now run: docker push tutum.co/ianneub/mysqldump_to_s3"
