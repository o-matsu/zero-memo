.PHONY: build
build:
	dart run build_runner build -d
	dart run flutter_launcher_icons
