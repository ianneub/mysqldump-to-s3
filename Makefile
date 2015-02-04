all: build

build:
	docker build -t mysqldump_to_s3 .
	@echo "Successfully built mysqldump_to_s3"
