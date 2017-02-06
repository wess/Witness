
all: build

clean:
	@swift build --clean=dist

build:
	@swift build

test:
	@swift test

xcode:
	@swift package generate-xcodeproj

run:
	@./build/debug/witness
