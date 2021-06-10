# Build / Test

build-webserver:
	docker build -t coco-annotator/webserver .

build-worker:
	docker build -t coco-annotator/worker -f backend/workers/Dockerfile .


# Deployment

oci-push: guard-IMAGE_TAG build-webserver build-worker
	docker tag coco-annotator/webserver fra.ocir.io/lrd2n6cb0knh/coco-annotator/webserver:${IMAGE_TAG}
	docker push fra.ocir.io/lrd2n6cb0knh/coco-annotator/webserver:${IMAGE_TAG}
	docker tag coco-annotator/worker fra.ocir.io/lrd2n6cb0knh/coco-annotator/worker:${IMAGE_TAG}
	docker push fra.ocir.io/lrd2n6cb0knh/coco-annotator/worker:${IMAGE_TAG}


# Helpers

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set"; \
		exit 1; \
	fi
