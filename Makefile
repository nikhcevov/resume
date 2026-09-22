IMAGE := latex-resume

.PHONY: build watch image

image:
	docker build -t $(IMAGE) .

## Build the resume once (PDF + PNG)
build: image
	docker run --rm -v "$(CURDIR):/workspace" $(IMAGE)

## Watch resume.tex and rebuild on change
watch: image
	docker run --rm -it -v "$(CURDIR):/workspace" $(IMAGE) watch
